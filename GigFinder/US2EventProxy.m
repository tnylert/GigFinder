//
//  US2EventProxy.m
//  GigFinder
//
//  Created by Tanya on 7/16/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2EventProxy.h"
#import "US2Event.h"
#import "US2Artist.h"

@implementation US2EventProxy

- (void)retrieveEventsOfArtist:(NSString *)artist
{
    // NSURLSession
    NSString *lastfmAPIKey = @"a2a238ddf3f5ac1370141bd0e3e3e646";
    NSString *eventURL = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=artist.getevents&artist=%@&api_key=%@&format=json", artist, lastfmAPIKey];
    __block NSDictionary *jsonResponse;

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
                
                NSDictionary *attr = [event objectForKey:@"@attr"];
                

                
                NSDictionary *artistVenue;
                NSDictionary *allArtistEvent;
                NSMutableArray *allArtistEventInfo = [[NSMutableArray alloc] init];
                
                US2Event *events = [[US2Event alloc] init];
                events.placeDate = [[NSMutableArray alloc] init];
                events.placeName = [[NSMutableArray alloc] init];
                
                US2Artist *artist = [[US2Artist alloc] init];
                
                
                for (NSInteger i = 0; i < [artistEvent count]; i++)
                {
                    artistVenue = [artistEvent objectAtIndex:i];
                    //NSLog(@"artistVenue: %@", artistVenue);
                    
                    NSDictionary *artistEventImage = [artistVenue objectForKey:@"venue"];
                    NSArray *artistEventImageGet = [artistEventImage objectForKey:@"image"];
                    //NSLog(@"artistImageGet: %@", artistImageGet);
                    
                    NSDictionary *artistEventLocation = [artistEventImage objectForKey:@"location"];
                    //NSLog(@"locationarrr: %@", artistEventLocation);
                    
                    NSArray *artistImageList = [artistVenue objectForKey:@"image"];
                    
                    
                    
                    allArtistEvent = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [artistVenue objectForKey:@"startDate"],
                                     @"artistEventStartDate",
                                     [artistVenue objectForKey:@"url"],
                                     @"artistEventURL",
                                      [[artistEventImageGet objectAtIndex:2] objectForKey:@"#text"],
                                      @"artisEventtImageSmall",
                                      [[artistEventImageGet objectAtIndex:4] objectForKey:@"#text"],
                                      @"artisEventtImageLarge",
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
                                      [artistEventImage objectForKey:@"name"],
                                      @"artistEventLocationName",
                                      [artistEventImage objectForKey:@"url"],
                                      @"artistEventLocationURL",
                                      [[artistImageList objectAtIndex:2] objectForKey:@"#text"],
                                      @"artistImage",
                                      [attr objectForKey:@"artist"],
                                      @"artistName",
                                      nil];
                    
                    [events.placeDate addObject:[artistVenue objectForKey:@"startDate"]];
                    [events.placeName addObject:[artistEventImage objectForKey:@"name"]];
                    artist.artistName = [attr objectForKey:@"artist"];
                    
                    [allArtistEventInfo addObject:allArtistEvent];
                    
                }
                
                NSLog(@"nameeee: %@", events.placeName);
                NSLog(@"dateeee: %@", events.placeDate);
                NSLog(@"artistnamess: %@", artist.artistName);
                

                NSLog(@"isMain :%@", [NSThread isMainThread] ? @"YES" : @"NO");

                dispatch_async(dispatch_get_main_queue(), ^{

                    if ([self.delegate respondsToSelector:@selector(eventProxy:retrievedArtists:)])
                    {
                        [self.delegate eventProxy:self retrievedArtists:allArtistEventInfo];
                    }
                });
                
            }] resume];
    
}


@end
