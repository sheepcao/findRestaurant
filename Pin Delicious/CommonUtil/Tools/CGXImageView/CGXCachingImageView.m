//
//  ECImageView.m
//  ECMoments
//
//  Created by HSBC_XiAn_Core on 9/1/17.
//  Copyright © 2017 EricCao. All rights reserved.
//

#import "CGXCachingImageView.h"
@interface CGXCachingImageView()
@property (nonatomic, strong) NSCache *imageCache;              //memory cache
@property (nonatomic, strong) NSMutableSet *downloadCache;      //download task cache


@end
@implementation CGXCachingImageView

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage ShouldRefresh:(BOOL)shouldRefresh
{
    NSString *cacheKey = [url absoluteString];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [cacheKey lastPathComponent];
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    
    /********** 1 memory cache ************/
    UIImage *image = [self.imageCache objectForKey:cacheKey];
    
    if (image) {
        
        self.image = image;
        if (shouldRefresh) {
            [self downloadImageWithURL:url DiskCachePath:filePath whenRefreshingImage:image];
        }
        
        
    }else{
        
        /********** 2 disk cache ************/
        if (imageData) {
            UIImage *image = [UIImage imageWithData:imageData];
            [self.imageCache setObject:image forKey:cacheKey];
            self.image = image;
            if (shouldRefresh) {
                [self downloadImageWithURL:url DiskCachePath:filePath whenRefreshingImage:image];
            }
        }else{
            
            self.image = placeholderImage;
            
            /********** 3 download task cache ************/
            BOOL isDownloading = [self.downloadCache containsObject:cacheKey];
            
            if (isDownloading) {
                return;
            }
            
            [self downloadImageWithURL:url DiskCachePath:filePath whenRefreshingImage:nil];
            
            
        }
    }
    
}

-(void)downloadImageWithURL:(NSURL *)url DiskCachePath:(NSString *)filePath whenRefreshingImage:(UIImage *)originalImage
{
    NSString *cacheKey = [url absoluteString];
    NSData *originalImageData = nil;
    if (originalImage) {
        originalImageData = UIImagePNGRepresentation(originalImage);
    }
    //    ECWeakSelf(weakSelf);
    
    
    //According to Technical requirements, using GCD to download images async..
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        PDLog(@"Eric: - downloading : %@",url);
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        
        //clear the download cache no matter image returned correctly.
        [self.downloadCache removeObject:cacheKey];
        
        //        ECStrongSelf(strongSelf);
        if (image == nil) {
            PDLog(@"Eric: - nil : %@",url);
            
            return;
        }
        //add to memory & disk cache
        [self.imageCache setObject:image forKey:cacheKey];
        [imageData writeToFile:filePath atomically:YES];
        
        NSData *destImageData = UIImagePNGRepresentation(image);
        
        if ([originalImageData isEqual:destImageData]) {
            PDLog(@"Eric: - same image : %@",url);
            return ;
        }else
        {
            PDLog(@"Eric: - update image : %@",url);
            
            //update UI in main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.image = image;
                
                
            });
        }
        
        
    });
}

@end
