//
//  HomeViewController.h
//  TaskPlanet
//
//  Created by Shiela S on 2/17/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <iAd/iAd.h>
#import "FeedbackViewController.h"

@interface HomeViewController : UIViewController <FBLoginViewDelegate, UIActionSheetDelegate, FeedbackViewControllerDelegate>
@property(strong, nonatomic) ADBannerView *bannerView;
@end
