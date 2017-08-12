//
//  SearchModel.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

-(NSArray *)favoritePlaces
{
    // could fetch Places thru any approach in this getter.
    return @[@"Essex Office",@"复旦大学"];
}

-(Coordinate)coordinateForPlace:(NSString *)placeName
{
    //better enhance this matching method with local storage or online anti-geo decode
    if ([@"Essex Office" isEqualToString:placeName]) {
        Coordinate coor = {31.194221,121.517046};
        return coor;
    }else if([@"复旦大学" isEqualToString:placeName])
    {
        Coordinate coor = {31.299651,121.508535};
        return coor;
    }
    
    Coordinate defaultCoor = {31.194221,121.517046}; // use Essex as default
    return defaultCoor;
}

@end
