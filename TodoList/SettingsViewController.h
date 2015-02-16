//
//  SettingsViewController.h
//  TaskPlanet
//
//  Created by Shiela S on 2/15/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SettingsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *userInfo;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UITableView *tableView;
@end
