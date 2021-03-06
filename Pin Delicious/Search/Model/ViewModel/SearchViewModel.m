//
//  SearchViewModel.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "SearchViewModel.h"
#import "SearchModel.h"
#import "FoursquareAPIClient.h"
#import "FoursquareCredentialModel.h"

@interface SearchViewModel()
@property (nonatomic,strong) NSURLSessionTask *task;

@end
@implementation SearchViewModel


-(NSArray *)favoritePlaces
{
    // could fetch Places thru any approach in this getter. The current UI design can support no more than 3 places.
    return @[@"Essex Office",@"复旦大学"];
}


-(instancetype)initWithLatitude:(NSString *)lat Longitude:(NSString *)longi Radius:(NSString *)radius
{
    self = [super init];
    if (self) {
        
        Coordinate coor = {[lat floatValue],[longi floatValue]};
        InputField inputs = {coor,[radius floatValue]};
        self.searchModel.inputField = inputs;
    }
    return self;
}

-(instancetype)initWithPlace:(NSString *)place Radius:(NSString *)radius
{
    self = [super init];
    if (self) {
        self.searchModel = [[SearchModel alloc] init];
        Coordinate coor = [self.searchModel coordinateForPlace:place];
        InputField inputs = {coor,[radius floatValue]*1000};
        self.searchModel.inputField = inputs;
    }
    return self;
}

-(void)requestRestaurantsNearbyWithBlock:(void(^)(NSString * successJson, NSError *error))block
{
    FoursquareCredentialModel *credential = [[FoursquareCredentialModel alloc] init];
    NSString *ll = [NSString stringWithFormat:@"%f,%f",self.searchModel.inputField.coordinate.latitude,self.searchModel.inputField.coordinate.longitude];
    NSString *radius = [NSString stringWithFormat:@"%f",self.searchModel.inputField.radius];

    NSDictionary *parameterDic = @{@"client_id":credential.clientID,@"client_secret":credential.clientSecret,@"radius":radius,@"ll":ll,@"limit":@"50",@"v":@"20170707",@"query":@"restaurant"};
    PDLog(@"parameterDic-:%@",parameterDic);

    if (self.task) {
        [self.task cancel];
        self.task = nil;
    }
    self.task = [[FoursquareAPIClient sharedClient] GET:@"venues/search" parameters:parameterDic progress:nil success:^(NSURLSessionDataTask * __unused task, NSString *JSON) {
        if (block) {
            block(JSON,nil);
        }
       
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block(nil,error);
        }
    }];

}


// lazy load, can avoid the getter return nil when not using -[initWithLat...]
-(SearchModel *)searchModel
{
    if (!_searchModel) {
        
        _searchModel = [[SearchModel alloc] init];
        Coordinate defaultCoor = {31.194221,121.517046}; // use Essex as default
        InputField inputs = {defaultCoor,5000};
        _searchModel.inputField = inputs;

    }
    return _searchModel;
}
@end
