//
//  LocalStorage.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "LocalStorage.h"

#import <FMDB.h>

#import "Restaurant.h"
#import "Review.h"
static LocalStorage *_localStorage = nil;

@interface LocalStorage(){
    FMDatabase  *_db;
    
}

@end

@implementation LocalStorage

+(instancetype)sharedLocalStorage{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _localStorage = [[LocalStorage alloc] init];
        [_localStorage initDataBase];
    });
    return _localStorage;
    
}


-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    // 初始化数据表
    NSString *restaurantSql = @"CREATE TABLE 'restaurant' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'restaurant_id' VARCHAR(255),'thumbs_down' VARCHAR(255),'restaurant_name' VARCHAR(255)) ";
    NSString *reviewSql = @"CREATE TABLE 'review' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'owner_id' VARCHAR(255),'review_id' VARCHAR(255),'review_content' VARCHAR(255),'review_score' VARCHAR(255),'review_date' VARCHAR(255)) ";
    
    [_db executeUpdate:restaurantSql];
    [_db executeUpdate:reviewSql];
    
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addRestaurant:(Restaurant *)restaurant{
    [_db open];
    
    [_db executeUpdate:@"INSERT INTO restaurant(restaurant_id,thumbs_down,restaurant_name)VALUES(?,?,?)",restaurant.id, @(restaurant.thumbsDown),restaurant.name];
 
    [_db close];
    
}

- (void)deleteRestaurant:(Restaurant *)restaurant{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM restaurant WHERE restaurant_id = ?",restaurant.id];
    
    [_db close];
}

- (void)updateRestaurant:(Restaurant *)restaurant{
    [_db open];
    
    [_db executeUpdate:@"UPDATE 'restaurant' SET restaurant_name = ? ,thumbs_down = ? WHERE restaurant_id = ? ",restaurant.name,@(restaurant.thumbsDown),restaurant.id];
    
    [_db close];
}

- (BOOL)getThumbsDown:(Restaurant *)restaurant{
    [_db open];
    
    BOOL thumbsDown = NO;
    
    FMResultSet *res = [_db executeQuery:@"SELECT thumbs_down FROM restaurant where restaurant_id = ?",restaurant.id];
    
    if ([res next]) {
        thumbsDown = [[res stringForColumn:@"thumbs_down"] integerValue];
    }
    
    [_db close];
    
    return thumbsDown;
    
    
}
/**
 *  给restaurant添加评论
 *
 */
- (void)addReview:(Review *)review toRestaurant:(Restaurant *)restaurant{
    [_db open];
    
    //根据restaurant是否拥有review来添加review_id
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM review where owner_id = %@ ",restaurant.id]];
    
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"review_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"review_id"] integerValue]);
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO review(own_id,review_id,review_content,review_score,review_date)VALUES(?,?,?,?,?)",restaurant.id,maxID,review.content,@(review.score),review.date];
    
    
    [_db close];
    
}
/**
 *  给restaurant删除评论
 *
 */
- (void)deleteReview:(Review *)review fromRestaurant:(Restaurant *)restaurant{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM review WHERE own_id = ?  and review_id = ? ",restaurant.id,review.reviewID];
    
    [_db close];
    
}
/**
 *  获取restaurant的所有评论
 *
 */
- (NSMutableArray *)getAllReviewsOfRestaurant:(Restaurant *)restaurant
{
    [_db open];
    NSMutableArray  *reviewArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM review where own_id = %@",restaurant.id]];
    while ([res next]) {
        Review *review = [[Review alloc] init];
        review.reviewID = @([[res stringForColumn:@"review_id"] integerValue]);
        review.content = [res stringForColumn:@"review_content"];
        review.score = [[res stringForColumn:@"review_score"] integerValue];
        review.date = [res stringForColumn:@"review_date"];
        
        [reviewArray addObject:review];
    }
    [_db close];
    
    return reviewArray;

}

@end
