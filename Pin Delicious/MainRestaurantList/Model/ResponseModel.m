//
//  ResponseModel.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "ResponseModel.h"
#import "Restaurant.h"

@implementation ResponseModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    
    return @{
             @"venues"       : [Restaurant class]
             };
}


@end
