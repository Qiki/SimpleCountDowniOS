//
//  EventDetail.m
//  CountDown
//
//  Created by kiki on 12/18/14.
//  Copyright (c) 2014 kiki. All rights reserved.
//

#import "EventDetail.h"

@implementation EventDetail

- (void)setEventDescription:(NSString *)eventDescription {
    _eventDescription = eventDescription;
}

- (void)setTitle:(NSString *)title {
    _title = title;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.eventDescription forKey:@"eventDescription"];
    [encoder encodeObject:self.eventDate forKey:@"eventDate"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        //decode properties
        self.title = [decoder decodeObjectForKey:@"title"];
        self.eventDescription = [decoder decodeObjectForKey:@"eventDescription"];
        self.eventDate = [decoder decodeObjectForKey:@"eventDate"];
    }
    
    return self;
}

@end
