//
//  Row.m
//  myselfie
//
//  Created by David on 01/06/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import "Row.h"

@implementation Row

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) init
{
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)imageBeginTap:(UIGestureRecognizer *)gestureRecognizer
{
    
}

- (IBAction)imagePush:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Do you want to say hello?" message:@"More info..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Say Hello",nil];
    [alert show];
}
@end
