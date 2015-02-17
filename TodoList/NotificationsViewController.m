//
//  NotificationsViewController.m
//  TodoList
//
//  Created by Shiela S on 2/13/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "NotificationsViewController.h"
#import "Constants.h"

@interface NotificationsViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *cancelAllNotifs;
@end

@implementation NotificationsViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    // tab configs
    UIImage *notifIcon = [UIImage imageNamed:@"clock"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Notifications" image:nil selectedImage:nil];
    [self.tabBarItem setImage: [notifIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor: [UIColor whiteColor]];
    [self setUpNavigationBar];
    [self.view addSubview:self.cancelAllNotifs];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellNotifications"];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - properties

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.cancelAllNotifs.frame.origin.y + self.cancelAllNotifs.frame.size.height + SCREEN_MARGIN, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(UIButton *)cancelAllNotifs{
    if (!_cancelAllNotifs) {
        _cancelAllNotifs = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_MARGIN, ELEM_MARGIN, 100, BUTTON_HEIGHT)];
        [_cancelAllNotifs setTitle:@"Cancel All" forState:UIControlStateNormal];
        _cancelAllNotifs.layer.borderWidth = 2.0f;
        _cancelAllNotifs.layer.borderColor = BUTTON_BG_GREEN.CGColor;
        _cancelAllNotifs.backgroundColor = BUTTON_BG_GREEN;
        [_cancelAllNotifs addTarget:self action:@selector(cancelAllNotifications) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelAllNotifs;
}
#pragma mark - methods

-(void)setUpNavigationBar{
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem setTitle:@"All Notifications"];
}

-(void)setUpIconBadge:(UIApplication *)application{
    application.applicationIconBadgeNumber = 0;
}

-(void)launchOptions:(NSDictionary *)launchOptions resetBadge:(UIApplication *)application{
    // Handle launching from a notification
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNotification) {
        // Set icon badge number to zero
        [self setUpIconBadge:application];
    }
}

- (void)cancelAllNotifications{
    NSMutableArray *localNotifications = [[[UIApplication sharedApplication] scheduledLocalNotifications] mutableCopy];
    // cancel begins here
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [localNotifications removeAllObjects];
    [self.tableView reloadData];
}

-(BOOL)registerNotifs:(UIApplication *)application{
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        return YES;
    }else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
        return YES;
    }
}

-(void)showNotifs:(UILocalNotification *)notification{
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

// This will tell your UITableView how many rows you wish to have in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    return [localNotifications count];
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellNotifications";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Get list of local notifications
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];

    if (indexPath.section == 0) {
        // Display notification info
        if ([localNotifications count] != 0) {
            UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
            [cell.textLabel setText:localNotification.alertBody];
            [cell.detailTextLabel setText:[localNotification.fireDate description]];
        }
    }
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Get list of local notifications
    NSMutableArray *localNotifications = [[[UIApplication sharedApplication] scheduledLocalNotifications] mutableCopy];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        if ([localNotifications count] != 0) {
            UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
            // cancel notification
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
        
        // Remove the row from data model
        [localNotifications removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    // Request table view to reload
    [self.tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if(editing == YES)
    {
        [self.tableView setEditing:YES animated:YES];
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
