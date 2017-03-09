//
//  CSFileManager.m
//  CamStash
//
//  Created by Joel Myers on 3/9/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import "CSFileManager.h"
#import "CSPicObject.h"

@implementation CSFileManager

static CSFileManager *sharedFileMan = nil;

+(CSFileManager *)sharedManager{
    if (sharedFileMan == nil) {
        sharedFileMan = [[CSFileManager alloc] init];
    }
    return sharedFileMan;
}

-(id)init {
    self = [super init];
    if (self) {
        self.ionicFilesArray = [NSMutableArray new];
        self.picArray = [NSMutableArray new];
        [self setupIonicPhotos];
    }
    return self;
}

-(void)setupIonicPhotos {
    NSError *error;
    NSString *dataPath = [[self documentsPath] stringByAppendingPathComponent:@"/IonicPhotos"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    } else {
        [self readIonicPhotos];
    }
}

//Write Images to Documents/IonicPhotos folder
-(void)saveToIonicPhotos:(UIImage *)image withFileName:(NSString *) filename{
    NSString *filePath = [[self ionicPhotosPath] stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"/%@.jpg", filename]];
    if  (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [data writeToFile:filePath atomically:YES];
    }
    
}

//Read Images from Documents/IonicPhotos folder and fill array
-(void)readIonicPhotos {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self ionicPhotosPath]]) {
         self.ionicFilesArray = (NSMutableArray *)[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self ionicPhotosPath] error:NULL];
        
        for (NSString *str in self.ionicFilesArray) {
            NSString *filePath = [[self ionicPhotosPath] stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"/%@", str]];
            if  ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                CSPicObject *picObj = [[CSPicObject alloc] init];
                picObj.pic = [UIImage imageWithContentsOfFile:filePath];
                picObj.filename = str;
                [self.picArray addObject:picObj];
            }

        }
    }
}

//Documents then create IonicPhotos directory and make that the main path
-(NSString *) documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    return documentsDir;
}

-(NSString *) ionicPhotosPath {
    NSString *dataPath = [[self documentsPath] stringByAppendingPathComponent:@"/IonicPhotos"];
    
    return dataPath;
}


@end
