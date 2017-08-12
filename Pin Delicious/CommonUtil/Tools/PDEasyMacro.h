//
//  PDEasyMacro.h
//  PDEasyMacroDemo
//
//  Created by dongshangxian on 15/10/8.
//  Copyright © 2015年 Sankuai. All rights reserved.
//

#ifndef PDEasyMacro_h
#define PDEasyMacro_h

/** 字体*/
#define PDFont(x) [UIFont systemFontOfSize:x]
#define PDBoldFont(x) [UIFont boldSystemFontOfSize:x]
#define PDFontWithWeight(size,wight) [UIFont systemFontOfSize:size weight:wight]

/** 颜色*/
#define PDRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define PDRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define PDRGB16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 输出*/
#ifdef DEBUG
#define PDLog(...) NSLog(__VA_ARGS__)
#else
#define PDLog(...)
#endif

/** 获取硬件信息*/
#define PDSCREEN_W [UIScreen mainScreen].bounds.size.width
#define PDSCREEN_H [UIScreen mainScreen].bounds.size.height
#define PDCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define PDCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]


/** 适配*/
#define PDiOS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define PDiOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define PDiOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define PDiOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define PDiOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define PDiPhone4_OR_4s    (PDSCREEN_H == 480)
#define PDiPhone5_OR_5c_OR_5s   (PDSCREEN_H == 568)
#define PDiPhone6_OR_6s   (PDSCREEN_H == 667)
#define PDiPhone6Plus_OR_6sPlus   (PDSCREEN_H == 736)
#define PDiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 弱指针*/
#define PDWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define PDStrongSelf(strongSelf) __strong __typeof(&*self)strongSelf = weakSelf;

/** 加载本地文件*/
#define PDLoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define PDLoadArray(file,type) [UIImage arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define PDLoadDict(file,type) [UIImage dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

/** 多线程GCD*/
#define PDGlobalGCD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define PDMainGCD(block) dispatch_async(dispatch_get_main_queue(),block)

/** 数据存储*/
#define PDUserDefaults [NSUserDefaults standardUserDefaults]
#define PDCacheDir [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define PDDocumentDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define PDTempDir NSTemporaryDirectory()



#endif /* PDEasyMacro_h */
