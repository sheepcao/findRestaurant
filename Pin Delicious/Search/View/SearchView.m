//
//  Search.m
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "SearchView.h"
#import "SearchViewModel.h"



@interface SearchView ()

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *bottomView;


@property(nonatomic,strong) UILabel *favoritePlaceLabel;
@property(nonatomic,strong) NSMutableArray *imageArray;



@end
@implementation SearchView

- (instancetype)initWithFavoritePlaces:(NSArray *)favoritePlaces LayoutComplete:(layoutCompleteion)handler{
    self = [super init];
    if (self) {
        UIView *topView = [[UIView alloc]init];
        self.topView = topView;
        
        UIView *bottomView = [[UIView alloc]init];
        self.bottomView = bottomView;
        self.favoritePlaces = favoritePlaces;
        self.layoutHandler = handler;
        self.placeButtons = [[NSMutableArray alloc] initWithCapacity:favoritePlaces.count];
        self.imageArray = [[NSMutableArray alloc] initWithCapacity:favoritePlaces.count];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self setupSubViews:self.favoritePlaces];
    
}

-(void)setupSubViews:(NSArray *)favoritePlaces
{
    [self addSubview:self.topView];

    self.topView.x = 0;
    self.topView.y = 0;
    self.topView.height = PDSCREEN_H /3;
    self.topView.width = self.width;
    [self setupTopViewWith:self.favoritePlaces];
    
    
    [self addSubview:self.bottomView];
    self.bottomView.x = 0;
    self.bottomView.y = self.topView.height;
    self.bottomView.height = self.height - self.topView.height;
    self.bottomView.width = self.width;
    
    [self setupBottomView];
    self.layoutHandler();

    
}

#pragma mark -- Top View

-(void)setupTopViewWith:(NSArray *)favoritePlaces
{
    self.favoritePlaceLabel = [[UILabel alloc] init];
    self.favoritePlaceLabel.x = 20;
    self.favoritePlaceLabel.y = 10;
    self.favoritePlaceLabel.width = PDSCREEN_W/2;
    self.favoritePlaceLabel.height = 30;
    self.favoritePlaceLabel.text = @"点击选取地点:";
    self.favoritePlaceLabel.textColor = PDRGBColor(35, 35, 35);
    self.favoritePlaceLabel.font = PDFontWithWeight(21, UIFontWeightMedium);
    [self.topView addSubview:self.favoritePlaceLabel];
    
    int counter = 0;
    
    for (NSString *placeName in favoritePlaces) {
        UIButton *btnOne = [self btnWithTitle:placeName icon:placeName color:PDRGBColor(255/(counter+1), 130, 50*(counter)) index:counter];
        btnOne.tag = counter;
        counter ++;
        [self.placeButtons addObject:btnOne];

    }
        
    
}

- (UIButton *)btnWithTitle:(NSString *)title icon:(NSString *)icon color:(UIColor *)color index:(int)index{
    
    int cols = index%3;
    int rows = index/3;
    CGFloat w = self.width/3;
    CGFloat h = self.topView.height-(self.favoritePlaceLabel.height+2*self.favoritePlaceLabel.y)/2;
    UIView *itemView = [[UIView alloc]init];
    [self.topView addSubview:itemView];
    itemView.x = cols * w;
    itemView.y = rows * h + 2*self.favoritePlaceLabel.y;
    itemView.width = w;
    itemView.height = h/2;
    
    UIButton *btn = [[UIButton alloc]init];
    btn.width = w-40;
    btn.height = btn.width;
    btn.y = 40;
    if (index > 2) {
        btn.y = 10;
    }
    btn.x = 20;
    
    btn.layer.cornerRadius = btn.width/2;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = color;

    [itemView addSubview:btn];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:icon];
    img.width = btn.width/2;
    img.height = img.width;
    img.center = btn.center;
    [itemView addSubview:img];
    
    [self.imageArray addObject:img];
    
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.font = [UIFont fontWithName:@"HYQiHei" size:16];
    titleLbl.text = title;
    titleLbl.height = 40;
    titleLbl.width = itemView.width;
    titleLbl.x = 0;
    titleLbl.y = btn.y + btn.height;
    if (PDiPhone4_OR_4s) {
        titleLbl.y -= 8;
    }
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [itemView addSubview:titleLbl];
    
    return btn;
}

// ------简单实现一点动画
- (void)addAnimate{
    
    for (int i = 0; i<self.placeButtons.count; i++) {
        ((UIButton *)self.placeButtons[i]).transform = CGAffineTransformMakeScale(0.2, 0.2);
        ((UIImageView *)self.imageArray[i]).transform = CGAffineTransformMakeScale(1.2, 1.2);
        [UIView animateWithDuration:0.2 animations:^{
            ((UIButton *)self.placeButtons[i]).transform = CGAffineTransformMakeScale(1.4, 1.4);
            ((UIImageView *)self.imageArray[i]).transform = CGAffineTransformMakeScale(0.7, 0.7);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                ((UIButton *)self.placeButtons[i]).transform = CGAffineTransformIdentity;
                ((UIImageView *)self.imageArray[i]).transform = CGAffineTransformIdentity;
            }];
            
        }];


    }
    
    
}

#pragma mark -- Bottom View

-(void)setupBottomView
{
    UILabel *favoritePlaceLabel = [[UILabel alloc] init];
    favoritePlaceLabel.x = 20;
    favoritePlaceLabel.y = 10;
    favoritePlaceLabel.width = 100;
    favoritePlaceLabel.height = 30;
    favoritePlaceLabel.text = @"选中地点:";
    favoritePlaceLabel.textColor = PDRGBColor(35, 35, 35);
    favoritePlaceLabel.font = PDFontWithWeight(20, UIFontWeightMedium);
    [self.bottomView addSubview:favoritePlaceLabel];
    
    UILabel *placeLabel = [[UILabel alloc] init];
    placeLabel.x = 20 + favoritePlaceLabel.frame.origin.x + favoritePlaceLabel.frame.size.width;
    placeLabel.y = 10;
    placeLabel.width = PDSCREEN_W/2;
    placeLabel.height = 30;
    placeLabel.text = @"";
    placeLabel.textColor = PDRGBColor(35, 35, 35);
    placeLabel.font = PDFontWithWeight(20, UIFontWeightMedium);
    [self.bottomView addSubview:placeLabel];
    self.place = placeLabel;
    
    UISlider *mySlider = [ [ UISlider alloc ] initWithFrame:CGRectMake((self.width-280)/2,placeLabel.frame.origin.y+placeLabel.frame.size.height+35 ,280 ,40) ];
    mySlider.minimumValue = 0.1;
    mySlider.maximumValue = 10.0;
    mySlider.value = 5.0;
    [mySlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.bottomView addSubview:mySlider];
    
    self.radiusLabel = [[UILabel alloc] init];
    self.radiusLabel.x = self.width/2 -60;
    self.radiusLabel.y = 15 + mySlider.frame.origin.y + mySlider.frame.size.height;
    self.radiusLabel.width = 120;
    self.radiusLabel.height = 40;
    self.radiusLabel.text = @"5.0 KM";
    self.radiusLabel.textColor = PDRGBColor(22, 22, 22);
    self.radiusLabel.font = PDFontWithWeight(30, UIFontWeightLight);
    [self.bottomView addSubview:self.radiusLabel];

    
    self.searchBtn = [[UIButton alloc] init];
    self.searchBtn.x = self.width/4;
    self.searchBtn.y =15 + self.radiusLabel.frame.origin.y + self.radiusLabel.frame.size.height;
    self.searchBtn.width = self.width/2;
    self.searchBtn.height = 50;
    [self.searchBtn setTitle:@"开  始" forState:UIControlStateNormal];
    self.searchBtn.backgroundColor = PDRGBColor(239, 162, 12);
    [self.searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font = PDFontWithWeight(30, UIFontWeightLight);
    self.searchBtn.layer.cornerRadius = 25;
    [self.bottomView addSubview:self.searchBtn];



}

-(void)sliderValueChanged:(UISlider *)sender
{
    NSLog(@"sender value: %.1f",sender.value);
    self.radiusLabel.text = [NSString stringWithFormat:@"%.1f KM",sender.value];
}

@end
