//
//  Restaurant.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Categories.h"


@interface Restaurant : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) NSArray *categories;
@property BOOL thumbsDown;
@property NSUInteger Score;



//+(instancetype) restaurantWithJSONString:(NSString *)JSONString;

@end
