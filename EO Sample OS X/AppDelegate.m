//
//  AppDelegate.m
//  EO Sample OS X
//
//  Created by Pim Snel on 29-12-15.
//  Copyright © 2015 Lingewoud BV. All rights reserved.
//

#import "AppDelegate.h"
//#import "EOLoginViewController.h"
#import <EOKit/EOKit.h>

#import <EOKit/EOAPIProvider.h>

#import <EOKit/EOAuthorizationViewController.h>
#import "EOResourceListingController.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
//@property (retain) EOLoginViewController *loginController;

@property (nonatomic, strong) IBOutlet NSButton	*loginButton;
@property (nonatomic, strong) IBOutlet NSButton	*logoutButton;
@property (nonatomic, strong) IBOutlet NSView *contentArea;

@property (nonatomic, strong) NSViewController *listingController;

@property (nonatomic, strong) IBOutlet NSWindow	*authWindow;
@property (nonatomic, strong) IBOutlet EOAuthorizationViewController *authView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    _window.title = @"Exact Online";
    [_loginButton setTarget:self];
    [_loginButton setAction:@selector(loginAction:)];

    [_logoutButton setTarget:self];
    [_logoutButton setAction:@selector(logoutAction:)];
    
    //HelloWorld *objectOfYourCustomClass = [[HelloWorld alloc] init];
    //objectOfYourCustomClass.name = @"Pim";
    //[objectOfYourCustomClass sayHello];
    
    //_loginController = [[EOLoginViewController alloc] initWithNibName:@"EOLoginViewController" bundle:nil];
    //[self.window.contentView addSubview: _loginController.view];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    NSLog(@"Goodbye...");
}


- (IBAction)logoutAction:(id)sender {
    HelloWorld *objectOfYourCustomClass = [[HelloWorld alloc] init];
    objectOfYourCustomClass.name = @"Pim";
    [objectOfYourCustomClass sayHello];
    
    _listingController = [[EOResourceListingController alloc] init];
    [_contentArea addSubview:_listingController.view];
}

- (IBAction)loginAction:(id)sender {
    
    NSString *clientId = @"b2314659-95c7-4bf6-8450-468db26abe8f";
    NSString *secret = @"AAtLBzurJ8B1";
    NSString *callbackURL = @"https://www.getpostman.com/oauth2/callback";
    
    NSLog(@"aha: %@, %@, %@", clientId, secret, callbackURL);
    
    NSRect frame = NSMakeRect(0, 0, 400, 400);
    
    //center window
    CGFloat xPos = NSWidth([[_authWindow screen] frame])/2 - NSWidth([_authWindow frame])/2;
    CGFloat yPos = NSHeight([[_authWindow screen] frame])/2 - NSHeight([_authWindow frame])/2;
    
    NSUInteger masks =
    NSTitledWindowMask|
    NSClosableWindowMask |
    NSResizableWindowMask |
    NSMiniaturizableWindowMask |
    NSUnifiedTitleAndToolbarWindowMask;
    
    _authWindow = [[NSWindow alloc] initWithContentRect:frame
                                              styleMask:masks
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    
    _authView = [[EOAuthorizationViewController alloc] init];
    
    [_authWindow setContentView:_authView.view];
    [_authWindow setFrame:NSMakeRect(xPos, yPos, NSWidth([_authWindow frame]), NSHeight([_authWindow frame])) display:YES];
    [_authWindow makeKeyAndOrderFront:self];
    
    [[EOAPIProvider providerWithClientId:clientId secret:secret] authorizeWithCallbackURL:callbackURL authViewController:_authView completion:^(NSError *error) {
        if (!error) {
            

            
            //[self.navigationController pushViewController:[EOGLAccountsTableViewController new] animated:YES];
        } else {
            NSLog(@"error == %@", error);
        }
    }];
    
}




@end
