//
//  DPAPhotos.h
//  myselfie
//
//  Created by David on 17/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPAPhoto.h"

@interface DPAPhotos : NSObject
@property (strong, nonatomic) NSMutableArray* photoCollection;
@property (nonatomic, strong) NSArray *photos;

-(id) initPhotos;
-(void) addPhoto:(DPAPhoto *) Photo;
-(int) photoCount;
-(DPAPhoto *) photoAtIndex:(int) Index;


@end
