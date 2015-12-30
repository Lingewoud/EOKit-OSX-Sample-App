//
//  EOResourceListingController.m
//  EO Sample OS X
//
//  Created by Pim Snel on 30-12-15.
//  Copyright © 2015 Lingewoud BV. All rights reserved.
//

#import "EOResourceListingController.h"
#import <EOKit/EOAPIProvider.h>

@interface EOResourceListingController ()

    @property (nonatomic, strong) IBOutlet NSButton	*deleteButton;
    @property (nonatomic, strong) IBOutlet NSTableView *tableView;

    @property (nonatomic, strong) NSArray *addressesList;


@end

@implementation EOResourceListingController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"GLAccounts";
    [self requestAccounts];
    //NSLog(@"numbers: %@", self.numbers);
}

- (void)handleError:(NSError *)error {
    NSLog(@"%s error == %@", __PRETTY_FUNCTION__, error);
}

- (void)requestMe {
    [[EOAPIProvider anyProvider] restGetAPI:@"current/Me" completion:^(NSArray *results, NSError *error) {
        if (!error) {
            NSLog(@"requesting acccounts");
            [self requestAccounts];
        } else {
            [self handleError:error];
        }
    }];
}

- (void)requestAccounts {
    if (![EOAPIProvider anyProvider].currentDivision) {
        [self requestMe];
    } else {
        NSLog(@"requesting acccounts 2");

        [[EOAPIProvider anyProvider] restGetAPI:@"crm/Accounts" division:[EOAPIProvider anyProvider].currentDivision odataParams:@{ @"$orderby" : @"Name" } grabAllItems:YES completion:^(NSArray *results, NSError *error) {
            if (!error) {
                self.addressesList = results;
                NSLog(@"Addresses: %@", self.addressesList);
                [self.tableView reloadData];
            } else {
                [self handleError:error];
            }
        }];
    }
}


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


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.addressesList.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    
    NSDictionary *addressDict = self.addressesList[row];
    NSLog(@"val: %@ ", addressDict[@"Name"] );
  //  cell.textLabel.text = addressDict[@"Description"];
  //  cell.detailTextLabel.text = addressDict[@"TypeDescription"];
    
    if ([tableColumn.identifier isEqualToString:@"Name"]) {
        return addressDict[@"Name"];
 //       return [self.numbers objectAtIndex:row];
        
    } else {
        return addressDict[@"City"];

 //       return [self.numberCodes objectAtIndex:row];
    }
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
    NSTableView *tableView = notification.object;
    NSLog(@"User has selected row %ld", (long)tableView.selectedRow);
}



@end
