//
//  PublishReviewViewController.m
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/13/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "PublishReviewViewController.h"
#import "PDNavController.h"
#import "XHStarRateView.h"

@interface PublishReviewViewController ()

@end

@implementation PublishReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发 言";
    [self setupStarView];
    [self setupTextView];

}
-(void)setupTextView
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, PDSCREEN_W, 50)];
    [topView setBarStyle:UIBarStyleDefault];
    [topView setTranslucent:YES];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    [self.reviewTextView setInputAccessoryView:topView];
}
-(void)dismissKeyBoard
{
    [self.reviewTextView resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeRightButton];
    
}

-(void)changeRightButton
{
    UIButton *publishBtn = [[UIButton alloc] init];
    publishBtn.y = 0;
    publishBtn.width = 60;
    publishBtn.height = 45;
    [publishBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    publishBtn.x = [UIScreen mainScreen].bounds.size.width - publishBtn.width;
    PDLog(@"%@",NSStringFromCGRect(publishBtn.frame));
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [publishBtn setTitleColor:PDRGBColor(220,220 , 220) forState:UIControlStateNormal];
    PDNavController *navi = (PDNavController *)self.navigationController;
    if(navi.rightButton)
    {
        [navi.rightButton removeFromSuperview];
    }
    navi.rightButton = publishBtn;
    [navi.navigationBar addSubview:publishBtn];
}

-(void)rightButtonClick
{
    
}

-(void)setupStarView
{
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 20, 200, 40) numberOfStars:5 rateStyle:WholeStar isAnination:NO finish:^(CGFloat currentScore) {
        PDLog(@"%f",currentScore);
        
    }];
    [self.starView addSubview:starRateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
