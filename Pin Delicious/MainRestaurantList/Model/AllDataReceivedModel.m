//
//  AllDataReceivedModel.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "AllDataReceivedModel.h"
#import "JSONHelper.h"

@implementation AllDataReceivedModel

+(id) responseDataWithJSONString:(NSString *)JSONString
{
        return [JSONHelper parseJSONString:JSONString ToModel:[self class] WithCompletion:nil];
}
@end
