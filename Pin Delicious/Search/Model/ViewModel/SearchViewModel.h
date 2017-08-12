//
//  SearchViewModel.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"

@interface SearchViewModel : NSObject
@property (nonatomic, strong) SearchModel *searchModel;
@property (nonatomic,strong) NSArray *favoritePlaces;


-(instancetype)initWithLatitude:(NSString *)lat Longitude:(NSString *)longi Radius:(NSString *)radius;
-(instancetype)initWithPlace:(NSString *)place Radius:(NSString *)radius;

-(void)requestRestaurantsNearbyWithBlock:(void(^)(NSString * successJson, NSError *error))block;
@end
