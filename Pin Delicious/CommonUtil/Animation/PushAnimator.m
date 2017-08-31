//
//  PushAnimator.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "PushAnimator.h"

@implementation PushAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
 
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    if (fromViewController.navigationController.viewControllers.count > 2) {
        toViewController.view.alpha = 0;

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            toViewController.view.alpha = 1;
            
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }else
    {
        [UIView transitionFromView:fromViewController.view
                            toView:toViewController.view
                          duration:[self transitionDuration:transitionContext]
                           options:UIViewAnimationOptionTransitionFlipFromTop |UIViewAnimationOptionAllowUserInteraction
                        completion:^(BOOL finished) {
                            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                        }];

    }
    

    
}

@end
