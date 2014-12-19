//
//  ViewController.m
//  CountDown
//
//  Created by kiki on 12/16/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import "ViewController.h"

#import "EventCell.h"

static NSMutableArray *events;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UITableWWView Delegate and DataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"EventCell";
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    EventDetail *event = events[indexPath.row];
    
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
    [self performSegueWithIdentifier:@"PUSH_DETAIL" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"PUSH_ADD"]) {
        UINavigationController *destinationViewController = (UINavigationController *)segue.destinationViewController;
        AddEventViewControllerTableViewController *viewController = (AddEventViewControllerTableViewController *)destinationViewController.viewControllers.firstObject;
        viewController.delegate = self;
    }
}

- (void)saveEvent:(EventDetail *)eventList {
    [self.tableView reloadData];
    
    if (events == nil) {
        events = [[NSMutableArray alloc] init];
    }
    
    [events addObject:eventList];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
