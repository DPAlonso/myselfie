//
//  DPAAppDelegate.h
//  myselfie
//
//  Created by David on 12/04/14.
//  Copyright (c) 2014 David. All rights reserved.
//

#import <UIKit/UIKit.h>


@class tabbarViewController;

@interface DPAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) tabbarViewController *viewController;

@end
