//
//  ScreenPresenter.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenPresenter : NSObject
@property (nonatomic, strong) UIViewController *container;

-(instancetype)initWithContainer:(UIViewController *)originContainer;

-(void)show:(UIViewController *)viewController completion:(void (^)(void))completion;
- (void)dismissWithCompletion:(void (^)(void))completion;

@end
