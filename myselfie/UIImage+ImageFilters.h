//
//  UIImage+ImageFilters.h
//  myselfie
//
//  Created by David on 29/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageFilters)

- (UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur;

- (UIImage *)filterImage:(UIImage *)image withFilter:(NSString*) filtro;

@end
