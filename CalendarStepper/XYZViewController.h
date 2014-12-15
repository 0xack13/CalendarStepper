//
//  XYZViewController.h
//  CalendarStepper
//
//  Created by Saleh Albatati on 10/17/13.
//  Copyright (c) 2013 SaudiERP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *gDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *gMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *gYearLabel;

@property (weak, nonatomic) IBOutlet UILabel *hDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *hYearLabel;

@property (weak, nonatomic) IBOutlet UILabel *gDate;


@property (weak, nonatomic) IBOutlet UILabel *hDate;
@property (weak, nonatomic) IBOutlet UILabel *headerDate;

- (void)writeGDate;
- (int) intPart: (float) floatNum;
- (void) islToChr;



@property (weak, nonatomic) IBOutlet UIStepper *gDChanged;
@property (weak, nonatomic) IBOutlet UIStepper *gMChanged;
@property (weak, nonatomic) IBOutlet UIStepper *gYChanged;


@property (weak, nonatomic) IBOutlet UIStepper *hDChanged;
@property (weak, nonatomic) IBOutlet UIStepper *hMChanged;
@property (weak, nonatomic) IBOutlet UIStepper *hYChanged;



@end
