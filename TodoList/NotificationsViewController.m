//
//  NotificationsViewController.m
//  TodoList
//
//  Created by Shiela S on 2/13/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "NotificationsViewController.h"
#import "Constants.h"
#import "CustomTableViewCell.h"

@interface NotificationsViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *cancelAllNotifs;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSMutableArray *localNotifications;
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
    self.localNotifications = [self setLocalNotifications];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellNotifications"];
    [self setUpSearch];
}

- (void)viewDidAppear:(BOOL)animated{
    self.localNotifications = [self setLocalNotifications];
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
        _tableView.backgroundColor = [UIColor cyanColor];
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

-(NSMutableArray *)setLocalNotifications{
    NSMutableArray *localNotifications = [[[UIApplication sharedApplication] scheduledLocalNotifications] mutableCopy];
    return localNotifications;
}

-(void)setUpSearch{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController: nil];
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.frame = CGRectMake(0, 0, 320, 44);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.definesPresentationContext = YES;
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
}

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
    // cancel begins here
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [self.localNotifications removeAllObjects];
    [self.tableView reloadData];
}

-(BOOL)registerNotifs:(UIApplication *)application{
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
//    else {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
//        return YES;
//    }
    return YES;
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
    return self.localNotifications.count;
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellNotifications";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Using Custom Cell
//    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        // Display notification info
        if ([self.localNotifications count] != 0) {
            UILocalNotification *localNotification = [self.localNotifications objectAtIndex:indexPath.row];
//            cell.mainLabel.text = localNotification.alertBody;
//            cell.descriptionLabel.text = [localNotification.fireDate description];
            
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
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        if ([self.localNotifications count] != 0) {
            UILocalNotification *localNotification = [self.localNotifications objectAtIndex:indexPath.row];
            // cancel notification
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        }
        
        // Remove the row from data model
        [self.localNotifications removeObjectAtIndex:indexPath.row];
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
    } else {
        [self.tableView setEditing:NO animated:YES];
    }
    
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchText = [self.searchController.searchBar text];
    NSLog(@"%@", searchText);

    if([searchText length] > 1){
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"SELF.alertBody contains[cd] %@",
                                        searchText];
        self.localNotifications = [[self.localNotifications filteredArrayUsingPredicate:resultPredicate] mutableCopy];
    } else {
        self.localNotifications = [self setLocalNotifications];
    }
    [self.tableView reloadData];
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"test");
    return YES;
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
