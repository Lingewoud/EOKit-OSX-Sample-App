//
//  EOResourceListingController.m
//  EO Sample OS X
//
//  Created by Pim Snel on 30-12-15.
//  Copyright © 2015 Lingewoud BV. All rights reserved.
//

#import "EOResourceListingController.h"

@interface EOResourceListingController ()

    @property (nonatomic, strong) IBOutlet NSButton	*deleteButton;
    @property (nonatomic, strong) IBOutlet NSTableView	*tableView;

@end

@implementation EOResourceListingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[_tableView setDataSource:self];
}

#pragma mark - Custom Initialisers

- (NSArray *)numbers {
    
    if (!_numbers) {
        _numbers = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    }
    return _numbers;
}

- (NSArray *)numberCodes {
    
    if (!_numberCodes) {
        _numberCodes = @[@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten"];
    }
    return _numberCodes;
}


#pragma mark - Table View Data Source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
    // how many rows do we have here?
    return self.numbers.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // populate each row of our table view with data
    // display a different value depending on each column (as identified in XIB)
    
    if ([tableColumn.identifier isEqualToString:@"numbers"]) {
        
        // first colum (numbers)
        return [self.numbers objectAtIndex:row];
        
    } else {
        
        // second column (numberCodes)
        return [self.numberCodes objectAtIndex:row];
    }
}

#pragma mark - Table View Delegate

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
    NSTableView *tableView = notification.object;
    NSLog(@"User has selected row %ld", (long)tableView.selectedRow);
}



@end
