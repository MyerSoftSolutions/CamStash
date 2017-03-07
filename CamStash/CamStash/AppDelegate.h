//
//  AppDelegate.h
//  CamStash
//
//  Created by Joel Myers on 3/7/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

