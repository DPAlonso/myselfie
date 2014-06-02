//
//  DPAPhotoController.m
//  myselfie
//
//  Created by David on 17/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import "DPAPhotoController.h"
#import "DPAAppDelegate.h"
#import "DPAPhoto.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import <ImageIO/ImageIO.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DPAPhotoController ()
@end

@implementation DPAPhotoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.imgHeader setBackgroundColor: UIColorFromRGB(0x0281ab)];
       // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.imgHeader.frame = CGRectMake(0, 0,self.view.frame.size.width, 116);
}

- (void) useCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        imagePicker.showsCameraControls = YES;
        imagePicker.navigationBarHidden = NO;
        imagePicker.wantsFullScreenLayout = NO;
        //imagePicker.cameraViewTransform = CGAffineTransformScale(imagePicker.cameraViewTransform,1.2,1.3);
        
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = YES;
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        _imageView.image = image;
        NSDate *currDate = info.fileCreationDate;
        /*NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"dd.MM.YY HH:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate:currDate];*/
        
        
                if (_newMedia)
        {
            
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            // Request to save the image to camera roll
            [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
                if (error) {
                    NSLog(@"error");
                } else {
                    NSDictionary* imageEXIF = [self ImageEXIF:assetURL];
                    /*if(imageEXIF)
                    {*/
                        float latitude = [[[imageEXIF objectForKey:@"{GPS}"] valueForKey:@"Latitude"] floatValue];
                        float longitude = [[[imageEXIF objectForKey:@"{GPS}"] valueForKey:@"Longitude"] floatValue];
                        
                        
                    [self createNewPhotoWithName:[NSString stringWithFormat:@"%s","Photo"] Date:currDate Longitude:[NSNumber numberWithFloat:longitude] Latitude:[NSNumber numberWithFloat:latitude] Image:[NSString stringWithFormat:@"%@",assetURL]];
                    
                    
                    [self.delegate photoHasBeenTaken];
                }
            
            }];
        }
            /*UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);*/
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {

        
        
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)createNewPhotoWithName:(NSString *)Name
                            Date:(NSDate *)Date
                       Longitude:(NSNumber *)Longitude
                        Latitude:(NSNumber*)Latitude
                           Image:(NSString *) Image
{
    DPAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    BOOL result = NO;
    
    DPAPhoto *newPhoto = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Photo"
                         inManagedObjectContext:managedObjectContext];

    if (newPhoto == nil) {
        NSLog(@"Failed to create the new Photo");
        return NO;
    }
    
    newPhoto.Name = Name;
    newPhoto.Latitude = Latitude;
    newPhoto.Longitude = Longitude;
    newPhoto.Image = Image;
    
    NSError *savingError = nil;
    
    if ([managedObjectContext save:&savingError]) {
        return YES;
    } else {
        NSLog(@"Failed to save the new Photo. Error = %@", savingError);
    }

    return result;
}

-(NSDictionary*) ImageEXIF:(NSURL*) filePath
{
    NSDictionary* exifDictionary = nil;
    NSURL* fileURL = filePath;
    
    if(fileURL)
    {
        
        // load the bit image from the file url
        CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef)fileURL, NULL);
        
        if (source)
        {
            
            // get image properties into a dictionary
            CFDictionaryRef metadataRef = CGImageSourceCopyPropertiesAtIndex(source,0,NULL );
            
            if (metadataRef)
            {
                
                // cast CFDictonaryRef to NSDictionary
                exifDictionary = [NSDictionary dictionaryWithDictionary : (__bridge NSDictionary *)metadataRef];
                CFRelease ( metadataRef );
            }
            
            CFRelease(source);
            source = nil;
        }
    }
    else
    {
        NSLog ( @"Error in reading file");
    }
    
    return exifDictionary;
}


@end
