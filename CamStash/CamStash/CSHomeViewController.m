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
#import "CSPicObject.h"

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
    self.filesArray = self.fileManager.picArray;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDelegate Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.filesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CSCollectionViewCell *cell =  (CSCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CSCollectionViewCell" forIndexPath:indexPath];
    CSPicObject *obj = [self.filesArray objectAtIndex:indexPath.row];
    cell.thumbImage.image = obj.pic;
    cell.fileNameLabel.text = obj.filename;
    
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

#pragma mark - ImagePickerController Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //    self.imageView.image = chosenImage;
    //Save to Documents/IonicPhotos and save to location of Camera
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Filename?" message:@"Input unique filename" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UITextField *field = (UITextField *)alert.textFields.firstObject;
        [self.fileManager saveToIonicPhotos:chosenImage withFileName: field.text];
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        NSUInteger count = self.fileManager.ionicFilesArray.count;
        textField.text = [NSString stringWithFormat:@"Image_%lu", (unsigned long)count];
        textField.highlighted = YES;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
