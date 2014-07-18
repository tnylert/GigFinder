//
//  US2EventDetailViewController.h
//  GigFinder
//
//  Created by Tanya on 7/18/14.
//  Copyright (c) 2014 ustwo.com.ty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface US2EventDetailViewController : UIViewController

@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *eventPlaceName;
@property (nonatomic, retain) NSString *artistName;
@property (nonatomic, retain) NSString *fullDate;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *eventImageURL;
@property (nonatomic, retain) NSArray *allArtistDic;

- (IBAction)MoreFromArtistClicked:(id)sender;
- (IBAction)artistDetailsClicked:(id)sender;
- (IBAction)takeMeThereClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *EventDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *EventMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *EventPlaceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *FullDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreFromArtistBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *cityCountrrLabel;

@end
