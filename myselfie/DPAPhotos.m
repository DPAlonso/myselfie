//
//  DPAPhotos.m
//  myselfie
//
//  Created by David on 17/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import "DPAPhotos.h"
#import "DPAPhoto.h"
#import "DPAAppDelegate.h"

@implementation DPAPhotos

-(id) initPhotos
{
    self.photoCollection = [[NSMutableArray alloc] init];
    
    DPAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Photo" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.photos = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [self.photoCollection addObjectsFromArray:self.photos];
    return [self init];
}

-(void) addPhoto:(DPAPhoto *)Photo
{
    [_photoCollection addObject:Photo];
}

-(int)photoCount{
    return [self.photoCollection count];
}


-(NSManagedObject*)photoAtIndex:(int)index{
    return [self.photoCollection objectAtIndex:index];
}
@end
