//
//  SearchViewController.h
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchView.h"
#import "SearchViewModel.h"

typedef void (^searchClickHandler)(SearchViewModel *input) ;

@interface SearchViewController : UIViewController
@property (nonatomic,strong) SearchView *searchView;
@property (nonatomic,strong) SearchViewModel *searchViewModel;
@property (nonatomic,copy) searchClickHandler searchHandler;

- (void)addSearchWithSearchClick:(searchClickHandler)handler;
@end
