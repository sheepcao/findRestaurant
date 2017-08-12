//
//  Category.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoryIcon;

@interface Categories : NSObject
@property (nonatomic, strong) CategoryIcon *icon;
@property (nonatomic, strong) NSString *name;


@end
