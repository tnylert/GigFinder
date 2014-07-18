//
//  US2EventMapViewController.m
//  GigFinder
//
//  Created by Tanya on 7/18/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2EventMapViewController.h"
#import "US2EventMapProxy.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "Pin.h"
#import "US2Event.h"

@interface US2EventMapViewController ()<US2EventProxyDelegate>
{
    MKMapView *mapView;
    Pin *pin;
}

@end

@implementation US2EventMapViewController

@synthesize latArray, longArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)eventProxy:(US2EventMapProxy *)eventProxy retrievedLatitude:(CGFloat *)latitude retrievedLongtitude:(CGFloat *) longtitude
{
    
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
    [mapView setScrollEnabled:NO];
    
    [self.view addSubview:mapView];
    
    MKCoordinateRegion region;
    
    US2Event *event = [[US2Event alloc] init];
    
    
    NSLog(@"name: %@", event.placeName);
    NSLog(@"date: %@", event.placeDate);
    
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
        NSString *addressName = [event.placeDate objectAtIndex:i];
        pin.title = [event.placeName objectAtIndex:i];
        pin.subtitle = addressName;
        pin.coordinate = regions.center;
        [mapView addAnnotation:pin];
    }
    
    
    
    //[mapView addAnnotation:pin];
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
