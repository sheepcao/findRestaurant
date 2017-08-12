//
//  SearchViewModel.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchModel;

@interface SearchViewModel : NSObject
@property (nonatomic, strong) SearchModel *searchModel;

-(instancetype)initWithLatitude:(NSString *)lat Longitude:(NSString *)longi Radius:(NSString *)radius;

-(void)requestRestaurantsNearbyWithBlock:(void(^)(NSString * successJson, NSError *error))block;
@end
