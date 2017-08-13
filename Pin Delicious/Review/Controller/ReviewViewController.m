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
#import "LocalStorage.h"
#import "Review.h"
#import "ReviewsTableViewCell.h"

@interface ReviewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *ratingCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;

@property (strong, nonatomic) NSArray *reviewArray;
@property (nonatomic,strong) ReviewsTableViewCell *prototypeCell;
@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.restaurant.name;
    self.reviewTableView.delegate = self;
    self.reviewTableView.dataSource = self;
    self.reviewTableView.backgroundColor = [UIColor clearColor];
    [self.reviewTableView registerNib:[UINib nibWithNibName:@"ReviewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"reviewCell"];
    self.reviewTableView.estimatedRowHeight = 100;
    self.prototypeCell = [self.reviewTableView dequeueReusableCellWithIdentifier:@"reviewCell"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeRightButton];
    [self setupScoreFileds];
    
    
    
    
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
    publishVC.restaurant = self.restaurant;
    [self.navigationController pushViewController:publishVC animated:YES];
}

-(void)setupStarViewWithScore:(CGFloat)score
{
    for (UIView * view in self.starsView.subviews) {
        [view removeFromSuperview];
    }
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(0, 23, 200, 30) numberOfStars:5 currentScore:score rateStyle:IncompleteStar isInteractive:NO finish:nil];
    [self.starsView addSubview:starRateView];
}
-(void)setupScoreFileds
{
    NSArray *reviews = [[LocalStorage sharedLocalStorage] getAllReviewsOfRestaurant:self.restaurant];
    __block CGFloat totalscore = 0.0;
    [reviews enumerateObjectsUsingBlock:^(Review *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totalscore = totalscore + obj.score;
    }];
    CGFloat averageScore = 0;
    
    if (reviews.count > 0) {
        averageScore = totalscore/reviews.count;
    }
    [self setupStarViewWithScore:averageScore];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f",averageScore];
    self.ratingCountLabel.text = [NSString stringWithFormat:@"%lu ratings",reviews.count];
    
    self.reviewArray = reviews;
    [self.reviewTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewsTableViewCell *cell = self.prototypeCell;
    cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.prototypeCell setupCellWith:self.reviewArray[indexPath.row]];
    
    CGFloat contentViewWidth = CGRectGetWidth(self.reviewTableView.bounds);
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
    [cell.contentView addConstraint:widthFenceConstraint];
    // Auto layout engine does its math
    CGFloat fittingHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
    [cell.contentView removeConstraint:widthFenceConstraint];
    /*-------------------------------End------------------------------------*/
    
    return fittingHeight+2*1/[UIScreen mainScreen].scale;//必须加上上下分割线的高度
}




#pragma mark TableView Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"reviewCell";
    //自定义cell类
    ReviewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReviewsTableViewCell" owner:self options:nil] lastObject];
    }
    
    [cell setupCellWith:self.reviewArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.reviewArray.count;
}
@end
