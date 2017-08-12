//
//  RestaurantsModelView.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantsViewModel : NSObject

@property(nonatomic,strong) NSMutableArray *restaurantModels;
-(void)restaurantsFromJSONString:(NSString *)JSONString;
-(void)resort;
@end
