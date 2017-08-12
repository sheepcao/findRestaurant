//
//  SXNavController.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "PDNavController.h"

@interface PDNavController ()

@end

@implementation PDNavController


+ (void)initialize
{
    // 设置导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:PDRGBColor(200, 28, 30)];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:PDRGBColor(230, 230, 230) forKey:NSForegroundColorAttributeName];
    navBar.titleTextAttributes = dict;
    
    navBar.tintColor = PDRGBColor(200, 200, 200);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



@end
