//
//  US2EventProxy.h
//  GigFinder
//
//  Created by Tanya on 7/16/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol US2EventProxyDelegate;


@interface US2EventProxy : NSObject

@property (nonatomic, weak) id<US2EventProxyDelegate> delegate;

- (void)retrieveEventsOfArtist:(NSString *)artist;

@end


@protocol US2EventProxyDelegate <NSObject>

@optional
- (void)eventProxy:(US2EventProxy *)eventProxy retrievedArtists:(NSArray *)artists;

@end