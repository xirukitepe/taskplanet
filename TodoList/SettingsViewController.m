//
//  SettingsViewController.m
//  TaskPlanet
//
//  Created by Shiela S on 2/15/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constants.h"
#import "AppDelegate.h"

@interface SettingsViewController ()
@property (strong, nonatomic) UILabel *avatarLabel;
@property (strong, nonatomic) UIImageView *imagePreview;
@property (strong, nonatomic) UIButton *takePhotoBtn;
@property (strong, nonatomic) UIButton *pickPhotoBtn;
@property (strong, nonatomic) UIImage *selectedImage;
@end

@implementation SettingsViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    // tab configs
    UIImage *listIcon = [UIImage imageNamed:@"settings"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:nil selectedImage:nil];
    [self.tabBarItem setImage: [listIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userInfo =  [self readData];
    [self.view addSubview:self.avatarLabel];
    [self.view addSubview:self.imagePreview];
    [self.view addSubview:self.takePhotoBtn];
    [self.view addSubview:self.pickPhotoBtn];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    self.userInfo = [self readData];
}

#pragma mark - properties

-(UILabel *)avatarLabel{
    if (!_avatarLabel) {
        _avatarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
//        _avatarLabel.center = CGPointMake(SCREEN_CENTER_X, ELEM_MARGIN + self.view.frame.origin.y);
        _avatarLabel.frame = CGRectMake(SCREEN_MARGIN,  ELEM_MARGIN, _avatarLabel.frame.size.width, _avatarLabel.frame.size.height);
        _avatarLabel.text = @"Profile Avatar";
    }
    return _avatarLabel;
}

-(UIImageView *)imagePreview{
    if (!_imagePreview) {
        _imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, SCREEN_HEIGHT / 4)];
        _imagePreview.center = CGPointMake(SCREEN_CENTER_X, 0);
        _imagePreview.frame = CGRectMake(_imagePreview.frame.origin.x, self.avatarLabel.frame.origin.y + self.avatarLabel.frame.size.height + SCREEN_MARGIN, _imagePreview.frame.size.width, _imagePreview.frame.size.height);
        _imagePreview.layer.borderColor = [UIColor grayColor].CGColor;
        _imagePreview.layer.borderWidth = 1.5f;
        
        if([self.userInfo count] != 0){
            _imagePreview.image = [UIImage imageWithData:[self.userInfo[0] valueForKey:@"avatar"]];
        }
    }
    return _imagePreview;
}

-(UIButton *)takePhotoBtn{
    if (!_takePhotoBtn) {
        _takePhotoBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_CENTER_X  / 2, BUTTON_HEIGHT)];
        _takePhotoBtn.frame = CGRectMake(self.imagePreview.frame.origin.x, self.imagePreview.frame.origin.y + self.imagePreview.frame.size.height + SCREEN_MARGIN, _takePhotoBtn.frame.size.width, _takePhotoBtn.frame.size.height);
        _takePhotoBtn.backgroundColor = [UIColor blackColor];
        _takePhotoBtn.layer.cornerRadius = 3.0f;
        [_takePhotoBtn setTitle:@"Take a photo" forState:UIControlStateNormal];
        _takePhotoBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_takePhotoBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _takePhotoBtn;
}

-(UIButton *)pickPhotoBtn{
    if (!_pickPhotoBtn) {
        _pickPhotoBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_CENTER_X  / 2 , BUTTON_HEIGHT)];
        _pickPhotoBtn.frame = CGRectMake(self.takePhotoBtn.frame.size.width + self.takePhotoBtn.frame.origin.x + SCREEN_MARGIN, self.imagePreview.frame.origin.y + self.imagePreview.frame.size.height + SCREEN_MARGIN, _pickPhotoBtn.frame.size.width, _pickPhotoBtn.frame.size.height);
        _pickPhotoBtn.backgroundColor = [UIColor blackColor];
        _pickPhotoBtn.layer.cornerRadius = 3.0f;
        [_pickPhotoBtn setTitle:@"Select photo" forState:UIControlStateNormal];
        _pickPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_pickPhotoBtn addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _pickPhotoBtn;
}

#pragma mark - methods

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(NSMutableArray *)readData{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Profile"];
    
    NSMutableArray *fetchedObjects  = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    //NSLog(@"%@", fetchedObjects);
    
    return fetchedObjects;
}

-(void)takePhoto{
    if([self checkIfCameraIsAvailable] == YES){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    }
}

-(void)selectPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.selectedImage = info[UIImagePickerControllerEditedImage];
    self.imagePreview.image = self.selectedImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    if(self.selectedImage){
        [self saveAvatar:(UIImage * )self.selectedImage];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(BOOL)checkIfCameraIsAvailable{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return NO;
        
    } else {
        return YES;
    }
}

-(void)saveAvatar:(UIImage * )selectedImage{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profile" inManagedObjectContext:self.managedObjectContext];
    
    // Initialize Record
    NSManagedObject *userInfo = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    
    // Populate Record
    NSData *convertedImage = UIImagePNGRepresentation(selectedImage);
    [userInfo setValue:convertedImage forKey:@"avatar"];
    
    // Save Record
    NSError *error = nil;
    
    if ([self.managedObjectContext save:&error]) {
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"User avatar is saved!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [successAlert show];
        
    } else {
        if (error) {
            NSLog(@"Unable to save avatar.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
        
        // Show Alert View
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your avatar not be saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
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
