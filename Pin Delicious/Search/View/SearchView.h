//
//  Search.h
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchViewModel;

typedef void (^layoutCompleteion)() ;


@interface SearchView : UIView

@property(nonatomic,strong)UIButton *btnOne;
@property(nonatomic,strong)UIButton *btnTwo;

@property(nonatomic,strong)NSMutableArray *placeButtons;


@property(nonatomic,strong) UILabel *radiusLabel;
@property(nonatomic,strong)UILabel *place;

@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)NSArray *favoritePlaces;
@property(nonatomic,copy)layoutCompleteion layoutHandler;


- (void)addAnimate;
- (void)setupSubViews:(NSArray *)favoritePlaces;
- (instancetype)initWithFavoritePlaces:(NSArray *)favoritePlaces LayoutComplete:(layoutCompleteion)handler;
@end
