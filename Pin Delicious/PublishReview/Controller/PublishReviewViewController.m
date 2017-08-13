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
#import "Review.h"
#import "LocalStorage.h"
#import "Restaurant.h"
#import "NSDate+Custom.h"

@interface PublishReviewViewController ()<UITextViewDelegate>

@property (nonatomic,strong) Review *currentReview;

@end

@implementation PublishReviewViewController

-(Review *)currentReview
{
    if (!_currentReview) {
        _currentReview = [[Review alloc] init];
    }
    return _currentReview;
}

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
    self.reviewTextView.delegate = self;
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
    [self publishReviewActionWithModel:self.currentReview];
}

-(void)setupStarView
{
    PDWeakSelf(weakSelf);
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 23, 200, 30) numberOfStars:5 rateStyle:WholeStar isAnination:NO finish:^(CGFloat currentScore) {
        PDStrongSelf(strongSelf);
        strongSelf.currentReview.score = currentScore;
        PDLog(@"%f",currentScore);
        
    }];
    [self.starView addSubview:starRateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)publishReviewActionWithModel:(Review *)model
{
    if (!model.content || [[model.content stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错了" message:@"评论内容不能是空的" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (model.score < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错了" message:@"请点击五角星评分" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    [[LocalStorage sharedLocalStorage] addRestaurant:self.restaurant];
    model.date = [NSDate getCurrentTime];
    [[LocalStorage sharedLocalStorage] addReview:model toRestaurant:self.restaurant];
    [ProgressHUD showSuccess:@"发表成功！" Interaction:NO];
    double length = @"发表成功！".length;
    NSTimeInterval sleep = length * 0.04 + 1.0;
    [self performSelector:@selector(goBack) withObject:nil afterDelay:sleep];
    
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark UITextView Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.currentReview.content = textView.text;
}
@end
