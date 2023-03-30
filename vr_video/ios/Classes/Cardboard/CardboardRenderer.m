/* Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#import "CardboardRenderer.h"

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

#define LOG_TAG "HelloCardboardCPP"
#define LOGW(...) NSLog(@__VA_ARGS__)

static const float kDefaultFloorHeight = -1.7f;

static const uint64_t kPredictionTimeWithoutVsyncNanos = 50000000;

/**
 * Default near clip plane z-axis coordinate.
 */
static const float kZNear = 0.1f;
/**
 * Default far clip plane z-axis coordinate.
 */
static const float kZFar = 100.f;


@interface CardboardRenderer ()
{
    CardboardLensDistortion *_lensDistortion;
    CardboardHeadTracker *_headTracker;
    CardboardDistortionRenderer *_distortionRenderer;
    int _width;
    int _height;
    GLuint _depthRenderBuffer;
    GLuint _eyeTexture;
    GLuint _fbo;
    
    GLKMatrix4 _headView;
    
    // TODO Init these?
    CardboardEyeTextureDescription _leftEyeTexture;
    CardboardEyeTextureDescription _rightEyeTexture;
    float _projMatrices[2][16];
    float _eyeMatrices[2][16];
    
    // Custom
    NSString *_videoPath;
    int _countdown;
    
    // Callback
    bool (^_callback)(void);
    
    // SceneKit Objects
    SCNRenderer *_renderer;
    SCNNode *_cameraNode;
    SCNNode *_sphereNode;
    SCNNode *_audioNode;
      
    // AVAssetReader Objects
    AVAssetReader *_reader;
    AVAssetReaderTrackOutput *_trackReaderOutput;
    AVAssetTrack *_track;
    AVPlayer *_player;
      
    NSDate *_previousFrame;
    double _frameSkip;
}

@end

@implementation CardboardRenderer

+ (id)createWithVideoPath:(NSString *)videoPath withCountdown:(int)countdown lensDistortion:(CardboardLensDistortion *)lensDistortion headTracker:(CardboardHeadTracker *)headTracker width:(int)width height:(int)height withCallback:(bool (^)(void))callback {
    return [[CardboardRenderer alloc] initWithVideoPath:videoPath withCountdown:countdown lensDistortion:lensDistortion headTracker:headTracker width:width height:height withCallback:callback];
}

- (id)initWithVideoPath:(NSString *)videoPath withCountdown:(int)countdown lensDistortion:(CardboardLensDistortion *)lensDistortion headTracker:(CardboardHeadTracker *)headTracker width:(int)width height:(int)height withCallback:(bool (^)(void))callback {
    _lensDistortion = lensDistortion;
    _headTracker = headTracker;
    _distortionRenderer = nil;
    _width = width;
    _height = height;
    _depthRenderBuffer = 0;
    _eyeTexture = 0;
    _fbo = 0;
    
    _videoPath = videoPath;
    _countdown = countdown;
    
    _callback = callback;
    
    srand(2);
    
    [self initGL];
    
    return self;
}

- (void)dealloc {
    // TODO
}

#pragma mark - Renderer Init

- (void)initGL {
    glGenTextures(1, &_eyeTexture);
    glBindTexture(GL_TEXTURE_2D, _eyeTexture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, _width, _height, 0, GL_RGB, GL_UNSIGNED_BYTE, 0);

    _leftEyeTexture.texture = _eyeTexture;
    _leftEyeTexture.left_u = 0;
    _leftEyeTexture.right_u = 0.5;
    _leftEyeTexture.top_v = 1;
    _leftEyeTexture.bottom_v = 0;

    _rightEyeTexture.texture = _eyeTexture;
    _rightEyeTexture.left_u = 0.5;
    _rightEyeTexture.right_u = 1;
    _rightEyeTexture.top_v = 1;
    _rightEyeTexture.bottom_v = 0;
    //CheckGLError("Create Eye textures");

    // Generate depth buffer to perform depth test.
    glGenRenderbuffers(1, &_depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, _width, _height);
    //CheckGLError("Create Render buffer");

    glGenFramebuffers(1, &_fbo);
    glBindFramebuffer(GL_FRAMEBUFFER, _fbo);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, _eyeTexture, 0);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);

    //CheckGLError("Create Frame buffer");

    CardboardLensDistortion_getEyeFromHeadMatrix(_lensDistortion, kLeft, _eyeMatrices[kLeft]);
    CardboardLensDistortion_getEyeFromHeadMatrix(_lensDistortion, kRight, _eyeMatrices[kRight]);
    CardboardLensDistortion_getProjectionMatrix(_lensDistortion, kLeft, kZNear, kZFar, _projMatrices[kLeft]);
    CardboardLensDistortion_getProjectionMatrix(_lensDistortion, kRight, kZNear, kZFar, _projMatrices[kRight]);

    CardboardMesh leftMesh;
    CardboardMesh rightMesh;
    CardboardLensDistortion_getDistortionMesh(_lensDistortion, kLeft, &leftMesh);
    CardboardLensDistortion_getDistortionMesh(_lensDistortion, kRight, &rightMesh);

    _distortionRenderer = CardboardOpenGlEs2DistortionRenderer_create();
    CardboardDistortionRenderer_setMesh(_distortionRenderer, &leftMesh, kLeft);
    CardboardDistortionRenderer_setMesh(_distortionRenderer, &rightMesh, kRight);
    //CheckGLError("Cardboard distortion renderer set up");

    [self initSceneKit];
}

- (void)initSceneKit {
    // Setup SceneKit Scene
    SCNScene *scene = [SCNScene scene];
    SCNNode *cameraNode = [SCNNode node];
    SCNCamera *camera = [SCNCamera camera];
    cameraNode.camera = camera;
    _cameraNode = cameraNode;
    [scene.rootNode addChildNode:cameraNode];
    
    // Audio Node
    // TODO Remove invisible Video
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSURL *localURL = [[NSURL alloc] initFileURLWithPath:_videoPath];
    _player = [AVPlayer playerWithURL:localURL];
    SCNSphere *audioSphere = [SCNSphere sphereWithRadius:1.0];
    _audioNode = [SCNNode nodeWithGeometry:audioSphere];
    _audioNode.geometry.firstMaterial.diffuse.contents = _player;
    _audioNode.position = SCNVector3Make(200,0,0);
    [scene.rootNode addChildNode:_audioNode];
    
    // Start Video Player
    [self startVideo];

    SCNSphere *sphere = [SCNSphere sphereWithRadius:20.0];
    sphere.firstMaterial.doubleSided = true;
    _sphereNode = [SCNNode nodeWithGeometry:sphere];
    _sphereNode.geometry.firstMaterial.diffuse.contents = [UIColor whiteColor]; // Set first Frame here?
    _sphereNode.position = SCNVector3Make(0,0,0);
    [scene.rootNode addChildNode:_sphereNode];
    
    // Setup SceneKit Renderer
    EAGLContext *context = [EAGLContext currentContext];
    SCNRenderer *renderer = [SCNRenderer rendererWithContext:context options:nil];
    renderer.scene = scene;
    renderer.pointOfView = cameraNode;
    renderer.playing = YES;
    renderer.autoenablesDefaultLighting = YES;
    _renderer = renderer;
    
    // Set internal frame counter
    _previousFrame = [NSDate date];
}

- (void)startVideo {
    // Start and reset Audio
    [_player seekToTime:kCMTimeZero];
    [_player play];
    
    // Load local video asset
    NSURL *localURL = [[NSURL alloc] initFileURLWithPath:_videoPath];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:localURL options:nil];
    _reader = [AVAssetReader assetReaderWithAsset:asset error:nil];
    
    // Setup output format
    _track = [asset tracksWithMediaType:AVMediaTypeVideo][0];
    NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA], kCVPixelBufferPixelFormatTypeKey, nil];
    _trackReaderOutput = [AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:_track outputSettings:outputSettings];
    
    // Start Video Playback
    [_reader addOutput:_trackReaderOutput];
    [_reader startReading];
}

- (void)drawFrame {
    // Update Head Pose.
    _headView = [self getPose];

    // Incorporate the floor height into the head_view
    _headView = GLKMatrix4Multiply(_headView, GLKMatrix4MakeTranslation(0.0f, kDefaultFloorHeight, 0.0f));

    GLKMatrix4 _leftEyeViewPose =
        GLKMatrix4Multiply(GLKMatrix4MakeWithArray(_eyeMatrices[kLeft]), _headView);
    GLKMatrix4 _rightEyeViewPose =
        GLKMatrix4Multiply(GLKMatrix4MakeWithArray(_eyeMatrices[kRight]), _headView);

    // Get current target.
    GLint renderTarget = 0;
    glGetIntegerv(GL_FRAMEBUFFER_BINDING, &renderTarget);

    glBindFramebuffer(GL_FRAMEBUFFER, _fbo);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glEnable(GL_SCISSOR_TEST);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    // Update Video
    bool updated = [self updateVideoScene];

    if (updated) {
        // Draw left eye.
        glViewport(0, 0, _width / 2.0, _height);
        glScissor(0, 0, _width / 2.0, _height);
        [self drawWorldForViewMatrix:_leftEyeViewPose projectionMatrix:GLKMatrix4MakeWithArray(_projMatrices[kLeft])];

        // Draw right eye.
        glViewport(_width / 2.0, 0, _width / 2.0, _height);
        glScissor(_width / 2.0, 0, _width / 2.0, _height);
        [self drawWorldForViewMatrix:_rightEyeViewPose projectionMatrix:GLKMatrix4MakeWithArray(_projMatrices[kRight])];

        // Draw cardboard.
        CardboardDistortionRenderer_renderEyeToDisplay(_distortionRenderer, renderTarget, /*x=*/0,
                                                       /*y=*/0, _width, _height, &_leftEyeTexture,
                                                       &_rightEyeTexture);
    }
}

- (bool)updateVideoScene {
    NSDate *currentTime = [NSDate date];
    
    float frameRate = [_track nominalFrameRate];
    float target = 1000.0/frameRate;
    double timeDiff = [_previousFrame timeIntervalSinceDate:currentTime] * -1000.0;
    
    if (timeDiff > target - _frameSkip) {
        _frameSkip = timeDiff - (target - _frameSkip);
        
        // Skip Frame if the device can't catch up
        if (_frameSkip > target) {
            NSLog(@"Skipped 1 Frame");
            CMSampleBufferRef tmp = [_trackReaderOutput copyNextSampleBuffer];
            CVPixelBufferRef px = CMSampleBufferGetImageBuffer(tmp); // TODO: Is this really needed to prevent a memory leak?
            CVPixelBufferRelease(px);
            CMSampleBufferInvalidate(tmp);
            _frameSkip -= target;
        }

        CMSampleBufferRef buffer = [_trackReaderOutput copyNextSampleBuffer];
        
        // Loop Video
        if (buffer == nil) {
            [self startVideo];
            
            // Notify parent
            if (_callback()) {
                return false;
            }
            
            buffer = [_trackReaderOutput copyNextSampleBuffer]; // TODO: Does this still result in a memory leak?
        }
        
        // Convert Video Frame into UIImage
        CVPixelBufferRef pixels = CMSampleBufferGetImageBuffer(buffer);
        CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixels];
        CIContext *tmpContext = [CIContext contextWithOptions:nil];
        CGImageRef videoImage = [tmpContext createCGImage:ciImage fromRect:CGRectMake(0, 0, CVPixelBufferGetWidth(pixels), CVPixelBufferGetHeight(pixels))];
        UIImage *uiImage = [UIImage imageWithCGImage:videoImage];
        
        // Free Images
        CGImageRelease(videoImage);
        CVPixelBufferRelease(pixels);
        CMSampleBufferInvalidate(buffer);
        buffer = nil;
        
        // Set Image
        _sphereNode.geometry.firstMaterial.diffuse.contents = uiImage;
        
        _previousFrame = currentTime;
    }
    return true;
}

- (GLKMatrix4)getPose {
    float outPosition[3];
    float outOrientation[4];
    CardboardHeadTracker_getPose(
        _headTracker, clock_gettime_nsec_np(CLOCK_UPTIME_RAW) + kPredictionTimeWithoutVsyncNanos,
        kLandscapeLeft, outPosition, outOrientation);
    return GLKMatrix4Multiply(
        GLKMatrix4MakeTranslation(outPosition[0], outPosition[1], outPosition[2]),
        GLKMatrix4MakeWithQuaternion(GLKQuaternionMakeWithArray(outOrientation)));
}

- (void)drawWorldForViewMatrix:(const GLKMatrix4)viewMatrix projectionMatrix:(const GLKMatrix4)projectionMatrix {
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);  // Dark background so text shows up.
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // Set Camera Transforms
    _cameraNode.transform = SCNMatrix4Invert(SCNMatrix4FromGLKMatrix4(viewMatrix));
    _cameraNode.camera.projectionTransform = SCNMatrix4FromGLKMatrix4(projectionMatrix);

    // Render SceneKit Scene
    [SCNTransaction flush];
    [_renderer renderAtTime:0];
}

- (void)stop {
    [_player pause];
}

@end
