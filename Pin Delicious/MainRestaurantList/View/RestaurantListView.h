//
//  RestaurantListView.h
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^rightItemClickBlock)();

@interface RestaurantListView : UIView

@property(nonatomic,strong)UITableView *restaurantList;

@property (nonatomic,copy) rightItemClickBlock clickHanlder;

-(instancetype) initWithSearchClickHandler:(rightItemClickBlock)itemclickHandler;
@end
