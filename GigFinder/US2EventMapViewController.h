//
//  US2EventMapViewController.h
//  GigFinder
//
//  Created by Tanya on 7/18/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

@interface US2EventMapViewController : UIViewController<MKAnnotation, MKMapViewDelegate>

@property (nonatomic, retain) NSMutableArray *latArray;
@property (nonatomic, retain) NSMutableArray *longArray;



@end
