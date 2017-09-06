//
//  JSONHelper.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "JSONHelper.h"

@implementation JSONHelper

+(id)parseJSONString:(NSString *)string ToModel:(id)modelClass WithCompletion:(void (^)(__weak id))completionHandler
{
    id model = [modelClass yy_modelWithJSON:string];
    
    // adding a completionHandler to do whatever needed after JSON parsed, such as fetching local storage,caching data,filter data etc...
    if (completionHandler) {
        completionHandler(model);
    }
    return model;
}



@end
