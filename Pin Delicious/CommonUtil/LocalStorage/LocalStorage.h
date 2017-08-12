//
//  LocalStorage.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Restaurant;
@class Review;



@interface LocalStorage : NSObject

@property(nonatomic,strong) Restaurant *restaurant;


+ (instancetype)sharedLocalStorage;



//所有接口的定义应与实现方式无关，可以是database，userdefault...
#pragma mark - Restaurant
/**
 *  添加restaurant
 *
 */
- (void)addRestaurant:(Restaurant *)restaurant;
/**
 *  删除restaurant
 *
 */
- (void)deleteRestaurant:(Restaurant *)restaurant;
/**
 *  更新restaurant
 *
 */
- (void)updateRestaurant:(Restaurant *)restaurant;
/**
 *  获取ThumbsDown
 *
 */
- (BOOL)getThumbsDown:(Restaurant *)restaurant;

#pragma mark - Review


/**
 *  给Restaurant添加评论
 *
 */
- (void)addReview:(Review *)review toRestaurant:(Restaurant *)restaurant;
/**
 *  给Restaurant删除评论
 *
 */
- (void)deleteReview:(Review *)review fromRestaurant:(Restaurant *)restaurant;
/**
 *  获取Restaurant的所有评论
 *
 */
- (NSMutableArray *)getAllReviewsOfRestaurant:(Restaurant *)restaurant;



@end
