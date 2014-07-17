//
//  US2EventProxy.m
//  GigFinder
//
//  Created by Tanya on 7/16/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2EventProxy.h"


@implementation US2EventProxy

- (void)retrieveEventsOfArtist:(NSString *)artist
{
    // NSURLSession
    NSString *lastfmAPIKey = @"a2a238ddf3f5ac1370141bd0e3e3e646";
    NSString *eventURL = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=artist.getevents&artist=%@&api_key=%@&format=json", artist, lastfmAPIKey];
    //NSString *eventURL = [NSString stringWithFormat:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"];
    __block NSDictionary *jsonResponse;
    __block NSDictionary *allArtistInfo;
    NSURLSession *session = [NSURLSession sharedSession];

    [[session dataTaskWithURL:[NSURL URLWithString:eventURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                //NSLog(@"RESPONSE: %@", jsonResponse);

                
                NSDictionary* jsonArtistResponse = [NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:kNilOptions
                                      error:&error];
                
                NSDictionary *event = [jsonArtistResponse objectForKey:@"events"];
                //NSLog(@"eventt: %@", event);
                
                NSArray *artistEvent = [event objectForKey:@"event"];
                //NSLog(@"artistEvent: %@", artistEvent);
                
                NSDictionary *artistVenue;
                NSDictionary *allArtistEvent;
                NSMutableArray *allArtistEventInfo = [[NSMutableArray alloc] init];
                
                /*NSArray *artistImage = [[artistEvent objectAtIndex:0] objectForKey:@"image"];
                NSDictionary *artistImageSize = [artistImage objectAtIndex:2];
                NSLog(@"artistImageSize: %@", artistImageSize);*/
                
                for (NSInteger i = 0; i < [artistEvent count]; i++)
                {
                    artistVenue = [artistEvent objectAtIndex:i];
                    //NSLog(@"artistVenue: %@", artistVenue);
                    
                    NSDictionary *artistImage = [artistVenue objectForKey:@"venue"];
                    NSArray *artistImageGet = [artistImage objectForKey:@"image"];
                    //NSLog(@"artistImageGet: %@", artistImageGet);
                    
                    NSDictionary *artistEventLocation = [artistImage objectForKey:@"location"];
                    //NSLog(@"locationarrr: %@", artistEventLocation);
                    
                    allArtistEvent = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [artistVenue objectForKey:@"startDate"],
                                     @"artistEventStartDate",
                                     [artistVenue objectForKey:@"url"],
                                     @"artistEventURL",
                                      [[artistImageGet objectAtIndex:2] objectForKey:@"#text"],
                                      @"artistImage",
                                      [artistEventLocation objectForKey:@"city"],
                                      @"artistEventCity",
                                      [artistEventLocation objectForKey:@"country"],
                                      @"artistEventCountry",
                                     [(NSDictionary*)[artistEventLocation objectForKey:@"geo:point"]
                                      objectForKey:@"geo:lat"],
                                      @"artistVenueLatitude",
                                      [(NSDictionary*)[artistEventLocation objectForKey:@"geo:point"]
                                       objectForKey:@"geo:long"],
                                      @"artistVenueLongtitude",
                                      [artistImage objectForKey:@"name"],
                                      @"artistEventLocationName",
                                      [artistImage objectForKey:@"url"],
                                      @"artistEventLocationURL",
                                      nil];
                    [allArtistEventInfo addObject:allArtistEvent];
                    
                }
                
                /*NSLog(@"artistVenue: %@", artistVenue);
                NSLog(@"artistStartDate: %@", allArtistEvent);*/
                //NSLog(@"allArtistEventArray: %@", allArtistEventInfo);
                
                NSDictionary *artistVenueLocation = [artistVenue objectForKey:@"location"];
                
                //NSDictionary *singerEventlocation = [(NSDictionary*)[event objectForKey:@"venue"] objectForKey:@"location"];

                /*allArtistInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [artistEvent objectForKey:@"#text"],
                                 @"artistImage",
                                 [artistEvent objectForKey:@"title"],
                                 @"artistName",
                                 [artistEvent objectForKey:@"startDate"],
                                 @"artisteventStartDate",
                                 [artistEvent objectForKey:@"title"],
                                 @"artistName",*/
                                                /*[(NSDictionary*)[artistVenueLocation objectForKey:@"geo:point"]
                                                objectForKey:@"geo:lat"],
                                                @"artistVenueLatitude",*/
                                 //[artistEvent objectForKey:@"url"],
                                 //@"artistEventURL",
                                 
                                 
                                              // nil];
                
                //NSLog(@"allArtistInfo: %@", allArtistInfo);
                
                if (YES)
                {
                    if ([self.delegate respondsToSelector:@selector(eventProxy:retrievedArtists:)])
                    {
                        //NSArray *artists = @[];
                        [self.delegate eventProxy:self retrievedArtists:allArtistEventInfo];
                    }
                }
                
            }] resume];
    
    
    
    // If completed without error parse to US2Event
    
    
}


@end
