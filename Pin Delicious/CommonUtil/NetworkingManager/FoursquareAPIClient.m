//
//  FoursquareAPIClient.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "FoursquareAPIClient.h"

@implementation FoursquareAPIClient
static NSString * const FoursquareAPIBaseURLString = @"https://api.foursquare.com/v2/";

+ (instancetype)sharedClient {
    static FoursquareAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[FoursquareAPIClient alloc] initWithBaseURL:[NSURL URLWithString:FoursquareAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}




@end

