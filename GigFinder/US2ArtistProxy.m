//
//  US2ArtistProxy.m
//  GigFinder
//
//  Created by Tanya on 7/21/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2ArtistProxy.h"

@implementation US2ArtistProxy

- (void)retrieveArtistInfo:(NSString *)name
{
    NSString *lastfmAPIKey = @"a2a238ddf3f5ac1370141bd0e3e3e646";
    NSString *eventURL = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=%@&api_key=%@&format=json", name, lastfmAPIKey];
    __block NSDictionary *jsonResponse;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:eventURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@"artist RESPONSE: %@", jsonResponse);
                
                
                NSDictionary* jsonArtistResponse = [NSJSONSerialization
                                                    JSONObjectWithData:data
                                                    options:kNilOptions
                                                    error:&error];
                
                NSDictionary *artist = [jsonArtistResponse objectForKey:@"artist"];
                
                NSDictionary *artistBio = [artist objectForKey:@"bio"];
                
                /*Y*/NSDictionary *artistContent = [artistBio objectForKey:@"content"];
                NSArray *artistImage = [artist objectForKey:@"image"];
                NSDictionary *artistImageDic = [artistImage objectAtIndex:4];
                /*Y*/NSString *artistLargeImage = [artistImageDic objectForKey:@"#text"];
                
                
                NSDictionary *allArtistInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                                artistContent,
                                                @"artistContent",
                                                artistLargeImage,
                                                @"artistImage",
                                                nil];
               
                NSLog(@"isMain :%@", [NSThread isMainThread] ? @"YES" : @"NO");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if ([self.delegate respondsToSelector:@selector(artistProxy:retrievedInfo:)])
                    {
                        [self.delegate artistProxy:self retrievedInfo:allArtistInfo];
                    }
                });
                
            }] resume];

}

@end
