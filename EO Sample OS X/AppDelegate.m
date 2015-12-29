//
//  AppDelegate.m
//  EO Sample OS X
//
//  Created by Pim Snel on 29-12-15.
//  Copyright © 2015 Lingewoud BV. All rights reserved.
//

#import "AppDelegate.h"
#import "EOLoginViewController.h"
#import <EOKit/EOKit.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (retain) EOLoginViewController *loginController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    HelloWorld *objectOfYourCustomClass = [[HelloWorld alloc] init];
    objectOfYourCustomClass.name = @"Pim";
    [objectOfYourCustomClass sayHello];
    
    _loginController = [[EOLoginViewController alloc] initWithNibName:@"EOLoginViewController" bundle:nil];
    [self.window.contentView addSubview: _loginController.view];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    NSLog(@"Goodbye...");
}

@end
