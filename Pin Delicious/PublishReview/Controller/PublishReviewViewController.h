//
//  PublishReviewViewController.h
//  Pin Delicious
//
//  Created by HSBC_XiAn_Core on 8/13/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Restaurant;

@interface PublishReviewViewController : UIViewController
@property (nonatomic,strong) Restaurant *restaurant;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;
@end
