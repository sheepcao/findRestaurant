//
//  ReviewsTableViewCell.m
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/13/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "ReviewsTableViewCell.h"
#import "Review.h"
#import "XHStarRateView.h"

@implementation ReviewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWith:(Review *)reviewModel
{
    for (UIView * view in self.starContainer.subviews) {
        [view removeFromSuperview];
    }
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(5, 0, 80, 13) numberOfStars:5 currentScore:reviewModel.score rateStyle:WholeStar isInteractive:NO finish:nil];
    [self.starContainer addSubview:starRateView];
    
    self.datelabel.text = reviewModel.date;
    self.contentLabel.text = reviewModel.content;
}
//-(CGFloat)heightForReviewCell:(Review *)reviewModel
//{
//
//
////    CGSize contentSize = [self sizeWithText:content font:[UIFont systemFontOfSize:14.0] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
////    CGFloat contentW =contentSize.width;
////    CGFloat contentH =contentSize.height;
//}
//- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
//{
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//}

@end
