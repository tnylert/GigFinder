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
    NSString *lastfmAPIKey = @"a2a238ddf3f5ac1370141bd0e3e3e646";
    NSString *eventURL = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=event.getinfo&event=328799&api_key=%@&format=json", lastfmAPIKey];
    __block NSString *jsonResponse;
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:eventURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@", jsonResponse);
            }] resume];
    
    // Parse the string into JSON
    //NSDictionary *json = [jsonResponse JSONValue];
    
    // Get the objects you want, e.g. output the second item's client id
    //NSArray *items = [json valueForKeyPath:@"data.array"];
    //NSLog(@" client Id : %@", [[items objectAtIndex:1] objectForKey:@"clientId"]);
    
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
