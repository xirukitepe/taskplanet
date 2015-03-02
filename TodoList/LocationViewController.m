//
//  LocationViewController.m
//  TaskPlanet
//
//  Created by Shiela S on 3/2/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

#import "LocationViewController.h"
#import "MapAnnotation.h"
#import "Constants.h"

@interface LocationViewController ()
@property(strong, nonatomic) UIButton *goBackBtn;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.goBackBtn];
    [self setUpMaps];
    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark - properties
-(UIButton *)goBackBtn{
    if (!_goBackBtn) {
        _goBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_MARGIN, ELEM_MARGIN, 50, 30)];
        [_goBackBtn setTitle:@"Back" forState:UIControlStateNormal];
        [_goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _goBackBtn;
}

#pragma mark - methods

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setUpMaps{
    // Do any additional setup after loading the view.
    
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:
                          CGRectMake(0, self.goBackBtn.frame.origin.y + self.goBackBtn.frame.size.height + SCREEN_MARGIN, SCREEN_WIDTH, SCREEN_HEIGHT - (ELEM_MARGIN * 2))];
    mapView.delegate = self;
    mapView.centerCoordinate = CLLocationCoordinate2DMake(37.32, -122.03);
    mapView.mapType = MKMapTypeHybrid;
    CLLocationCoordinate2D location;
    location.latitude = (double) 37.332768;
    location.longitude = (double) -122.030039;
    // Add the annotation to our map view
    MapAnnotation *newAnnotation = [[MapAnnotation alloc]
                                    initWithTitle:@"Task Planet Office" andCoordinate:location];
    [mapView addAnnotation:newAnnotation];
    CLLocationCoordinate2D location2;
    location2.latitude = (double) 37.35239;
    location2.longitude = (double) -122.025919;
    MapAnnotation *newAnnotation2 = [[MapAnnotation alloc]
                                     initWithTitle:@"Test annotation" andCoordinate:location2];
    [mapView addAnnotation:newAnnotation2];
    [self.view addSubview:mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id <MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
    ([mp coordinate], 1500, 1500);
    [mapView setRegion:region animated:YES];
    [mapView selectAnnotation:mp animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
