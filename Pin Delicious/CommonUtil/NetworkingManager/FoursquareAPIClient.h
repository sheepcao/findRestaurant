//
//  FoursquareAPIClient.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface FoursquareAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
@end