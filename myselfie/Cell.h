//
//  Cell.h
//  myselfie
//
//  Created by David on 28/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
