//
//  US2EventProxy.m
//  GigFinder
//
//  Created by Tanya on 7/16/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2EventProxy.h"

@implementation US2EventProxy

- (void)retrieveAllArtists
{
    // NSURLSession
    
    // If completed without error parse to US2Event
    
    if (YES)
    {
        if ([self.delegate respondsToSelector:@selector(eventProxy:retrievedArtists:)])
        {
            NSArray *artists = @[];
            [self.delegate eventProxy:self retrievedArtists:artists];
        }
    }
}

@end
