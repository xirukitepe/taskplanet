//
//  NotificationsViewController.m
//  TodoList
//
//  Created by Shiela S on 2/13/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "NotificationsViewController.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - methods
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
