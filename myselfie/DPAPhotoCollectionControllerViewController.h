//
//  DPAPhotoCollectionControllerViewController.h
//  myselfie
//
//  Created by David on 18/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPAPhotos.h"
#import "DPAPhotoController.h"


@interface DPAPhotoCollectionControllerViewController : UICollectionViewController <PhotoDelegate>
@property (strong, nonatomic) DPAPhotos *photos;
@property (strong, nonatomic) UIView* indview;

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
