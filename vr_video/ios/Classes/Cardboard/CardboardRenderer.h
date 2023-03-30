#import <GLKit/GLKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <SceneKit/SceneKit.h>
#import <AVFoundation/AVFoundation.h>

#include "cardboard.h"

@interface CardboardRenderer : NSObject

+ (id)createWithVideoPath:(NSString *)videoPath withCountdown:(int)countdown lensDistortion:(CardboardLensDistortion *)lensDistortion headTracker:(CardboardHeadTracker *)headTracker width:(int)width height:(int)height withCallback:(bool (^)(void))callback;

- (void)drawFrame;

- (void)stop;

@end
