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
#import "Constants.h"

@interface HomeViewController ()
@property (strong, nonatomic) UILabel *welcomeMessage;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) UILabel *taskPlanet;
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
    [self.view addSubview:self.taskPlanet];
    [self.view addSubview:self.welcomeMessage];
    [self facebookLogin];
}

-(void)viewDidAppear:(BOOL)animated{
    [self hideTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - properties

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


-(void)facebookLogin{
    FBLoginView *loginView = [[FBLoginView alloc] initWithFrame:CGRectMake(0, 0, 100, BUTTON_HEIGHT)];
    loginView.center = CGPointMake(SCREEN_CENTER_X, self.welcomeMessage.frame.origin.y + self.welcomeMessage.frame.size.height + (ELEM_MARGIN  * 2));
    loginView.frame = CGRectMake(loginView.frame.origin.x, loginView.frame.origin.y, loginView.frame.size.width, loginView.frame.size.height);
    loginView.delegate = self;
    loginView.readPermissions = @[@"public_profile", @"email"];
    [self.view addSubview:loginView];
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
