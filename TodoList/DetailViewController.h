//
//  DetailViewController.h
//  TodoList
//
//  Created by Shiela S on 2/11/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface DetailViewController : UIViewController <FBWebDialogsDelegate>
@property (strong,nonatomic) NSArray *task;
@end
