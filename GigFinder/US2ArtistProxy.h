//
//  US2ArtistProxy.h
//  GigFinder
//
//  Created by Tanya on 7/21/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import <Foundation/Foundation.h>

 @protocol US2ArtistProxyDelegate;
 
 
 @interface US2ArtistProxy : NSObject
 
 @property (nonatomic, weak) id<US2ArtistProxyDelegate> delegate;
 
- (void)retrieveArtistInfo:(NSString *)name;
 
 @end
 
 
 @protocol US2ArtistProxyDelegate <NSObject>
 
 @optional
 - (void)artistProxy:(US2ArtistProxy *)artistProxy retrievedInfo:(NSDictionary *)name;
 
 @end
