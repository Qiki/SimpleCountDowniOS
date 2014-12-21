//
//  EventDetailViewController.h
//  CountDown
//
//  Created by kiki on 12/18/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EventDetail.h"

#import "AddEventViewControllerTableViewController.h"

@interface EventDetailViewController : UITableViewController <SaveEvent>

@property (nonatomic, weak) IBOutlet UILabel *dayLeft;
@property (nonatomic, weak) IBOutlet UILabel *eventTitle;
@property (nonatomic, weak) IBOutlet UILabel *eventDescription;

@property (nonatomic, strong) EventDetail *eventDetail;
@property (nonatomic) NSInteger index;

@end
