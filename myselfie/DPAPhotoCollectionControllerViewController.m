//
//  DPAPhotoCollectionControllerViewController.m
//  myselfie
//
//  Created by David on 18/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import "DPAPhotoCollectionControllerViewController.h"
#import "DPAAppDelegate.h"
#import "DPAPhoto.h"
#import "Cell.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import "UIImage+ImageFilters.h"
#import "DPABigPhotoViewController.h"
#import "DPAPhotoDetailViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DPAPhotoCollectionControllerViewController ()

@end

@implementation DPAPhotoCollectionControllerViewController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}*/

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.indview = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 150)];
}

- (void)viewDidLoad
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"Cell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:@"MyCell"];
    
    self.photos = [[DPAPhotos alloc] initPhotos];
    //self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
        self.indview = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 150)];
    
    /*
    UIImageView *imageBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    UIImage *photo = [self.photos photoAtIndex:[self.photos photoCount]];
    
    UIImage *blurred = [[[UIImage alloc] init] blurryImage:[UIImage imageNamed:@"risingsun.png"] withBlurLevel:10.0];
    [imageBackground setImage:blurred];
    

    self.collectionView.backgroundView = imageBackground;*/
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"Cell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:@"MyCell"];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    //NSLog([NSString stringWithFormat:@"%d",[self.photos photoCount]]);
    return [self.photos photoCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   [self.indview setHidden:false];

    
    [self.indview setBackgroundColor: UIColorFromRGB(0x0281ab)];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(self.view.frame.size.width / 2, 100);
    
    spinner.hidesWhenStopped = YES;
    
    [self.indview addSubview:spinner];
    [self.view addSubview:self.indview];
    
    [spinner startAnimating];
    
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    NSManagedObject *record = [self.photos photoAtIndex:indexPath.row];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        @autoreleasepool {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            UIImage *largeimage = [UIImage imageWithCGImage:iref scale:0.0 orientation:UIImageOrientationRight];
            
            largeimage = [self imageWithImage:largeimage scaledToSize:CGSizeMake(120, 120)];
            [cell.image setImage:largeimage];
            [spinner stopAnimating];
            [self.indview setHidden:true];
             }
        }
    };
    
             ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
             {
                 NSLog(@"Can't get image - %@",[myerror localizedDescription]);
                 [spinner stopAnimating];
                 [self.indview setHidden:true];
             };
    
    [cell.date setText:[NSString stringWithFormat:@"%@", [record valueForKey:@"date"]]];
    
     NSURL *asseturl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [record valueForKey:@"image"]]];
     ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
     [assetslibrary assetForURL:asseturl
                    resultBlock:resultblock
                   failureBlock:failureblock];
    
    
    //[cell.date setText:[NSString stringWithFormat:@"%@", photo.Date]];
    
    //cell.backgroundColor = [UIColor redColor];
    //self.cellColor = !self.cellColor;
    
    return cell;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *record = [self.photos photoAtIndex:indexPath.row];
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        @autoreleasepool {
            ALAssetRepresentation *rep = [myasset defaultRepresentation];
            CGImageRef iref = [rep fullScreenImage];
            if (iref) {
               
                    /*DPABigPhotoViewController *bigVC = [[DPABigPhotoViewController alloc] initWithImage:[UIImage imageWithCGImage:iref scale:1 orientation:UIImageOrientationRight]];

                     [self.navigationController pushViewController:bigVC animated:YES];
                */
                
                NSString *date = [NSString stringWithFormat:@"%@", [record valueForKey:@"date"]];
                
                DPAPhotoDetailViewController *bigVC =[[DPAPhotoDetailViewController alloc] initWithImage:[UIImage imageWithCGImage:iref scale:1 orientation:UIImageOrientationUp] photoDate: date];
                
                [self.navigationController pushViewController:bigVC animated:YES];

            }
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
    };
    
    
    NSURL *asseturl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [record valueForKey:@"image"]]];
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:asseturl
                   resultBlock:resultblock
                  failureBlock:failureblock];
    
}
#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
    //self.searchResults[searchTerm][indexPath.row];
    // 2
    //CGSize retval = photo.thumbnail.size.width &gt; 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
    //retval.height += 35; retval.width += 35; return retval;
    CGSize retval = CGSizeMake(157, 170);
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50,20 , 50, 20);
}

-(void)photoHasBeenTaken
{
    //PORK COJONES NO TE EJECUTAS!!!!!
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
