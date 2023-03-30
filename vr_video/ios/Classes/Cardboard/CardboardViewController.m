/*
 * Copyright 2019 Google LLC
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

#import "CardboardViewController.h"

#import "CardboardOverlayView.h"
#import "CardboardRenderer.h"
#import "cardboard.h"

@interface CardboardViewController () <GLKViewControllerDelegate, CardboardOverlayViewDelegate> {
  CardboardLensDistortion *_cardboardLensDistortion;
  CardboardHeadTracker *_cardboardHeadTracker;
  CardboardRenderer *_renderer;
  BOOL _updateParams;
}
@end

@implementation CardboardViewController
- (void)dealloc {
  CardboardLensDistortion_destroy(_cardboardLensDistortion);
  CardboardHeadTracker_destroy(_cardboardHeadTracker);
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.delegate = self;

  // Create an overlay view on top of the GLKView.
  CardboardOverlayView *overlayView = [[CardboardOverlayView alloc] initWithFrame:self.view.bounds];
  overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  overlayView.delegate = self;
  [self.view addSubview:overlayView];

  // Add a tap gesture to handle viewer trigger action.
  UITapGestureRecognizer *tapGesture =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapGLView:)];
  [self.view addGestureRecognizer:tapGesture];

  // Prevents screen to turn off.
  UIApplication.sharedApplication.idleTimerDisabled = YES;

  // Create an OpenGL ES context and assign it to the view loaded from storyboard
  GLKView *glkView = (GLKView *)self.view;
  glkView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];

  // Set animation frame rate.
  self.preferredFramesPerSecond = 60;

  // Set the GL context.
  [EAGLContext setCurrentContext:glkView.context];

  // Make sure the glkView has bound its offscreen buffers before calling into cardboard.
  [glkView bindDrawable];

  // Create cardboard head tracker.
  _cardboardHeadTracker = CardboardHeadTracker_create();
  _cardboardLensDistortion = nil;
  _updateParams = YES;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (@available(iOS 11.0, *)) {
    [self setNeedsUpdateOfHomeIndicatorAutoHidden];
  }
  [self resumeCardboard];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
  return true;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  // Cardboard only supports landscape right orientation for inserting the phone in the viewer.
  return UIInterfaceOrientationMaskLandscapeRight;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  if (_updateParams) {
    if (![self updateCardboardParams]) {
      return;
    }
  }

  [_renderer drawFrame];
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller {
  // Perform GL state update before drawing.
}

- (BOOL)updateCardboardParams {
  uint8_t *encodedDeviceParams;
  int size;
  CardboardQrCode_getSavedDeviceParams(&encodedDeviceParams, &size);

  if (size == 0) {
    return NO;
  }

  // Using native scale as we are rendering directly to the screen.
  CGRect screenRect = self.view.bounds;
  CGFloat screenScale = UIScreen.mainScreen.nativeScale;
  int height = screenRect.size.height * screenScale;
  int width = screenRect.size.width * screenScale;

  // Rendering coordinates asumes landscape orientation.
  if (height > width) {
    int temp = height;
    height = width;
    width = temp;
  }

  // Create CardboardLensDistortion.
  CardboardLensDistortion_destroy(_cardboardLensDistortion);
  _cardboardLensDistortion = CardboardLensDistortion_create(encodedDeviceParams, size, width, height);

  // Initialize CardboardRenderer.
  _renderer = [CardboardRenderer
               createWithVideoPath:self.videoPath
               withCountdown:self.countdown
               lensDistortion:_cardboardLensDistortion
               headTracker:_cardboardHeadTracker
               width:width
               height:height
               withCallback:^bool() { return [self onVideoLoopFinished]; }];

  CardboardQrCode_destroy(encodedDeviceParams);

  _updateParams = NO;
  return YES;
}

- (void)pauseCardboard {
  self.paused = true;
  CardboardHeadTracker_pause(_cardboardHeadTracker);
}

- (void)resumeCardboard {
  // Parameters may have changed.
  _updateParams = YES;

  // Check for device parameters existence in app storage. If they're missing,
  // we must scan a Cardboard QR code and save the obtained parameters.
  uint8_t *buffer;
  int size;
  CardboardQrCode_getSavedDeviceParams(&buffer, &size);
  if (size == 0) {
    [self switchViewer];
  }
  CardboardQrCode_destroy(buffer);

  CardboardHeadTracker_resume(_cardboardHeadTracker);
  self.paused = false;
}

- (void)switchViewer {
  // TODO Add CardboardQrCode parameter?
  //CardboardQrCode_scanQrCodeAndSaveDeviceParams();
  const char *uri = "https://google.com/cardboard/cfg?p=CgZHb29nbGUSEkNhcmRib2FyZCBJL08gMjAxNR0rGBU9JQHegj0qEAAASEIAAEhCAABIQgAASEJYADUpXA89OggeZnc-Ej6aPlAAYAM";
  CardboardQrCode_saveDeviceParams((uint8_t *) uri, (int) strlen(uri));
}

- (void)didTapGLView:(id)sender {
  // Do nothing
}

- (void)didTapBackButton {
    [self closePlayer];
}

- (void)didPresentSettingsDialog:(BOOL)presented {
  // The overlay view is presenting the settings dialog. Pause our rendering while presented.
  self.paused = presented;
}

- (void)didChangeViewerProfile {
  [self pauseCardboard];
  [self switchViewer];
  [self resumeCardboard];
}

- (bool)onVideoLoopFinished {
    if (self.loops == 0) {
        [self closePlayer];
        return true;
    } else if (self.loops > 0) {
        self.loops--;
    }
    return false;
}

- (void)closePlayer {
    [_renderer stop];
    _renderer = nil;
    self.flutterResultCallback(@"true");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
