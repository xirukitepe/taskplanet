//
//  MapAnnotation.h
//  TaskPlanet
//
//  Created by Shiela S on 3/2/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)title andCoordinate:
(CLLocationCoordinate2D)coordinate2d;

@end
