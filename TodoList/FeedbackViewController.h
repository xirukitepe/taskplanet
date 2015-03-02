//
//  FeedbackViewController.h
//  TaskPlanet
//
//  Created by Shiela S on 2/16/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedbackViewControllerDelegate;

@protocol FeedbackViewControllerDelegate <NSObject>
@end

@interface FeedbackViewController : UIViewController
{
    id<FeedbackViewControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
@end
