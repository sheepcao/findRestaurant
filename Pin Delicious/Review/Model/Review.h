//
//  Review.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property NSInteger score;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSNumber *reviewID;
@property (nonatomic, strong) NSString *date;

@end
