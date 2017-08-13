//
//  restaurantTableViewCell.h
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

typedef void (^animationCompletion)();

@interface restaurantTableViewCell : UITableViewCell<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *thumbButton;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCategory;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (copy, nonatomic) animationCompletion animationHandler;


-(void)setupCellWith:(Restaurant *)restaurant;
-(void)animationForIndexPath:(NSIndexPath *)indexPath Complettion:(animationCompletion)completionHandler;
@end
