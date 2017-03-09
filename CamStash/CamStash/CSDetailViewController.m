//
//  CSDetailViewController.m
//  CamStash
//
//  Created by Joel Myers on 3/8/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import "CSDetailViewController.h"

@interface CSDetailViewController ()

@end

@implementation CSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.picArray = [NSMutableArray new];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.picImage.image = (UIImage *)[self.picArray objectAtIndex:self.idxPath.row];
//    self.picFileLabel.text = 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissDetail:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
