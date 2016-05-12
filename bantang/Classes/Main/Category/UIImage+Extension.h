//
//  UIImage+Extension.h
//  微博01-主框架
//
//  Created by MS on 15-12-2.
//  Copyright (c) 2015年 students. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据图片名返回一张能够自由拉伸的图片
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+(UIImage *)resizedImageWithName:(NSString *)name;
@end
