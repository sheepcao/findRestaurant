//
//  Search.h
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchViewModel;

@interface SearchView : UIView
@property(nonatomic,strong)SearchViewModel *searchViewModel;

- (void)addAnimate;
@end
