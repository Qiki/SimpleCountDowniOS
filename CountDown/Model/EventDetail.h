//
//  EventDetail.h
//  CountDown
//
//  Created by kiki on 12/18/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventDetail : NSObject <NSCoding>

@property (nonatomic, copy) NSString *eventDescription;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSDate *eventDate;

@end
