//
//  AddEventViewControllerTableViewController.m
//  CountDown
//
//  Created by kiki on 12/18/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import "AddEventViewControllerTableViewController.h"

@interface AddEventViewControllerTableViewController ()

@property (nonatomic, copy) NSArray *eventLists;

@end

@implementation AddEventViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isEdit) {
        [self fetchDataFromUserDefault];
        [self editEventInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchDataFromUserDefault {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.eventLists = [NSArray array];
    self.eventLists = [userDefaults objectForKey:@"events"];
}

- (void)editEventInfo {
    EventDetail* event = (EventDetail*)[NSKeyedUnarchiver unarchiveObjectWithData: self.eventLists[self.indexValue]];
    
    self.eventTitle.text = event.title ? : @"";
    self.eventDescription.text = event.eventDescription ? : @"";
    self.datePicker.date  = event.eventDate;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveAction:(id)sender {
    [self setLocationNotification];

    if (!self.isEdit) {
        [self saveEvent];
    } else {
        [self editEvent];
    }
}

- (void)saveEvent {
    [self.delegate saveEvent:[self getEventInfo]];
}

- (EventDetail *)getEventInfo {
    EventDetail *event = [[EventDetail alloc] init];
    event.title = self.eventTitle.text ? : @"";
    event.eventDescription = self.eventDescription.text ? : @"";
    event.eventDate = [self.datePicker date];
    
    
    return event;
}

- (void)editEvent {
    [self.delegate editEvent:[self getEventInfo] withIndex:self.indexValue];
}

- (void)setLocationNotification {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeInterval:86400 sinceDate:[self.datePicker date]];

    localNotification.alertBody = @"One day left before your Christmas Trip with Qi! YOU KNOW THAT GingerBear!!!!";
    localNotification.timeZone = [NSTimeZone systemTimeZone];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
