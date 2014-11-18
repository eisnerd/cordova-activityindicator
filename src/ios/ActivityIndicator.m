#import <Cordova/CDV.h>
#import "ActivityIndicator.h"
#import "MBProgressHUD.h"

@implementation ActivityIndicator
@synthesize activityIndicator;
@synthesize callbackId;

/**
 * This show the ProgressDialog
 */
- (void)show:(CDVInvokedUrlCommand*)command
{
	NSString* text = [command.arguments objectAtIndex:0];
	if (!self.activityIndicator) {
		self.activityIndicator = [MBProgressHUD showHUDAddedTo:self.webView.superview animated:YES];
		self.activityIndicator.mode = MBProgressHUDModeIndeterminate;
#ifdef NS_BLOCKS_AVAILABLE
		self.activityIndicator.onDone = ^()
		{
			[self cancel];
		};
#endif
	}
	self.activityIndicator.labelText = text;
	self.callbackId = command.callbackId;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
	[pluginResult setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/**
 * This hide the ProgressDialog
 */
- (void)hide:(CDVInvokedUrlCommand*)command
{
	if (!self.activityIndicator) {
		CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		return;
	}
	[self.activityIndicator hide:YES];
	self.activityIndicator = nil;
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)cancel
{
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"cancel"];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

@end
