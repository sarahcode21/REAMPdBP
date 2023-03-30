#import "VrVideoPlugin.h"
#import "Cardboard/CardboardViewController.h"

@implementation VrVideoPlugin

{
    NSObject<FlutterPluginRegistrar>* _registrar;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"vr_video"
                                     binaryMessenger:[registrar messenger]];
    VrVideoPlugin* instance = [[VrVideoPlugin alloc] initWithRegistrar:registrar];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (id)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    self = [super init];
    _registrar = registrar;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"startVideo" isEqualToString:call.method]) {
        [self startVideo:call.arguments[@"asset"] loops:[call.arguments[@"loops"] intValue] countdown:[call.arguments[@"countdown"] intValue] result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)startVideo:(NSString*)asset loops:(int)loops countdown:(int)countdown result:(FlutterResult)result {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"vr" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"VR" bundle:bundle];
    CardboardViewController *view = (CardboardViewController*)[storyboard instantiateInitialViewController];
    
    NSString* key = [_registrar lookupKeyForAsset:asset];
    view.videoPath = [[NSBundle mainBundle] pathForResource:key ofType:nil];
    view.loops = loops;
    view.countdown = countdown;
    view.flutterResultCallback = result;
    
    [view setModalPresentationStyle: UIModalPresentationFullScreen];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:view animated:YES completion:nil];
}

@end
