//
//  US2EventDetailViewController.m
//  GigFinder
//
//  Created by Tanya on 7/18/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import "US2EventDetailViewController.h"
#import "US2EventMapViewController.h"
#import "US2ArtistDetailViewController.h"

@interface US2EventDetailViewController ()
{
    NSMutableArray *latiArray;
    NSMutableArray *longtiArray;
    NSMutableArray *placeName;
    NSMutableArray *placeDate;
}

@end

@implementation US2EventDetailViewController

@synthesize month, date, eventPlaceName, artistName, fullDate, city, country, eventImageURL, EventDateLabel, eventImage, EventMonthLabel, EventPlaceNameLabel, FullDateLabel, moreFromArtistBtn, scrollView, cityCountrrLabel, allArtistDic, eventURL, latitude, longitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightBarClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    self.title = [NSString stringWithFormat:@"%@", artistName];
    
    EventDateLabel.text = date;
    
    if (![eventImageURL isEqualToString:@""])
    {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:eventImageURL]];
        eventImage.image = [UIImage imageWithData:data];
        eventImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    else
    {
        eventImage.image = [UIImage imageNamed:@"noimage.png"];
        eventImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    EventMonthLabel.text = month;
    EventPlaceNameLabel.text = eventPlaceName;
    FullDateLabel.text = fullDate;
    [moreFromArtistBtn setTitle:[NSString stringWithFormat:@"More events from %@", artistName] forState:UIControlStateNormal];
    cityCountrrLabel.text = [NSString stringWithFormat:@"%@, %@", city, country];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewDidLayoutSubviews
{
    [scrollView setContentSize:CGSizeMake(320, 720)];
}

- (void) rightBarClicked
{
    NSString *textToShare = [NSString stringWithFormat:@"Com join us at %@ concert! Check out %@ for more info!", artistName, eventURL];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:eventImageURL]];
    UIImage *imageToShare = [UIImage imageWithData:data];
    NSArray *itemsToShare = @[textToShare, imageToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll]; //or whichever you don't need
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)MoreFromArtistClicked:(id)sender {
    
    US2EventMapViewController *map = [self.storyboard instantiateViewControllerWithIdentifier:@"map"];
    
    latiArray = [[NSMutableArray alloc] init];
    longtiArray = [[NSMutableArray alloc] init];
    placeName = [[NSMutableArray alloc] init];
    placeDate = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [allArtistDic count]; i++)
    {
        NSDictionary *innerDic = [allArtistDic objectAtIndex:i];
        NSString *latString = [innerDic objectForKey:@"artistVenueLatitude"];
        NSString *longString = [innerDic objectForKey:@"artistVenueLongtitude"];
        NSString *placeNameString = [innerDic objectForKey:@"artistEventLocationName"];
        NSString *placeDateString = [innerDic objectForKey:@"artistEventStartDate"];
        [latiArray addObject:latString];
        [longtiArray addObject:longString];
        [placeName addObject:placeNameString];
        [placeDate addObject:placeDateString];
    }
    
    map.latArray = latiArray;
    map.longArray = longtiArray;
    map.placeName = placeName;
    map.Date = placeDate;
    
    [self.navigationController pushViewController:map animated:YES];
}

- (IBAction)artistDetailsClicked:(id)sender {
    
    US2ArtistDetailViewController *artist = [self.storyboard instantiateViewControllerWithIdentifier:@"artist"];
    artist.artistName = [artistName stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [self.navigationController pushViewController:artist animated:YES];
}

- (IBAction)takeMeThereClicked:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f", latitude, longitude]]];
    
}
@end
