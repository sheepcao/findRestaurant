//
//  ReviewViewController.m
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "ReviewViewController.h"
#import "Restaurant.h"
#import "PDNavController.h"
#import "XHStarRateView.h"
#import "PublishReviewViewController.h"

@interface ReviewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *ratingCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.restaurant.name;
    [self setupStarView];

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
    [publishBtn setTitle:@"发言" forState:UIControlStateNormal];
    [publishBtn setTitleColor:PDRGBColor(220,220 , 220) forState:UIControlStateNormal];
    PDNavController *navi = (PDNavController *)self.navigationController;
    if(navi.rightButton)
    {
        [navi.rightButton removeFromSuperview];
    }
    navi.rightButton = publishBtn;
    [navi.navigationBar addSubview:publishBtn];
    //添加空的右侧按钮，从而缩短titleView的宽度
    UIBarButtonItem *emptyRight = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = emptyRight;
}

-(void)rightButtonClick
{
    PublishReviewViewController *publishVC = [[PublishReviewViewController alloc] init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

-(void)setupStarView
{
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 20, 200, 40) numberOfStars:5 currentScore:3.3 rateStyle:IncompleteStar isInteractive:NO finish:nil];
    [self.starsView addSubview:starRateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
