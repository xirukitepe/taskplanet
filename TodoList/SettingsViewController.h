//
//  SettingsViewController.h
//  TaskPlanet
//
//  Created by Shiela S on 2/15/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) NSMutableArray *userInfo;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
