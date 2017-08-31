//
//  Pin_DeliciousTests.m
//  Pin DeliciousTests
//
//  Created by HSBC_XiAn_Core on 8/29/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchViewModel.h"
#import "RestaurantsViewModel.h"
#import "NSDate+Custom.h"

#define WAIT do {\
[self expectationForNotification:@"RSBaseTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:30 handler:nil];\
} while (0);

#define NOTIFY \
[[NSNotificationCenter defaultCenter]postNotificationName:@"RSBaseTest" object:nil];



@interface Pin_DeliciousTests : XCTestCase

@end

@implementation Pin_DeliciousTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void)testFetchRestaurants {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Handler called"];

    SearchViewModel *searchVM = [[SearchViewModel alloc] initWithPlace:@"复旦大学" Radius:@"5000"];
    [searchVM requestRestaurantsNearbyWithBlock:^(NSString *successJson, NSError *error) {

        if (error) {
            NSLog(@"error-:%@", error);
            
        }else
        {
            NSLog(@"successJson-:%@",successJson);

            RestaurantsViewModel *test = [[RestaurantsViewModel alloc] init];
            NSArray *restaurantArray = [test restaurantsFromJSONString:successJson];
            [expectation fulfill];
            XCTAssertEqual(restaurantArray.count,50,@"复旦大学周边饭店数据出错！");
            
        }
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:nil];

}

-(void)testIsDateWeekend
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat : @"dd-MM-yyyy"];
    dateFormatter.locale = [NSLocale currentLocale];
//    [dateFormatter setLocalizedDateFormatFromTemplate:@"MMMMd"];
//    NSDate *dateTime1 = [dateFormatter dateFromString:@"December 31"];
    NSDate *dateTime2 = [dateFormatter dateFromString:@"22-03-2009"];

//    BOOL isWeekend1 = [dateTime1 isTypicallyWeekend];
    BOOL isWeekend2 = [dateTime2 isTypicallyWeekend];

//    XCTAssertFalse(isWeekend1,@"16Mar2009 is weekend");
    XCTAssertTrue(isWeekend2,@"22Mar2009 is not weekend");


}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
