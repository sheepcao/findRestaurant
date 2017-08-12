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


@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIImageView *img1;
@property(nonatomic,strong)UIImageView *img2;



@end
@implementation SearchView

- (instancetype)init{
    self = [super init];
    if (self) {
        UIView *topView = [[UIView alloc]init];
        self.topView = topView;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self addSubview:self.topView];
    self.topView.y = 0;
    
    
    self.topView.height = PDSCREEN_H*4/7;
    self.topView.width = self.width;
    self.topView.x = 0;
    //    self.topView.backgroundColor = [UIColor greenColor];
    
    self.btn1 = [self btnWithTitle:@"Essex Office" icon:@"office" color:[UIColor orangeColor] index:0];
    self.btn2 = [self btnWithTitle:@"复旦大学" icon:@"college" color:[UIColor redColor] index:1];

    
}


- (UIButton *)btnWithTitle:(NSString *)title icon:(NSString *)icon color:(UIColor *)color index:(int)index{
    
    UILabel *favoritePlaceLabel = [[UILabel alloc] init];
    favoritePlaceLabel.x = 20;
    favoritePlaceLabel.y = 10;
    favoritePlaceLabel.width = PDSCREEN_W/2;
    favoritePlaceLabel.height = 30;
    favoritePlaceLabel.text = @"可选地点:";
    favoritePlaceLabel.textColor = PDRGBColor(35, 35, 35);
    favoritePlaceLabel.font = PDFontWithWeight(21, 0.5);
    [self.topView addSubview:favoritePlaceLabel];
    
    
    int cols = index%3;
    int rows = index/3;
    CGFloat w = self.width/3;
    CGFloat h = self.topView.height-(favoritePlaceLabel.height+2*favoritePlaceLabel.y)/2;
    UIView *itemView = [[UIView alloc]init];
    [self.topView addSubview:itemView];
    itemView.x = cols * w;
    itemView.y = rows * h + 2*favoritePlaceLabel.y;
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
    
    self.btn1.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn2.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    self.img1.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img2.transform = CGAffineTransformMakeScale(1.4, 1.4);

    [UIView animateWithDuration:0.2 animations:^{
        self.btn1.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn2.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.img1.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img2.transform = CGAffineTransformMakeScale(0.7, 0.7);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.btn1.transform = CGAffineTransformIdentity;
            self.btn2.transform = CGAffineTransformIdentity;

            
            self.img1.transform = CGAffineTransformIdentity;
            self.img2.transform = CGAffineTransformIdentity;
        }];
        
    }];
    
}

@end
