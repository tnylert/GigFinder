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
    //NSString *eventURL = [NSString stringWithFormat:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"];
    __block NSDictionary *jsonResponse;
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:eventURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@"RESPONSE: %@", jsonResponse);

                
                NSDictionary* json = [NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:kNilOptions
                                      error:&error];
                
                NSDictionary *event = [json objectForKey:@"event"];
                NSLog(@"eventt: %@", event);
                
                NSDictionary *artists = [event objectForKey:@"artists"];
                NSLog(@"artists: %@", artists);
                
                NSDictionary *singerEventlocation = [(NSDictionary*)[event objectForKey:@"venue"] objectForKey:@"location"];

                NSDictionary *allSingerInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [artists objectForKey:@"headliner"],
                                               @"singerName",
                                               [event objectForKey:@"id"],
                                               @"singerID",
                                               [event objectForKey:@"startDate"],
                                               @"singerEventStartDate",
                                               [event objectForKey:@"url"],
                                               @"SingerEventURL",
                                               [singerEventlocation objectForKey:@"city"],
                                               @"city",
                                               [singerEventlocation objectForKey:@"country"],
                                               @"country",
                                               [(NSDictionary*)[singerEventlocation objectForKey:@"geo:point"] objectForKey:@"geo:lat"],
                                               @"latitude",
                                               [(NSDictionary*)[singerEventlocation objectForKey:@"geo:point"] objectForKey:@"geo:long"],
                                               @"longtitude",
                                               [(NSDictionary*)[event objectForKey:@"venue"] objectForKey:@"name"],
                                               @"eventLocationName",
                                               [(NSDictionary*)[event objectForKey:@"venue"] objectForKey:@"phonenumber"],
                                               @"eventPhoneNumber",
                                               nil];
                
                NSLog(@"allSingerInfo: %@", allSingerInfo);
                
                
            }] resume];
    
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
