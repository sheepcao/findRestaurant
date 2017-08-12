//
//  ScreenPresenter.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "ScreenPresenter.h"
@interface ScreenPresenter()
@property (nonatomic, strong) UIViewController *presented;

@end
@implementation ScreenPresenter
-(instancetype)initWithContainer:(UIViewController *)originContainer
{
    self = [super init];
    if (self) {
        self.container = originContainer;
    }
    return self;
}

- (void)show:(UIViewController *)viewController completion:(void (^)(void))completion
{
    [self.container addChildViewController:viewController];
    [viewController didMoveToParentViewController:self.container];
    [self.container.view addSubview:viewController.view];
    self.presented = viewController;

}

- (void)dismissWithCompletion:(void (^)(void))completion
{
    [self.presented willMoveToParentViewController:nil];
    [self.presented.view removeFromSuperview];
    [self.presented removeFromParentViewController];
}

@end
