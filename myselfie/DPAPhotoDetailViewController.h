//
//  DPAPhotoDetailViewController.h
//  myselfie
//
//  Created by David on 01/06/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DPAPhotoDetailViewControllerDelegate
-(void)bigPhoto:(UIImage*) img;

@end

@interface DPAPhotoDetailViewController : UITableViewController <UIGestureRecognizerDelegate, DPAPhotoDetailViewControllerDelegate>

@property (nonatomic, strong) NSArray* Data;

- (void)imageBeginTap:(UIGestureRecognizer *)gestureRecognizer;
-(id) initWithImage:(UIImage*) img photoDate:(NSString*) date;

@end
