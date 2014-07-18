//
//  US2EventMapProxy.h
//  GigFinder
//
//  Created by Tanya on 7/18/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol US2EventMapProxyDelegate;


@interface US2EventMapProxy : NSObject

@property (nonatomic, weak) id<US2EventMapProxyDelegate> delegate;

- (void)retrievedLocation:(CGFloat *)latitude retrievedLongtitude:(CGFloat *)longtitude;

@end


@protocol US2EventProxyDelegate <NSObject>

@optional
- (void)eventProxy:(US2EventMapProxy *)eventProxy retrievedLatitude:(CGFloat *)latitude retrievedLongtitude:(CGFloat *) longtitude;

@end