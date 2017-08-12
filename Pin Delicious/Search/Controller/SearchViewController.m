//
//  SearchViewController.m
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSearchWithSearchClick:(searchClickHandler)handler{
    self.searchViewModel = [[SearchViewModel alloc] init];
    PDWeakSelf(weakSelf);
    SearchView *mySearchView = [[SearchView alloc] initWithFavoritePlaces:self.searchViewModel.favoritePlaces LayoutComplete:^{
        PDStrongSelf(strongSelf);
        [strongSelf.searchView.searchBtn addTarget:strongSelf action:@selector(goSearch) forControlEvents:UIControlEventTouchUpInside];
        for (UIButton *placeButton in strongSelf.searchView.placeButtons) {
            [placeButton addTarget:strongSelf action:@selector(selectPlace:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (handler) {
            strongSelf.searchHandler = handler;
        }
    }];
    self.searchView = mySearchView;

    [self setupSearchView:handler];

    
   }
-(void)setupSearchView:(searchClickHandler)handler
{
    
    self.searchView.frame = [UIScreen mainScreen].bounds;
    self.searchView.y = 64;
    self.searchView.height -= 64;
    self.searchView.hidden = YES;
    self.searchView.backgroundColor = PDRGBColor(187, 187, 187);
    self.searchView.alpha = 0.95;
    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;
    [win addSubview:self.searchView];
    
}
-(void)goSearch
{
    NSLog(@"goSearch");
    
    if (self.searchHandler) {
        NSString *radiusText = [self.searchView.radiusLabel.text componentsSeparatedByString:@" "][0];
        NSString *placeName = self.searchView.place.text;
        if (!placeName || [placeName isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错了" message:@"请选择一个地点" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if ([radiusText floatValue] > 0.01 ) {
            
            
            self.searchViewModel = [[SearchViewModel alloc] initWithPlace:placeName Radius:radiusText];

        
            self.searchHandler(self.searchViewModel);

        }
    }
}
-(void)selectPlace:(UIButton *)sender
{
    self.searchView.place.text = self.searchViewModel.favoritePlaces[sender.tag];
}
@end
