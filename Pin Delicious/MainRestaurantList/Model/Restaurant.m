//
//  Restaurant.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "Restaurant.h"
#import "Categories.h"
#import "JSONHelper.h"

@interface Restaurant ()
@end

@implementation Restaurant

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"categories"       : [Categories class]
             };
}

//+(instancetype) restaurantWithJSONString:(NSString *)JSONString
//{
//     return [JSONHelper parseJSONString:JSONString ToModel:[self class] WithCompletion:^(__weak id model){
//        NSLog(@"model is Restaurant? %@",[model isKindOfClass:[self class]]?@"Yes":@"NO");
//         if ([model isKindOfClass:[self class]]) {
//             [model fetchUserFeelings];
//         }
//    }];
//}
//
//-(instancetype) fetchUserFeelings
//{
//    self.Score = 3;
//    self.thumbsDown = NO;
//    return self;
//}

@end
