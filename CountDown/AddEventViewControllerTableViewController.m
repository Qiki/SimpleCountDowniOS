//
//  AddEventViewControllerTableViewController.m
//  CountDown
//
//  Created by kiki on 12/18/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import "AddEventViewControllerTableViewController.h"

@interface AddEventViewControllerTableViewController ()

@end

@implementation AddEventViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveAction:(id)sender {
    [self saveEvent];
}

- (void)saveEvent {
    EventDetail *event = [[EventDetail alloc] init];
    event.title = self.eventTitle.text ? : @"";
    event.eventDescription = self.eventDescription.text ? : @"";
    event.eventDate = [self.datePicker date];
    
    [self.delegate saveEvent:event];
}

@end
