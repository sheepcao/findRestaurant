//
//  NSDate+Custom.m
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/13/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "NSDate+Custom.h"

@implementation NSDate (Custom)



+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

- (BOOL) isTypicallyWeekend {
    NSDateComponents *components = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}


@end
