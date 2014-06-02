//
//  DPAPhoto.m
//  myselfie
//
//  Created by David on 13/05/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import "DPAPhoto.h"

@implementation DPAPhoto

/*-(id) initPhotoWithName:(NSString*) Name
                  Date:(NSDate*) Date
              Latitude:(NSNumber*) Latitude
             Longitude:(NSNumber*) Longitude
                 Faces:(NSArray*) Faces
                 Image:(NSData*) Image
            {
                if (self = [super init]) {
                    Name = Name;
                    _Date = Date;
                    _Latitude = Latitude;
                    _Longitude = Longitude;
                    _Faces = Faces;
                    _Image = Image;
                    
                }
                return self;

            }*/

/*+(id) PhotoWithName:(NSString*) Name
               Date:(NSDate*) Date
           Latitude:(NSNumber*) Latitude
          Longitude:(NSNumber*) Longitude
              Faces:(NSArray*) Faces
              Image:(NSData*) Image
{
    return [[self init] initPhotoWithName:Name Date:Date Latitude:Latitude Longitude:Longitude Faces:Faces Image:Image];
}*/

@dynamic Name;
@dynamic Latitude;
@dynamic Longitude;
@dynamic Faces;
@dynamic Image;

+ (instancetype)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)moc
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                         inManagedObjectContext:moc];
}

@end
