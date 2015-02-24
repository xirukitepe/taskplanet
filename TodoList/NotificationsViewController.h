//
//  NotificationsViewController.h
//  TodoList
//
//  Created by Shiela S on 2/13/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>
-(void)setUpIconBadge:(UIApplication * )application;
-(BOOL)registerNotifs:(UIApplication * )application;
-(void)showNotifs:(UILocalNotification *)notification;
-(void)launchOptions:(NSDictionary *)launchOptions resetBadge:(UIApplication *)application;
@end
