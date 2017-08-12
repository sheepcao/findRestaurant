//
//  RestaurantsModelView.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "RestaurantsViewModel.h"
#import "Restaurant.h"
#import "AllDataReceivedModel.h"
#import "LocalStorage.h"

@implementation RestaurantsViewModel

typedef NS_ENUM(NSInteger, Order) {
    Ascending,    //默认从0开始
    Descending,
};

-(id)init
{
    self = [super init];
    if (self) {
        self.restaurantModels = [[NSMutableArray alloc] initWithCapacity:50];
    }
    return self;
}


-(void)restaurantsFromJSONString:(NSString *)JSONString
{
    self.restaurantModels = [[NSMutableArray alloc] initWithCapacity:50];
    
    AllDataReceivedModel *allDataModel = [AllDataReceivedModel responseDataWithJSONString:JSONString];
    NSArray *allRestaurants = allDataModel.response.venues;
    __weak __typeof(self) weakSelf = self;
    [allRestaurants enumerateObjectsUsingBlock:^(Restaurant *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong __typeof(self) strongSelf = weakSelf;
        [strongSelf insertRestaurant:obj InOrder:Ascending ToArray:strongSelf.restaurantModels];
        
    }];
    
}

-(void)insertRestaurant:(Restaurant *)element InOrder:(Order)order ToArray:(NSMutableArray *)restaurantsArray
{
    if (order == Ascending) {
        NSUInteger index = 0;
        
        for (index = 0; index < restaurantsArray.count; index++) {
            Restaurant *obj = restaurantsArray[index];
            if (obj.location.distance > element.location.distance) {
                break;
            }
        }
        [restaurantsArray insertObject:element atIndex:index];
        
    }else
    {
        //TODO: 本例子用不到，待实现
    }
    //把“踩”过的餐厅放到最后
    [self resort];
    
}

-(void)resort
{
    for ( int index = 0; index < self.restaurantModels.count; index++) {
        Restaurant *obj =  self.restaurantModels[index];
        if ([[LocalStorage sharedLocalStorage] getThumbsDown:obj]) {
            [self.restaurantModels removeObject:obj];
            [self.restaurantModels addObject:obj];
            obj.thumbsDown = YES;
        }
    }
   
}

@end
