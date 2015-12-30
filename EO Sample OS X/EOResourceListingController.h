//
//  EOResourceListingController.h
//  EO Sample OS X
//
//  Created by Pim Snel on 30-12-15.
//  Copyright © 2015 Lingewoud BV. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EOResourceListingController : NSViewController  <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSArray *numbers;
@property (nonatomic, strong) NSArray *numberCodes;

@end
