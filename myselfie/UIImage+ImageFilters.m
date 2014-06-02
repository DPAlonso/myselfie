//
//  UIImage+ImageFilters.m
//  myselfie
//
//  Created by David on 29/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import "UIImage+ImageFilters.h"

@implementation UIImage (ImageFilters)


- (UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur {

    CIImage *imageToBlur = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: blur] forKey: @"inputRadius"]; //change number to increase/decrease blur
    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    
    //create UIImage from filtered image
    UIImage *blurrredImage = [[UIImage alloc] initWithCIImage:resultImage scale:1 orientation:UIImageOrientationLeft];
    
    //Place the UIImage in a UIImageView
    return blurrredImage;
    
}


- (UIImage *)filterImage:(UIImage *)image withFilter:(NSString*) filtro{
    
    CIImage *imageToFilter = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *monoFilter = [CIFilter filterWithName: filtro];
    [monoFilter setValue:imageToFilter forKey: @"inputImage"];

    CIImage *resultImage = [monoFilter valueForKey: @"outputImage"];
    
    //create UIImage from filtered image
    UIImage *filteredImage = [[UIImage alloc] initWithCIImage:resultImage];
    
    //Place the UIImage in a UIImageView
    return filteredImage;
    
}
@end
