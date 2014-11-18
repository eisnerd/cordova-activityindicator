#import <Cordova/CDV.h>
#import "MBProgressHUD.h"

@interface ActivityIndicator: CDVPlugin {
}

@property (nonatomic, assign) MBProgressHUD* activityIndicator;
@property (nonatomic, copy) NSString* callbackId;

- (void)show:(CDVInvokedUrlCommand*)command;
- (void)hide:(CDVInvokedUrlCommand*)command;
- (void)cancel;

@end
