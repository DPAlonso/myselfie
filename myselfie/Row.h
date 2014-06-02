//
//  Row.h
//  myselfie
//
//  Created by David on 01/06/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Row : UITableViewCell <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *date;



@property (nonatomic, strong) NSArray* data;

-(id) init;



@end
