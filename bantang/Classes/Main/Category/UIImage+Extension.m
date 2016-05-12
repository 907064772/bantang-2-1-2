//
//  UIImage+Extension.m
//  微博01-主框架
//
//  Created by MS on 15-12-2.
//  Copyright (c) 2015年 students. All rights reserved.
//

#import "UIImage+Extension.h"
@implementation UIImage (Extension)


+(UIImage *)resizedImageWithName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

@end
