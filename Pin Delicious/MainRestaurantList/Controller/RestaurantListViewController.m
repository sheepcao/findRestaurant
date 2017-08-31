//
//  ViewController.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "RestaurantListViewController.h"
#import "SearchViewController.h"
#import "RestaurantListView.h"
#import "restaurantTableViewCell.h"
#import "SearchViewModel.h"
#import "RestaurantsViewModel.h"
#import "LocalStorage.h"
#import "ReviewViewController.h"
#import "PDNavController.h"
#import "FBKVOController.h"



@interface RestaurantListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) SearchViewController *searchViewController;
@property (nonatomic,strong) RestaurantListView *restaurantListView;
@property (nonatomic,strong) RestaurantsViewModel *restaurantViewModel;
@property (nonatomic,strong) FBKVOController *KVOController;

@property(nonatomic,strong)UIButton *rightItem;

@end

@implementation RestaurantListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.restaurantListView = [[RestaurantListView alloc] initWithSearchClickHandler:^{
        [self rightItemClick];
    }];
    self.view =self.restaurantListView;
    self.title = @"周边餐厅";
    
    self.restaurantListView.restaurantList.delegate = self;
    self.restaurantListView.restaurantList.dataSource = self;

    
    [self addSearch];

    self.restaurantViewModel = [[RestaurantsViewModel alloc] init];
    self.searchViewController.searchViewModel = [[SearchViewModel alloc] initWithLatitude:@"31.194221" Longitude:@"121.517046" Radius:@"5000"];
   
    //TODO: 这里 Foursquare API有问题， 搜索半径是a米的话，会搜出来少数大于a米的结果
    [self doSearchActionOnFirstLaunch:YES WithSearchViewModel:self.searchViewController.searchViewModel];
    
    [self setupObservers];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addSearchButton];
}


-(void)addSearchButton
{
    UIButton *rightItem = [[UIButton alloc]init];
    self.rightItem = rightItem;
    rightItem.y = 0;
    rightItem.width = 45;
    rightItem.height = 45;
    [rightItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    rightItem.x = [UIScreen mainScreen].bounds.size.width - rightItem.width;
    PDLog(@"%@",NSStringFromCGRect(rightItem.frame));
    [rightItem setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    

    PDNavController *navi = (PDNavController *)self.navigationController;
    if(navi.rightButton)
    {
        [navi.rightButton removeFromSuperview];
    }
    navi.rightButton = rightItem;
    [navi.navigationBar addSubview:rightItem];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSearch{
    SearchViewController *mySearchVC = [[SearchViewController alloc] init];;
    self.searchViewController = mySearchVC;
    PDWeakSelf(weakSelf);
    [mySearchVC addSearchWithSearchClick:^(SearchViewModel *input) {
        NSLog(@"doSearchAction");
        PDStrongSelf(strongSelf);
        [strongSelf doSearchActionOnFirstLaunch:NO WithSearchViewModel:input];
    }];
}

-(void)doSearchActionOnFirstLaunch:(BOOL)isFirstLaunch WithSearchViewModel:(SearchViewModel *)searchVM
{
    PDWeakSelf(weakSelf);
    if (!isFirstLaunch) {
        [weakSelf rightItemClick];
    }
    [ProgressHUD show:@"Please wait..." Interaction:NO];

    [searchVM requestRestaurantsNearbyWithBlock:^(NSString *successJson, NSError *error) {
        if (error) {
            PDLog(@"error-:%@", error);
            [ProgressHUD showError:@"Some thing went wrong" Interaction:NO];

        }else
        {
            PDStrongSelf(strongSelf);
            PDLog(@"successJson-:%@",successJson);
            [strongSelf.restaurantViewModel restaurantsFromJSONString:successJson];
            PDLog(@"%@",strongSelf.restaurantViewModel);
//            [strongSelf.restaurantListView.restaurantList reloadData];

            [ProgressHUD dismiss];

            
        }
    }];

}
#pragma mark -
#pragma mark KVO on view model to update the view
- (void)setupObservers
{
    self.KVOController = [FBKVOController controllerWithObserver:self];

    PDWeakSelf(weakSelf);
    [self.KVOController observe:self.restaurantViewModel keyPath:@"restaurantModels" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        NSLog(@"setupObservers");
        PDStrongSelf(strongSelf);
        [strongSelf.restaurantListView.restaurantList reloadData];
    }];
    
}
- (void)dealloc
{
    [_KVOController unobserveAll];
}
#pragma mark end -

- (void)rightItemClick{
    
    if (!self.searchViewController.searchView.hidden) {
        
        
        self.searchViewController.searchView.hidden = YES;
        [UIView animateWithDuration:0.1 animations:^{
            self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, M_1_PI * 5);
            
        } completion:^(BOOL finished) {
            [self.rightItem setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        }];
    }else{
        
        [self.rightItem setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        self.searchViewController.searchView.hidden = NO;
        [self.searchViewController.searchView addAnimate];
        [UIView animateWithDuration:0.2 animations:^{
            self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, -M_1_PI * 6);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, M_1_PI );
            }];
        }];
    }
}


#pragma mark TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewViewController *reviewVC = [[ReviewViewController alloc] init];
    reviewVC.restaurant = self.restaurantViewModel.restaurantModels[indexPath.row];

    [self.navigationController pushViewController:reviewVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark TableView Datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"restaurantCell";
    restaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"restaurantTableViewCell" owner:self options:nil] lastObject];
    }
    
    [cell setupCellWith:self.restaurantViewModel.restaurantModels[indexPath.row]];
    cell.thumbButton.tag = indexPath.row;
    [cell.thumbButton addTarget:self action:@selector(thumbDownAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PDLog(@"%lu 个餐厅",(unsigned long)self.restaurantViewModel.restaurantModels.count);
    return self.restaurantViewModel.restaurantModels.count;
}

#pragma mark --

-(void)thumbDownAction:(UIButton *)sender
{
    //根据要求，“踩”过得餐厅永远排在最后。("never considered as an option for dining.")
    PDLog(@"sender:%ld",(long)sender.tag);
    Restaurant *restaurant = self.restaurantViewModel.restaurantModels[sender.tag];
    [[LocalStorage sharedLocalStorage] addRestaurant:restaurant];
    restaurant.thumbsDown = YES;
    [[LocalStorage sharedLocalStorage] updateRestaurant:restaurant];
    [self.restaurantViewModel resort];

    PDWeakSelf(weakSelf);
    restaurantTableViewCell *cell = [self findCellView:sender.superview];
    if (cell) {
        [cell animationForIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0] Complettion:^{
            PDStrongSelf(strongSelf);
            [strongSelf.restaurantListView.restaurantList reloadData];
        }];
    }

    
}

-(restaurantTableViewCell *)findCellView:(UIView *)view
{
    restaurantTableViewCell *cell;
    if ([view isKindOfClass:[UITableView class]]) {
        return nil;
    }
    
    if ([view isKindOfClass:[restaurantTableViewCell class]]) {
        return (restaurantTableViewCell *)view;
    }else
    {
       cell = [self findCellView:view.superview];
    }
    
    return cell;
}

@end
