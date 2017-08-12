//
//  SearchModel.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _Coordinate {
    
    CGFloat latitude;
    CGFloat longitude;
} Coordinate;

typedef struct _InputField {
    
    Coordinate coordinate;
    CGFloat radius;  //单位：米
} InputField;

@interface SearchModel : NSObject

@property InputField inputField;
@property (nonatomic,strong) NSArray *favoritePlaces;

@end
