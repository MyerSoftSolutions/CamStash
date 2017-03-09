//
//  CSDetailViewController.h
//  CamStash
//
//  Created by Joel Myers on 3/8/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *picImage;
@property (strong, nonatomic) IBOutlet UILabel *picFileLabel;
@property (strong, nonatomic) NSMutableArray *picArray;
@property (strong, nonatomic) NSIndexPath *idxPath;


@end
