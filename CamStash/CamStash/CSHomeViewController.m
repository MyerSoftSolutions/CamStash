//
//  CSHomeViewController.m
//  CamStash
//
//  Created by Joel Myers on 3/8/17.
//  Copyright © 2017 Joel Myers. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSCollectionViewCell.h"
#import "CSDetailViewController.h"
#import "CSFileManager.h"

@interface CSHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) CSFileManager *fileManager;
@property (strong, nonatomic) IBOutlet UICollectionView *stashCollectionView;
@property (strong, nonatomic) NSMutableArray *filesArray;

@end

@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fileManager = [CSFileManager sharedManager];
    
    self.filesArray = [NSMutableArray new];
    self.filesArray = self.fileManager.ionicFilesArray;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takePic:(UIBarButtonItem *)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Device has no camera" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
}

#pragma mark - 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//    self.imageView.image = chosenImage;
    //Save to Documents/IonicPhotos and save to location of Camera
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Filename?" message:@"Input unique filename" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"You pressed button OK");
         [self.fileManager saveToIonicPhotos:chosenImage withFileName:@""];
    }]; 
    
    [alert addAction:defaultAction];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Input data...";
    }];
    
    [self presentViewController:alert animated:YES completion:nil];

   

    
                      
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - UICollectionViewDelegate Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.filesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSCollectionViewCell *cell =  (CSCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CSCollectionViewCell" forIndexPath:indexPath];
    
    
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"ShowDetailSegue"]) {
        
        UICollectionViewCell *cell = (UICollectionViewCell *)sender;
        NSIndexPath *idx =[self.stashCollectionView indexPathForCell:cell];
        NSLog(@"%@", idx);
        
        CSDetailViewController *vc = segue.destinationViewController;
        vc.picArray = self.filesArray;
        vc.idxPath = idx;
    
    }
}
@end
