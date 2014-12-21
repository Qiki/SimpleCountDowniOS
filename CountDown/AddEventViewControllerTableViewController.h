//
//  AddEventViewControllerTableViewController.h
//  CountDown
//
//  Created by kiki on 12/18/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EventDetail.h"

@protocol SaveEvent

@optional
- (void)saveEvent:(EventDetail *)eventList;
- (void)editEvent:(EventDetail *)eventList withIndex:(NSInteger)index;

@end

@interface AddEventViewControllerTableViewController : UITableViewController

//Nav bar button UI
@property (nonatomic, weak) IBOutlet UIBarButtonItem *cancel;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *save;

//Event detail UI
@property (nonatomic, weak) IBOutlet UITextField *eventTitle;
@property (nonatomic, weak) IBOutlet UITextField *eventDescription;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, assign) id <SaveEvent> delegate;
@property (nonatomic) BOOL isEdit;
@property (nonatomic) NSInteger indexValue;

@end
