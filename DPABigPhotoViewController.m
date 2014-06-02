//
//  DPABigPhotoViewController.m
//  myselfie
//
//  Created by David on 31/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import "DPABigPhotoViewController.h"


@interface DPABigPhotoViewController ()

@end

@implementation DPABigPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)Item1:(id)sender {
    UIImage *filter = [[[UIImage alloc] init] filterImage:self.img withFilter:@"CIPhotoEffectMono"];
    [self.Photo setImage:filter];
}

- (IBAction)Item2:(id)sender {
    UIImage *filter = [[[UIImage alloc] init] filterImage:self.img withFilter:@"CISepiaTone"];
    [self.Photo setImage:filter];
}

- (IBAction)Item3:(id)sender {
    UIImage *filter = [[[UIImage alloc] init] filterImage:self.img withFilter:@"CIPhotoEffectNoir"];
    [self.Photo setImage:filter];
}

- (IBAction)Item4:(id)sender {
    UIImage *filter = [[[UIImage alloc] init] filterImage:self.img withFilter:@"CIPhotoEffectInstant"];
    [self.Photo setImage:filter];
}

- (IBAction)Item5:(id)sender {
    UIImage *filter = [[[UIImage alloc] init] filterImage:self.img withFilter:@"CIPhotoEffectFade"];
    [self.Photo setImage:filter];
}

-(id) initWithImage:(UIImage *)img
{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
    
        self.img = [UIImage imageWithCGImage:img.CGImage scale:1 orientation:UIImageOrientationUp];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.Photo setImage:[UIImage imageWithCGImage:self.img.CGImage]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
