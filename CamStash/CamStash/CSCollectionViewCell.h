//
//  CSCollectionViewCell.h
//  CamStash
//
//  Created by Joel Myers on 3/8/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *thumbImage;

@end
