//
//  CSFileManager.h
//  CamStash
//
//  Created by Joel Myers on 3/9/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CSFileManager : NSObject

@property (nonatomic, strong) NSMutableArray *ionicFilesArray;

+(CSFileManager *)sharedManager;

-(void)readIonicPhotos;
-(void)saveToIonicPhotos:(UIImage *)image withFileName:(NSString *) filename;
-(NSString *)documentsPath;
-(NSString *) ionicPhotosPath;

@end
