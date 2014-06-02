//
//  DPAPhoto.h
//  myselfie
//
//  Created by David on 13/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DPAPhoto : NSManagedObject

@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSDate *Date;
@property (nonatomic, strong) NSNumber *Latitude;
@property (nonatomic, strong) NSNumber *Longitude;
@property (nonatomic, strong) NSArray *Faces;
@property (nonatomic, strong) NSData *Image;

/*-(id) initPhotoWithName:(NSString*) Name
                   Date:(NSDate*) Date
               Latitude:(NSNumber*) Latitude
              Longitude:(NSNumber*) Longitude
                  Faces:(NSArray*) Faces
                  Image:(NSData*) Image;*/

/*+(id) PhotoWithName:(NSString*) Name
                   Date:(NSDate*) Date
               Latitude:(NSNumber*) Latitude
              Longitude:(NSNumber*) Longitude
                  Faces:(NSArray*) Faces
                  Image:(NSData*) Image;*/

+ (instancetype)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)moc;

@end
