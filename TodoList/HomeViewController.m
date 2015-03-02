//
//  HomeViewController.m
//  TaskPlanet
//
//  Created by Shiela S on 2/17/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//


#import "HomeViewController.h"
#import "TableViewController.h"
#import "CreateToDoViewController.h"
#import "SettingsViewController.h"
#import "LocationViewController.h"
#import "Constants.h"

@interface HomeViewController ()
@property (strong, nonatomic) UILabel *welcomeMessage;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) UILabel *taskPlanet;
@property (strong, nonatomic) FBLoginView *loginView;
@property (strong, nonatomic) UIButton *helpBtn;
@property (strong, nonatomic) UIButton *aboutBtn;
@property (strong, nonatomic) UIPopoverController *aboutPopover;
@property (strong, nonatomic) UIButton *locationBtn;
@end

@implementation HomeViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    // tab configs
    UIImage *homeIcon = [UIImage imageNamed:@"home"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil selectedImage:nil];
    [self.tabBarItem setImage: [homeIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hideTabBar];

    [self.view setBackgroundColor: BUTTON_BG_GREEN];
    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.taskPlanet];
    [self.view addSubview:self.welcomeMessage];
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.helpBtn];
    [self.view addSubview:self.aboutBtn];
    [self.view addSubview:self.locationBtn];
}

-(void)viewDidAppear:(BOOL)animated{
    [self hideTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - properties

-(ADBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[ADBannerView alloc]initWithFrame:
                       CGRectMake(0, SCREEN_MARGIN * 2, SCREEN_WIDTH, 50)];
        [_bannerView setBackgroundColor:[UIColor clearColor]];
    }
    return _bannerView;
}

-(UILabel *)taskPlanet{
    if (!_taskPlanet) {
        _taskPlanet = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 30)];
        _taskPlanet.center = CGPointMake(SCREEN_CENTER_X, SCREEN_CENTER_Y / 2);
        _taskPlanet.frame = CGRectMake(_taskPlanet.frame.origin.x, _taskPlanet.frame.origin.y, _taskPlanet.frame.size.width, _taskPlanet.frame.size.height);
        _taskPlanet.text = @"Task Planet";
        _taskPlanet.textColor = [UIColor whiteColor];
        _taskPlanet.font = [UIFont boldSystemFontOfSize:40];
    }
    
    return _taskPlanet;
}

-(UILabel *)welcomeMessage{
    if (!_welcomeMessage) {
        _welcomeMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _welcomeMessage.center = CGPointMake(SCREEN_CENTER_X, self.taskPlanet.frame.origin.y + self.taskPlanet.frame.size.height + (ELEM_MARGIN  * 2));
        _welcomeMessage.frame = CGRectMake(_welcomeMessage.frame.origin.x, _welcomeMessage.frame.origin.y, _welcomeMessage.frame.size.width, _welcomeMessage.frame.size.height);
        _welcomeMessage.font = [UIFont boldSystemFontOfSize:20];
        _welcomeMessage.textColor = [UIColor whiteColor];
    }
    
    return _welcomeMessage;
}

-(FBLoginView *)loginView{
    if (!_loginView) {
        _loginView = [[FBLoginView alloc] initWithFrame:CGRectMake(0, 0, 100, BUTTON_HEIGHT)];
        _loginView.center = CGPointMake(SCREEN_CENTER_X, self.welcomeMessage.frame.origin.y + self.welcomeMessage.frame.size.height + (ELEM_MARGIN  * 2));
        _loginView.frame = CGRectMake(_loginView.frame.origin.x, _loginView.frame.origin.y, _loginView.frame.size.width, _loginView.frame.size.height);
        _loginView.delegate = self;
        _loginView.readPermissions = @[@"public_profile", @"email"];
    }
    return _loginView;
}

-(UIButton *)helpBtn{
    if (!_helpBtn) {
        _helpBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 159, 33)];
        _helpBtn.center = CGPointMake(SCREEN_CENTER_X, self.loginView.frame.origin.y + self.loginView.frame.size.height + (ELEM_MARGIN * 2));
        _helpBtn.frame = CGRectMake(_helpBtn.frame.origin.x, _helpBtn.frame.origin.y, _helpBtn.frame.size.width, _helpBtn.frame.size.height);
        [_helpBtn setTitle:@"Help" forState:UIControlStateNormal];
        [_helpBtn addTarget:self action:@selector(showHelpMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    return _helpBtn;
}

-(UIButton *)aboutBtn{
    if (!_aboutBtn) {
        _aboutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 159, 33)];
        _aboutBtn.center = CGPointMake(SCREEN_CENTER_X, self.helpBtn.frame.origin.y + self.helpBtn.frame.size.height + SCREEN_MARGIN);
        _aboutBtn.frame = CGRectMake(_aboutBtn.frame.origin.x, _aboutBtn.frame.origin.y, _aboutBtn.frame.size.width, _aboutBtn.frame.size.height);
        [_aboutBtn setTitle:@"About" forState:UIControlStateNormal];
        [_aboutBtn addTarget:self action:@selector(showAboutWindow:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aboutBtn;
}

-(UIButton *)locationBtn{
    if (!_locationBtn) {
        _locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 159, 33)];
        _locationBtn.center = CGPointMake(SCREEN_CENTER_X, self.aboutBtn.frame.origin.y + self.aboutBtn.frame.size.height + SCREEN_MARGIN);
        _locationBtn.frame = CGRectMake(_locationBtn.frame.origin.x, _locationBtn.frame.origin.y, _locationBtn.frame.size.width, _locationBtn.frame.size.height);
        [_locationBtn setTitle:@"Our Location" forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(goToLocationPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationBtn;
}

#pragma mark - methods

-(void)goToLocationPage{
     LocationViewController *locationPage = [[LocationViewController alloc] init];
    [self presentViewController:locationPage animated:YES completion:nil];
}

-(void)showHelpMenu{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Help!"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Todo list items", @"Notifications", @"Profile", nil];
    actionSheet.tag = 100;
    [actionSheet showInView:self.view];
}

-(void)showAboutWindow:(id)sender{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"About this app"
//                                                             delegate:self
//                                                    cancelButtonTitle:@"Cancel"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"Todo list items", @"Notifications", @"Profile", nil];
//    actionSheet.tag = 200;
//    [actionSheet showInView:self.view];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        FeedbackViewController *feedbackPage = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
        feedbackPage.delegate = self;
        self.aboutPopover = [[UIPopoverController alloc] initWithContentViewController:feedbackPage];
        self.aboutPopover.popoverContentSize = CGSizeMake(320.0, 400.0);
        [self.aboutPopover presentPopoverFromRect:[(UIButton *)sender frame]
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
    } else {
        NSLog(@"No popovers for iphone!!!");
    }
    
    
}

-(void)setUpTabBar{
    UIImage *addIcon = [UIImage imageNamed:@"add-icon"];
    self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Add" image:nil selectedImage:nil];
    [self.navigationController.tabBarItem setImage: [addIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

-(void)hideTabBar{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if([userDefaults objectForKey:@"userID"] == nil){
        [self.tabBarController.tabBar setHidden:YES];
        self.tabBarController.hidesBottomBarWhenPushed = YES;
    } else {
        self.tabBarController.hidesBottomBarWhenPushed = NO;
        [self.tabBarController.tabBar setHidden:NO];
    }
    
}

#pragma mark - delegate methods

-(void)bannerView:(ADBannerView *)banner
didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Error loading");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad loaded");
}
-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad will load");
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad did finish");
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 100) {
        NSLog(@"The Normal action sheet.");
    }
    else if (actionSheet.tag == 200){
        NSLog(@"The Delete confirmation action sheet.");
    }
    else{
        NSLog(@"The Color selection action sheet.");
    }
    
    NSLog(@"Index = %ld - Title = %@", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    if (user) {
        NSLog(@"%@", user);
        self.welcomeMessage.text = [NSString stringWithFormat:@"Hi, %@ %@", user.first_name, user.last_name];
        
        //set up defaults
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:user.objectID forKey:@"userID"];
        [userDefaults setValue:user.first_name forKey:@"firstName"];
        [userDefaults setValue:user.last_name forKey:@"lastName"];
        [userDefaults setBool:YES forKey:@"loggedIn"];
        [userDefaults synchronize];
        
        [self hideTabBar];
    }
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"%@", loginView);
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.welcomeMessage.text= @"Welcome, Guest!";
    
    //clear NSUserDefaults
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [self hideTabBar];
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
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
