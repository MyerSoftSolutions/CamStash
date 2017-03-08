//
//  CSHomeViewController.m
//  CamStash
//
//  Created by Joel Myers on 3/8/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSCollectionViewCell.h"

@interface CSHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *stashCollectionView;
@property (strong, nonatomic) NSMutableArray *filesArray;

@end

@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takePic:(UIBarButtonItem *)sender {
}

#pragma mark - UICollectionViewDelegate Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.filesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSCollectionViewCell *cell =  (CSCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CSCollectionViewCell" forIndexPath:indexPath];
    
    
    return cell;
    
}
@end
