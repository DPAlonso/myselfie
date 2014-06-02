//
//  DPAPhotoController.h
//  myselfie
//
//  Created by David on 17/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>


@protocol PhotoDelegate
-(void)photoHasBeenTaken;
@end

@interface DPAPhotoController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property BOOL newMedia;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *imgHeader;
@property (weak, nonatomic) id<PhotoDelegate> delegate;

- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;

-(NSDictionary*) ImageEXIF:(NSURL*) filePath;
@end

