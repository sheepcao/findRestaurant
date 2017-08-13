//
//  ReviewsTableViewCell.h
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/13/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Review;

@interface ReviewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *starContainer;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;


-(void)setupCellWith:(Review *)reviewModel;
@end
