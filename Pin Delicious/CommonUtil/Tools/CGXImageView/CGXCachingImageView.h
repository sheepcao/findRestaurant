//
//  CGXCachingImageView.h
//  multi_image_cache_and_download_demo_ssj
//
//  Created by HSBC_XiAn_Core on 8/30/17.
//  Copyright © 2017 Shijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGXCachingImageView : UIImageView
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage ShouldRefresh:(BOOL)shouldRefresh;
@end
