//
//  US2EventMapViewController.m
//  GigFinder
//
//  Created by Tanya on 7/18/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2EventMapViewController.h"
#import "Pin.h"
#import "US2Event.h"
@import MapKit;


@interface US2EventMapViewController ()<UIAlertViewDelegate>
{
    MKMapView *mapView;
    Pin *pin;
}

@end

@implementation US2EventMapViewController

@synthesize latArray, longArray, placeName, Date;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#define MAP_PADDING 1.1
#define MINIMUM_VISIBLE_LATITUDE 0.01

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Latitude: %@", latArray);
    NSLog(@"Longtitude: %@", longArray);
    
    //addlat = 13.749641;
    //addlat = 57.4918165;
    //addlong = 100.540921;
    //addlong = 12.6430471;
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    mapView.mapType = MKMapTypeStandard;
    
    [mapView setDelegate:self];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    
    [self.view addSubview:mapView];
    
    MKCoordinateRegion region;
    
    US2Event *event = [[US2Event alloc] init];

    
    //for loop
    for (int i = 0; i < [latArray count]; i++)
    {
        CLLocationCoordinate2D coord = {.latitude = [[latArray objectAtIndex:i] floatValue], .longitude = [[longArray objectAtIndex:i] floatValue]};
        MKCoordinateSpan span = {.latitudeDelta = 50.0, .longitudeDelta = 50.0};
        MKCoordinateRegion regions = {coord, span};
        
        //MKCoordinateRegion regions = { {0.0, 0.0 }, {0.0, 0.0 } };
        regions.span.longitudeDelta = 100.0f;
        regions.span.latitudeDelta = 100.0f;
        //regions = MKCoordinateRegionMakeWithDistance(coord, 3000, 3000);
        [mapView setRegion:regions animated:YES];
        //[mapView setRegion:region];
        
        pin = [[Pin alloc] init];
        NSString *addressName = [Date objectAtIndex:i];
        pin.title = [placeName objectAtIndex:i];
        pin.subtitle = addressName;
        pin.coordinate = regions.center;
        [mapView addAnnotation:pin];
    }
    
    
    
    //[mapView addAnnotation:pin];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f", view.annotation.coo, addlong]]];
//    

    id <MKAnnotation> annotation = view.annotation;
    CLLocationCoordinate2D coordinate = annotation.coordinate;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f", coordinate.latitude, coordinate.longitude]]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
