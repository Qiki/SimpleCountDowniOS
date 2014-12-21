//
//  ViewController.m
//  CountDown
//
//  Created by kiki on 12/16/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import "ViewController.h"

#import "EventCell.h"
#import "EventDetailViewController.h"

static NSMutableArray *events;

@interface ViewController ()

@property (nonatomic, copy) NSArray *eventLists;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self fetchDataFromUserDefault];
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




#pragma mark - UITableWWView Delegate and DataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"EventCell";
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    EventDetail* event = (EventDetail*)[NSKeyedUnarchiver unarchiveObjectWithData: self.eventLists[indexPath.row]];
    
    cell.eventTitle.text = event.title ? : @"";
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:[NSDate date]
                                                          toDate:event.eventDate
                                                         options:0];
    if ([components day] > 1) {
       cell.eventDayLeft.text = [NSString stringWithFormat:@"%ld Days Left", (long)[components day]];
    } else {
        cell.eventDayLeft.text = [NSString stringWithFormat:@"%ld Day Left", (long)[components day]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       EventDetail* event = (EventDetail*)[NSKeyedUnarchiver unarchiveObjectWithData: self.eventLists[indexPath.row]];
    [self performSegueWithIdentifier:@"PUSH_DETAIL" sender:@{@"eventDetail" : event, @"index" : [NSNumber numberWithInteger:indexPath.row]}];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"PUSH_ADD"]) {
        UINavigationController *destinationViewController = (UINavigationController *)segue.destinationViewController;
        AddEventViewControllerTableViewController *viewController = (AddEventViewControllerTableViewController *)destinationViewController.viewControllers.firstObject;
        viewController.delegate = self;
    } else if ([[segue identifier] isEqualToString:@"PUSH_DETAIL"]) {        EventDetailViewController *viewController = (EventDetailViewController *)segue.destinationViewController;
        viewController.eventDetail = sender[@"eventDetail"];
        viewController.index = [sender[@"index"] integerValue];
    }
}

- (void)saveEvent:(EventDetail *)eventList {
    [self saveEventToUserDefault:eventList];
    [self fetchDataFromUserDefault];
    
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveEventToUserDefault:(EventDetail *)event {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *events = [NSMutableArray array];
    
    if ([userDefaults objectForKey:@"events"] != nil && [[userDefaults objectForKey:@"events"] count] > 0) {
        events = [[userDefaults objectForKey:@"events"] mutableCopy];
    }
    
    NSData * encodedData = [NSKeyedArchiver archivedDataWithRootObject:event];
    
    [events addObject:encodedData];
    [userDefaults setObject:[events copy] forKey:@"events"];
    [userDefaults synchronize];
}

@end
