//
//  restaurantTableViewCell.m
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "restaurantTableViewCell.h"

@implementation restaurantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //remove the shadow to improve performance
//    self.backView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//    self.backView.layer.shadowOpacity = 0.6f;
//    self.backView.layer.shadowOffset = CGSizeMake(0.0, 0.6);
    
    
    self.restaurantCategory.text = @"";
    self.restaurantName.text = @"";
    self.distance.text = @"";


}

-(void)setupCellWith:(Restaurant *)restaurant
{
    
    self.restaurantName.text = restaurant.name;
    if (restaurant.categories.count>0) {
        Categories *category = restaurant.categories[0];
        self.restaurantCategory.text = category.name;
    }
    NSString *address = [restaurant.location.address componentsSeparatedByString:@"|"][0];
    
    if (!address) {
        address = @"暂无地址";
    }
    
    self.distance.text = [NSString stringWithFormat:@"%@     < %@km",address,[self textFromDistance:restaurant.location.distance]];
    if (restaurant.thumbsDown) {
        [self.thumbButton setEnabled:NO];
        [self.thumbButton setImage:[UIImage imageNamed:@"thumbed-down"] forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }else
    {
        [self.thumbButton setEnabled:YES];
        [self.thumbButton setImage:[UIImage imageNamed:@"thumb-down"] forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;

    }
}

-(NSString *)textFromDistance:(NSInteger)distance
{
    NSInteger bgDistance = distance/100 + 1;
    NSString *distanceText = [NSString stringWithFormat:@"%.1f",(CGFloat)bgDistance/10];
    return distanceText;
}


@end
