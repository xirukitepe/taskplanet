//
//  LocationViewController.h
//  TaskPlanet
//
//  Created by Shiela S on 3/2/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@end
