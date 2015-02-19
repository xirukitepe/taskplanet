//
//  DetailViewController.m
//  TodoList
//
//  Created by Shiela S on 2/11/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "DetailViewController.h"
#import "Constants.h"
#import <Social/Social.h>

@interface DetailViewController ()
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *desc;
@property (strong, nonatomic) UILabel *dueDate;
@property (strong, nonatomic) UIButton *fbShareBtn;
@property (strong, nonatomic) UIButton *twitterShareBtn;
@end

@implementation DetailViewController
-(void)viewDidLoad{
    
    [self.view addSubview:self.name];
    [self.view addSubview:self.desc];
    [self.view addSubview:self.dueDate];
    [self.view addSubview:self.fbShareBtn];
    [self.view addSubview:self.twitterShareBtn];
    [self setUpNavigationBar];
    [self backgroundImage];
}

#pragma mark - properties

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _name.center = CGPointMake(SCREEN_CENTER_X, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height + ELEM_MARGIN);
        _name.frame = CGRectMake(_name.frame.origin.x, _name.frame.origin.y, _name.frame.size.width, _name.frame.size.height);
        _name.text = [self.task valueForKey:@"name"];
        
    }
    return _name;
}

-(UILabel *)desc{
    if (!_desc) {
        _desc = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _desc.center = CGPointMake(SCREEN_CENTER_X, self.name.frame.origin.y + self.name.frame.size.height + DETAIL_MARGIN);
        _desc.frame = CGRectMake(_desc.frame.origin.x, _desc.frame.origin.y, _desc.frame.size.width, _name.frame.size.height);
        _desc.text = [self.task valueForKey:@"desc"];
        
    }
    return _desc;
}

-(UILabel *)dueDate{
    if (!_dueDate) {
        _dueDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, 30)];
        _dueDate.center = CGPointMake(SCREEN_CENTER_X, self.desc.frame.origin.y + self.desc.frame.size.height + DETAIL_MARGIN);
        _dueDate.frame = CGRectMake(_dueDate.frame.origin.x, _dueDate.frame.origin.y, _dueDate.frame.size.width, _name.frame.size.height);
        
        NSDate *date = [self.task valueForKey:@"due_date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString *dateString = [formatter stringFromDate:date];
        
        _dueDate.text = dateString;
        
    }
    return _dueDate;
}

-(UIButton *)fbShareBtn{
    if (!_fbShareBtn) {
        _fbShareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, BUTTON_HEIGHT)];
        _fbShareBtn.center = CGPointMake(SCREEN_CENTER_X, self.dueDate.frame.origin.y + self.dueDate.frame.size.height + (ELEM_MARGIN * 2));
        _fbShareBtn.frame = CGRectMake(_fbShareBtn.frame.origin.x, _fbShareBtn.frame.origin.y, _fbShareBtn.frame.size.width, _fbShareBtn.frame.size.height);
        [_fbShareBtn setTitle:@"Share via Facebook" forState:UIControlStateNormal];
        _fbShareBtn.layer.borderWidth = 2.0f;
        _fbShareBtn.layer.borderColor = BUTTON_BG_GREEN.CGColor;
        _fbShareBtn.backgroundColor = BUTTON_BG_GREEN;
        [_fbShareBtn addTarget:self action:@selector(shareViaFb) forControlEvents:UIControlEventTouchUpInside];
        _fbShareBtn.layer.cornerRadius = 3.0f;
        _fbShareBtn.layer.masksToBounds = NO;
        _fbShareBtn.layer.shadowColor = BUTTON_BG_GREEN.CGColor;
        _fbShareBtn.layer.shadowOpacity = 0.8;
        _fbShareBtn.layer.shadowRadius = 20;
        _fbShareBtn.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    }
    return _fbShareBtn;
}

-(UIButton *)twitterShareBtn{
    if (!_twitterShareBtn) {
        _twitterShareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, FULL_WIDTH, BUTTON_HEIGHT)];
        _twitterShareBtn.center = CGPointMake(SCREEN_CENTER_X, self.fbShareBtn.frame.origin.y + self.fbShareBtn.frame.size.height + (ELEM_MARGIN));
        _twitterShareBtn.frame = CGRectMake(_twitterShareBtn.frame.origin.x, _twitterShareBtn.frame.origin.y, _twitterShareBtn.frame.size.width, _twitterShareBtn.frame.size.height);
        [_twitterShareBtn setTitle:@"Share via Twitter" forState:UIControlStateNormal];
        _twitterShareBtn.layer.borderWidth = 2.0f;
        _twitterShareBtn.layer.borderColor = BUTTON_BG_GREEN.CGColor;
        _twitterShareBtn.backgroundColor = BUTTON_BG_GREEN;
        [_twitterShareBtn addTarget:self action:@selector(shareViaTwitter) forControlEvents:UIControlEventTouchUpInside];
        _twitterShareBtn.layer.cornerRadius = 3.0f;
        _twitterShareBtn.layer.masksToBounds = NO;
        _twitterShareBtn.layer.shadowColor = BUTTON_BG_GREEN.CGColor;
        _twitterShareBtn.layer.shadowOpacity = 0.8;
        _twitterShareBtn.layer.shadowRadius = 20;
        _twitterShareBtn.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    }
    return _twitterShareBtn;
}

#pragma mark - methods
-(void)backgroundImage{
    UIImage *image = [UIImage imageNamed:@"paper"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

-(void)setUpNavigationBar{
    [self.navigationItem setTitle:[self.task valueForKey:@"name"]];
}

-(void)shareViaFb{
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    params.name = @"Task Planet";
    params.caption = self.name.text;
    params.picture = [NSURL URLWithString:@"http://i.imgur.com/g3Qc1HN.png"];
    params.linkDescription = self.desc.text;
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        // Present the share dialog
        [self fbShareDialog:(NSURL *)params.link fbName:(NSString *)params.name fbCaption:(NSString *)params.caption fbPic:(NSURL *)params.picture fbLinkDesc:(NSString *)params.linkDescription];
    } else {
        // Present the feed dialog
        [self fbFeedDialog:(NSURL *)params.link fbName:(NSString *)params.name fbCaption:(NSString *)params.caption fbPic:(NSURL *)params.picture fbLinkDesc:(NSString *)params.linkDescription];
    }
}

-(void)fbFeedDialog:(NSURL *)link fbName:(NSString *)name fbCaption:(NSString *)caption fbPic:(NSURL *)picture fbLinkDesc:(NSString *)linkDescription{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Task Planet", @"name",
                                   caption, @"caption",
                                   linkDescription, @"description",
                                   @"https://developers.facebook.com/docs/ios/share/", @"link",
                                   @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                   nil];
    
    // Show the feed dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
       parameters:params
          handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
              if (error) {
                  // An error occurred, we need to handle the error
                  // See: https://developers.facebook.com/docs/ios/errors
                  NSLog(@"Error publishing story: %@", error.description);
              } else {
                  if (result == FBWebDialogResultDialogNotCompleted) {
                      // User cancelled.
                      NSLog(@"User cancelled.");
                  } else {
                      // Handle the publish feed callback
                      NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                      
                      if (![urlParams valueForKey:@"post_id"]) {
                          // User cancelled.
                          NSLog(@"User cancelled.");
                          
                      } else {
                          // User clicked the Share button
                          NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                          NSLog(@"result %@", result);
                      }
                  }
              }
          }];
}

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

-(void)fbShareDialog:(NSURL *)link fbName:(NSString *)name fbCaption:(NSString *)caption fbPic:(NSURL *)picture fbLinkDesc:(NSString *)linkDescription{
    [FBDialogs presentShareDialogWithLink: link
             name: name
          caption: caption
      description: linkDescription
          picture: picture
      clientState:nil
          handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
              if(error) {
                  // An error occurred, we need to handle the error
                  // See: https://developers.facebook.com/docs/ios/errors
                  NSLog(@"%@", error.description);
              } else {
                  // Success
                  NSLog(@"result %@", results);
              }
          }];
    
}

-(void)shareViaTwitter{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"Just sharing my todo-list item: %@ (%@)", self.name.text, self.desc.text]];
        [tweetSheet addURL:[NSURL URLWithString:@"http://xiruki.tk"]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    } else {
        NSLog(@"Please install twitter");
    }
    
}

#pragma mark - delegate methods

@end
