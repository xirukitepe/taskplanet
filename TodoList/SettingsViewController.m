//
//  SettingsViewController.m
//  TaskPlanet
//
//  Created by Shiela S on 2/15/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "SettingsViewController.h"
#import "Constants.h"
#import "FeedbackViewController.h"
#import <CoreData/CoreData.h>

@interface SettingsViewController ()
@property (strong, nonatomic) UILabel *avatarLabel;
@property (strong, nonatomic) UIImageView *imagePreview;
@property (strong, nonatomic) UIButton *takePhotoBtn;
@property (strong, nonatomic) UIButton *pickPhotoBtn;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) UILabel *settingsLabel;
@property (strong, nonatomic) NSArray *rows;
@property (strong, nonatomic) MFMailComposeViewController *mc;
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
    [self.view addSubview:self.settingsLabel];
    [self.view addSubview:self.tableView];
    [self setAvatar];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellSettings"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.rows = @[@"Send Feedback", @"Share to a friend via email", @"Share to a friend via SMS" ,@"Log Out"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    self.userInfo = [self readData];
    [self setAvatar];
}

#pragma mark - properties

-(UILabel *)avatarLabel{
    if (!_avatarLabel) {
        _avatarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
//        _avatarLabel.center = CGPointMake(SCREEN_CENTER_X, ELEM_MARGIN + self.view.frame.origin.y);
        _avatarLabel.frame = CGRectMake(SCREEN_MARGIN, SCREEN_MARGIN, _avatarLabel.frame.size.width, _avatarLabel.frame.size.height);
        _avatarLabel.text = @"Profile Avatar";
    }
    return _avatarLabel;
}

-(UILabel *)settingsLabel{
    if (!_settingsLabel) {
        _settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _settingsLabel.frame = CGRectMake(SCREEN_MARGIN,  self.pickPhotoBtn.frame.origin.y + self.pickPhotoBtn.frame.size.height + ELEM_MARGIN, _settingsLabel.frame.size.width, _settingsLabel.frame.size.height);
        _settingsLabel.text = @"Settings & Privacy";
        _settingsLabel.textColor = BUTTON_BG_GREEN;
        _settingsLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    return _settingsLabel;
}

-(UIImageView *)imagePreview{
    if (!_imagePreview) {
        _imagePreview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, SCREEN_HEIGHT / 4)];
        _imagePreview.center = CGPointMake(SCREEN_CENTER_X, 0);
        _imagePreview.frame = CGRectMake(_imagePreview.frame.origin.x, self.avatarLabel.frame.origin.y + self.avatarLabel.frame.size.height + SCREEN_MARGIN, _imagePreview.frame.size.width, _imagePreview.frame.size.height);
        _imagePreview.layer.borderColor = [UIColor grayColor].CGColor;
        _imagePreview.layer.borderWidth = 1.5f;
    }
    return _imagePreview;
}

-(UIButton *)takePhotoBtn{
    if (!_takePhotoBtn) {
        _takePhotoBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.imagePreview.frame.size.width / 2, BUTTON_HEIGHT)];
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
        _pickPhotoBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.imagePreview.frame.size.width / 2 - SCREEN_MARGIN , BUTTON_HEIGHT)];
        _pickPhotoBtn.frame = CGRectMake(self.takePhotoBtn.frame.size.width + self.takePhotoBtn.frame.origin.x + SCREEN_MARGIN, self.imagePreview.frame.origin.y + self.imagePreview.frame.size.height + SCREEN_MARGIN, _pickPhotoBtn.frame.size.width, _pickPhotoBtn.frame.size.height);
        _pickPhotoBtn.backgroundColor = [UIColor blackColor];
        _pickPhotoBtn.layer.cornerRadius = 3.0f;
        [_pickPhotoBtn setTitle:@"Select photo" forState:UIControlStateNormal];
        _pickPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_pickPhotoBtn addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _pickPhotoBtn;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.settingsLabel.frame.origin.y + self.settingsLabel.frame.size.height + SCREEN_MARGIN, SCREEN_WIDTH, SCREEN_HEIGHT - self.imagePreview.frame.size.height - (ELEM_MARGIN * 2) - self.pickPhotoBtn.frame.origin.y - self.pickPhotoBtn.frame.size.height)];
        _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
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

    // Get userID
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefaults objectForKey:@"userID"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K == %@", @"userID", userID]];
    
    NSMutableArray *fetchedObjects  = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    return fetchedObjects;
}

- (void)setAvatar{
    if([self.userInfo count] != 0){
        self.imagePreview.image = [UIImage imageWithData:[self.userInfo[0] valueForKey:@"avatar"]];
    } else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if([userDefaults objectForKey:@"userID"] != nil){
            self.imagePreview.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200", [userDefaults objectForKey:@"userID"]]]]];
        }
    }
}

-(void)takePhoto{
    if([self checkIfCameraIsAvailable] == YES){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [errorAlert show];
    }
}

-(void)selectPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(BOOL)checkIfCameraIsAvailable{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return NO;
        
    } else {
        return YES;
    }
}

-(void)saveAvatar:(UIImage * )selectedImage{
    
    // Get Entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Profile" inManagedObjectContext:self.managedObjectContext];
    
    // Convert to PNG
    NSData *convertedImage = UIImagePNGRepresentation(selectedImage);
    
    if ([self.userInfo count] != 0) {
        // Update Record
        [self.userInfo[0] setValue:convertedImage forKey:@"avatar"];
    } else{
        
        // Get userID
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
        // Initialize Record
        NSManagedObject *userInfo = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        
        // Populate Record
        [userInfo setValue:convertedImage forKey:@"avatar"];
        [userInfo setValue:[userDefaults objectForKey:@"userID"] forKey:@"userID"];
        
    }
    
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

-(void)showMailComposer{
    if([MFMailComposeViewController canSendMail]){
        // Email Subject
        NSString *emailTitle = @"Feedback for Task Planet";
        // Email Content
        NSString *messageBody = @"Your feedback here.";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"shielas@sourcepad.com"];
        
        self.mc = [[MFMailComposeViewController alloc] init];
        self.mc.mailComposeDelegate = self;
        [self.mc setSubject:emailTitle];
        [self.mc setMessageBody:messageBody isHTML:NO];
        [self.mc setToRecipients:toRecipents];
        
        
        // Present mail view controller on screen
        [self presentViewController:self.mc animated:YES completion:NULL];
    } else {
        NSLog(@"Can't send email at this time.");
    }
}

-(void)showActivityController{
    NSString *textToShare = @"Look at this awesome todo list app!";
    NSURL *myWebsite = [NSURL URLWithString:@"http://taskplanet.com/"];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

-(void)showSMS{
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[@"12345678", @"72345524"];
    NSString *message = @"Here comes the happiest place on your phone, the Task Planet!";
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

#pragma mark - delegate methods

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

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc] init];
    //CommonViewController *common = [[CommonViewController alloc] init];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    //tabBarController.viewControllers = [common initializeViews];
    switch (indexPath.row) {
        case 0:
            //[self.navigationController pushViewController:feedbackViewController animated:YES];
            [self showMailComposer];
            break;
        case 1:
            [self showActivityController];
            break;
        case 2:
            [self showSMS];
            break;
        default:
            [self presentViewController:tabBarController animated:YES completion:nil];
            break;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}

// This will tell your UITableView how many rows you wish to have in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellSettings";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.rows objectAtIndex:indexPath.row];
    }
    
    return cell;

}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
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
