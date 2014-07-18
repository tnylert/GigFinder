//
//  US2Event.h
//  GigFinder
//
//  Created by Tanya on 7/16/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


@interface US2Event : NSObject

@property (nonatomic, strong, readwrite) NSMutableArray *placeName;
@property (nonatomic, strong, readwrite) NSMutableArray *placeDate;

@end
