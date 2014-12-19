//
//  ViewController.h
//  CountDown
//
//  Created by kiki on 12/16/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddEventViewControllerTableViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SaveEvent>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

