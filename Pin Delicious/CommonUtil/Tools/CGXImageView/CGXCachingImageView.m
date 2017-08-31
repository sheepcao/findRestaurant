//
//  CGXCachingImageView.m
//  multi_image_cache_and_download_demo_ssj
//
//  Created by HSBC_XiAn_Core on 8/30/17.
//  Copyright © 2017 Shijie. All rights reserved.
//
/** 弱指针*/
#define PDWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define PDStrongSelf(strongSelf) __strong __typeof(&*self)strongSelf = weakSelf;
/** 输出*/
#ifdef DEBUG
#define PDLog(...) NSLog(__VA_ARGS__)
#else
#define PDLog(...)
#endif

#import "CGXCachingImageView.h"

@interface CGXCachingImageView()
@property (nonatomic, strong) NSCache *imageCache;              //memory cache
@property (nonatomic, strong) NSMutableSet *downloadCache;      //download task cache


@end

@implementation CGXCachingImageView

-(NSCache *)imageCache
{
    if (!_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache ;
}
-(NSMutableSet *)downloadCache
{
    if (!_downloadCache) {
        _downloadCache = [[NSMutableSet alloc] init];
    }
    return _downloadCache ;
}

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
    PDWeakSelf(weakSelf);


    //According to Technical requirements, using GCD to download images async..
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        PDLog(@"Eric: - downloading : %@",url);
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        
        //clear the download cache no matter image returned correctly.
        [self.downloadCache removeObject:cacheKey];
        
        PDStrongSelf(strongSelf);
        if (image == nil) {
            return;
        }
        //add to memory & disk cache
        [strongSelf.imageCache setObject:image forKey:cacheKey];
        [imageData writeToFile:filePath atomically:YES];
        
        //update UI in main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([originalImageData isEqual:imageData]) {
                return ;
            }else
            {
                strongSelf.image = image;
            }
            
        });
    });
}





@end
