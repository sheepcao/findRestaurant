//
//  RestaurantListView.m
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "RestaurantListView.h"

@implementation RestaurantListView

-(instancetype) initWithSearchClickHandler:(rightItemClickBlock)itemclickHandler
{
    self = [super initWithFrame:CGRectMake(0, 0, PDSCREEN_W, PDSCREEN_H)];
    if (self) {
        self.backgroundColor = PDRGBColor(180, 180, 180);
//        [self addSearchButton];
        if (itemclickHandler) {
            self.clickHanlder = itemclickHandler;
        }
        [self addTableView];
    }
    
    return self;
}
-(void)addTableView
{
    self.restaurantList = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.restaurantList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.restaurantList.backgroundColor = self.backgroundColor;
//    self.restaurantList.allowsSelection = NO;
    [self addSubview:self.restaurantList];
}

-(void)addSearchButton
{
    UIButton *rightItem = [[UIButton alloc]init];
//    self.rightItem = rightItem;
//    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;
//    [win addSubview:rightItem];
//    PDNavController *navi = (PDNavController *)win.rootViewController;
    
    rightItem.y = 20;
    rightItem.width = 45;
    rightItem.height = 45;
    [rightItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    rightItem.x = [UIScreen mainScreen].bounds.size.width - rightItem.width;
    PDLog(@"%@",NSStringFromCGRect(rightItem.frame));
    [rightItem setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    
}

- (void)rightItemClick{
 
    if (self.clickHanlder) {
        self.clickHanlder();
    }
}

@end
