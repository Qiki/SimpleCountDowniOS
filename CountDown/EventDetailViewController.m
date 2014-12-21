//
//  EventDetailViewController.m
//  CountDown
//
//  Created by kiki on 12/18/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpEventInfo:self.eventDetail];
}

- (void)setUpEventInfo:(EventDetail *)eventDetail {
    self.eventTitle.text = eventDetail.title ? : @"";
    self.eventDescription.text = eventDetail.eventDescription ? : @"";
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:[NSDate date]
                                                          toDate:eventDetail.eventDate
                                                         options:0];
    if ([components day] > 1) {
        self.dayLeft.text = [NSString stringWithFormat:@"%ld Days Left", (long)[components day]];
    } else {
        self.dayLeft.text = [NSString stringWithFormat:@"%ld Day Left", (long)[components day]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"MODAL_EDIT"]) {
        UINavigationController *destinationViewController = (UINavigationController *)segue.destinationViewController;
        AddEventViewControllerTableViewController *viewController = (AddEventViewControllerTableViewController *)destinationViewController.viewControllers.firstObject;
        viewController.indexValue = self.index;
        viewController.isEdit = YES;
        viewController.delegate = self;
    }
}

- (void)editEvent:(EventDetail *)eventList withIndex:(NSInteger)index {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *events = [NSMutableArray array];
    
    if ([userDefaults objectForKey:@"events"] != nil && [[userDefaults objectForKey:@"events"] count] > 0) {
        events = [[userDefaults objectForKey:@"events"] mutableCopy];
    }
    
    [events removeObjectAtIndex:index];
    
    NSData * encodedData = [NSKeyedArchiver archivedDataWithRootObject:eventList];
    
    [events insertObject:encodedData atIndex:index];
    [userDefaults setObject:[events copy] forKey:@"events"];
    [userDefaults synchronize];
    
    [self setUpEventInfo:eventList];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
