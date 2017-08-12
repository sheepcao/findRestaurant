//
//  JSONHelper.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject

/**
adding a completionHandler to do whatever needed after JSON parsed, such as fetching local storage,caching data,filter data etc... Good looking
 
 @return the data model
 */
+(id)parseJSONString:(NSString *)string ToModel:(id)modelClass WithCompletion:(void (^)(__weak id))completionHandler;

@end
