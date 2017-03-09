//
//  CSDetailViewController.m
//  CamStash
//
//  Created by Joel Myers on 3/8/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import "CSDetailViewController.h"
#import "CSFileManager.h"
#import "CSPicObject.h"

@interface CSDetailViewController ()

@end

NSUInteger idxRow;
@implementation CSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.picArray = [NSMutableArray new];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    idxRow = self.idxPath.row;
    self.picArray =  [CSFileManager sharedManager].picArray;
    CSPicObject *picObj = (CSPicObject *)[self.picArray objectAtIndex:idxRow];
    self.picImage.image = picObj.pic;
    self.picFileLabel.text = picObj.filename;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender {
    if ((idxRow + 1) <= (self.picArray.count - 1)) {
        idxRow += 1;
        CSPicObject *picObj = (CSPicObject *)[self.picArray objectAtIndex:idxRow];
        [self.picImage setImage: picObj.pic];
        self.picFileLabel.text = picObj.filename;
    }
   }

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    if ((idxRow) > 0) {
        idxRow -= 1;
        CSPicObject *picObj = (CSPicObject *)[self.picArray objectAtIndex:idxRow];
        [self.picImage setImage: picObj.pic];
        self.picFileLabel.text = picObj.filename;
    }

    
}

- (IBAction)dismissDetail:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
