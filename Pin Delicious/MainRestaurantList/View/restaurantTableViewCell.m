//
//  restaurantTableViewCell.m
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "restaurantTableViewCell.h"
#import "POP.h"

#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

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

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
        //添加一点POP库的简单用法
        POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        sprintAnimation.springBounciness = 20.f;
        [self.restaurantName pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
    }
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


//添加动画，点击"踩"的 时候，cell掉落效果。
- (void)animationForIndexPath:(NSIndexPath *)indexPath Complettion:(animationCompletion) completionHandler {
    float radians = 360;
    CALayer *layer = [[self.layer sublayers] objectAtIndex:0];
    
    // Rotation Animation
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue =@DEGREES_TO_RADIANS(radians);
    animation.toValue = @DEGREES_TO_RADIANS(0);
//
    // Opacity Animation;
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = @1.0f;
    fadeAnimation.toValue = @0.0f;
    
    // Translation Animation
    CABasicAnimation *translationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    ;
    translationAnimation.fromValue = @0.f;
    translationAnimation.toValue = @700.f;
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.duration = 0.7f;
    [animationGroup setValue:@"groupAnimation" forKey:@"combineAnimation"];

    animationGroup.animations = @[animation,fadeAnimation,translationAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animationGroup forKey:@"groupAnimation"];
    self.animationHandler = completionHandler;
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if (flag)
    {
        NSString *animationName = [anim valueForKey:@"combineAnimation"];
        if ([animationName isEqualToString:@"groupAnimation"])
        {
            self.animationHandler();
        }
    }

}



@end
