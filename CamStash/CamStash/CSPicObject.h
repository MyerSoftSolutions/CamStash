//
//  CSPicObject.h
//  CamStash
//
//  Created by Joel Myers on 3/9/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CSPicObject : NSObject

@property (strong, nonatomic) UIImage *pic;
@property (strong, nonatomic) NSString *filename;

@end
