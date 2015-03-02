//
//  MapAnnotation.m
//  TaskPlanet
//
//  Created by Shiela S on 3/2/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

-(id)initWithTitle:(NSString *)title andCoordinate:
(CLLocationCoordinate2D)coordinate2d{
    self.title = title;
    self.coordinate =coordinate2d;
    return self;
}

@end
