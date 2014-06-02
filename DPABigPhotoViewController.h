//
//  DPABigPhotoViewController.h
//  myselfie
//
//  Created by David on 31/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageFilters.h"

@interface DPABigPhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *Photo;
@property (nonatomic, strong) UIImage* img;


- (IBAction)Item1:(id)sender;
- (IBAction)Item2:(id)sender;
- (IBAction)Item3:(id)sender;
- (IBAction)Item4:(id)sender;
- (IBAction)Item5:(id)sender;


-(id) initWithImage:(UIImage *)img;
@end
