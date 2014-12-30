//
//  XYZViewController.m
//  CalendarStepper
//
//  Created by Saleh Albatati on 10/17/13.
//  Copyright (c) 2013 SaudiERP. All rights reserved.
//

#import "XYZViewController.h"

@interface XYZViewController ()

@end

@implementation XYZViewController

@synthesize dateFormat, islamicCalendar;
@synthesize dateString, date, currentDate, sevenDaysAgo, cdate, dateComponents, gregorianCalendar, gregorianComponents, hijriCalendar, hijriComponents, hijriDateFormat, repeatingTimer;


- (NSDateFormatter *)dateFormat {
    NSLog(@"Entered getter!\n");

    static NSDateFormatter *dateFormat;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy"; // twitter date format
    });
    return dateFormat;
}
/*
- (NSDateFormatter *)dateFormat {
    if (dateFormat == nil) {
        NSLog(@"Entered getter!\n");
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMMM d, y \n HH:mm:ss zzz"];
    }
    
    return dateFormat;
}*/

- (void)viewDidLoad
{
    islamicCalendar.text = [NSString stringWithFormat:NSLocalizedString(@"Islamic Calendar", @"")];
    gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    hijriCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];
    
   // dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setDateFormat:@"MMMM d, y \n HH:mm:ss zzz"];
    
    [super viewDidLoad];
	
    date = [NSDate date];
    // format it
    //dateFormat = [[NSDateFormatter alloc]init];
    //[dateFormat setDateFormat:@"MMMM d, y \n HH:mm:ss zzz"];
    
    // convert it to a string
    @autoreleasepool {
        self.headerDate.text =  [self.dateFormat stringFromDate:date];
        
    }
    
    
    //Get today's Hijri date
    
    // free up memory
    // [dateFormat release];
    
    // update a label’s text
    
    // ** substract two dates
    //currentDate = [NSDate date];
    //dateComponents = [[NSDateComponents alloc] init];
    //[dateComponents setDay:-7];
    //sevenDaysAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    //NSLog(@"\ncurrentDate: %@\nseven days ago: %@", currentDate, sevenDaysAgo);
    
    // ** Set Hijri Date
    //self.hDate.text = [NSString stringWithFormat: @"\ncurrentDate: %@\nseven days ago: %@", currentDate, sevenDaysAgo];
    
    // Create a Gregorian Calendar
    
    // Set up components of a Gregorian date
    gregorianComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    /*NSLog(@"[In Gregorian calendar ->] Day: %ld, Month: %ld, Year:%ld",
     (long)[gregorianComponents day],
     (long)[gregorianComponents month],
     (long)[gregorianComponents year]);
     */
    
    gregorianComponents.day = [gregorianComponents day];
    gregorianComponents.month = [gregorianComponents month];
    gregorianComponents.year = [gregorianComponents year];
    
    // Create the date
    cdate = [gregorianCalendar dateFromComponents:gregorianComponents];
    
    
    
    // Then create an Islamic calendar
    
    
    
    // And grab those date components for the same date
    hijriComponents = [hijriCalendar components:(NSDayCalendarUnit |
                                                 NSMonthCalendarUnit |
                                                 NSYearCalendarUnit)
                                       fromDate:cdate];
    
    
    /*
     NSLog(@"[In Hijri calendar ->] Day: %ld, Month: %ld, Year:%ld",
     (long)[hijriComponents day],
     (long)[hijriComponents month],
     (long)[hijriComponents year]);
     */
    hijriDateFormat = [NSString stringWithFormat:@"\n%d, %d %d", (int)[hijriComponents day], [hijriComponents month], [hijriComponents year]];
    
    self.headerDate.text = [self.headerDate.text stringByAppendingString:hijriDateFormat];
    
    // Do any additional setup after loading the view, typically from a nib.
    // get the current date
    
    repeatingTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                   selector: @selector(showHeaderDate:)
                                                userInfo: nil
                                                 repeats: YES];
    
    
    // Set up components of a Gregorian date
    NSDateComponents *gregorianComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
   /*
    NSLog(@"Initialized &&& [In Gregorian calendar ->] Day: %ld, Month: %ld, Year:%ld",
          (long)[gregorianComponents day],
          (long)[gregorianComponents month],
          (long)[gregorianComponents year]);
    */
    self.gDayLabel.text = [NSString stringWithFormat: @"%d", [gregorianComponents day]];
    self.gMonthLabel.text = [NSString stringWithFormat: @"%d", [gregorianComponents month]];
    self.gYearLabel.text = [NSString stringWithFormat: @"%d", [gregorianComponents year]];
    
    [self convertDatetoIslamic];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gDChanged:(id)sender {
    //UILabel *label = [[UILabel alloc]init];
    //self.gDayLabel.text = @"Welcome!";
    self.gDayLabel.text = [NSString stringWithFormat:@"%d",
                           [ [NSNumber numberWithDouble:[(UIStepper* ) sender value]] integerValue]];
    //[self writeGDate];
    [self convertDatetoIslamic];
    //[self convertDatetoGregorian];

}

- (IBAction)gMChanged:(id)sender {
    //UILabel *label = [[UILabel alloc]init];
    //self.gDayLabel.text = @"Welcome!";
    self.gMonthLabel.text = [NSString stringWithFormat:@"%d",
                            [ [NSNumber numberWithDouble:[(UIStepper* ) sender value]] integerValue]];
    //[self writeGDate];
    [self convertDatetoIslamic];
    //[self convertDatetoGregorian];

}
        
- (IBAction)gYChanged:(id)sender {
    //UILabel *label = [[UILabel alloc]init];
    //self.gDayLabel.text = @"Welcome!";
    self.gYearLabel.text = [NSString stringWithFormat:@"%d",
                            [ [NSNumber numberWithDouble:[(UIStepper* ) sender value]] integerValue]];

    //[self writeGDate];
    [self convertDatetoIslamic];
    //[self convertDatetoGregorian];

}



- (IBAction)hDChanged:(id)sender {
    //UILabel *label = [[UILabel alloc]init];
    //self.gDayLabel.text = @"Welcome!";
    self.hDayLabel.text = [NSString stringWithFormat:@"%d",
                           [ [NSNumber numberWithDouble:[(UIStepper* ) sender value]] integerValue]];
    //[self writeGDate];
    //[self convertDatetoIslamic];
    [self convertDatetoGregorian];

}

- (IBAction)hMChanged:(id)sender {
    //UILabel *label = [[UILabel alloc]init];
    //self.gDayLabel.text = @"Welcome!";
    self.hMonthLabel.text = [NSString stringWithFormat:@"%d",
                           [ [NSNumber numberWithDouble:[(UIStepper* ) sender value]] integerValue]];
    //[self writeGDate];
    //[self convertDatetoIslamic];
    [self convertDatetoGregorian];

}

- (IBAction)hYChanged:(id)sender {
    //UILabel *label = [[UILabel alloc]init];
    //self.gDayLabel.text = @"Welcome!";
    self.hYearLabel.text = [NSString stringWithFormat:@"%d",
                           [ [NSNumber numberWithDouble:[(UIStepper* ) sender value]] integerValue]];
    
        
    //[self writeGDate];
    //[self convertDatetoIslamic];
    [self convertDatetoGregorian];
}


- (void)writeGDate {
    // Implementation goes here
    NSLog(@"Welcome to my writeGatefunction");
    
    NSString *gDStr = self.gDayLabel.text;
    NSString *gMStr = self.gMonthLabel.text;
    NSString *gYStr = self.gYearLabel.text;
    NSString *gStr = [NSString stringWithFormat: @"%@/%@/%@",gDStr, gMStr, gYStr];
    self.gDate.text = gStr;

    NSString *hDStr = self.hDayLabel.text;
    NSString *hMStr = self.hMonthLabel.text;
    NSString *hYStr = self.hYearLabel.text;
    NSString *hStr = [NSString stringWithFormat: @"%@/%@/%@",hDStr, hMStr, hYStr];
    self.hDate.text = hStr;

}

-(NSString *)StringFromDate:(NSDate *)DateLocal{
    return [dateFormat stringFromDate:DateLocal];
}

- (void) showHeaderDate: (NSTimer *)timer {
    
  
    
    
    
    
    
    //dateString, dateFormat, date, currentDate, sevenDaysAgo, cdate, dateComponents, gregorianCalendar, gregorianComponents, hijriCalendar,hijriComponents, hijriDateFormat = nil;
    [self.repeatingTimer invalidate];
    NSTimer *timer1 =  [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                      target: self
                                                    selector: @selector(showHeaderDate:)
                                                    userInfo: nil
                                                     repeats: YES];
    self.repeatingTimer = timer1;
        
    
}

-(void) convertDatetoIslamic {
    /*NSString *dateStr = [self.gYearLabel.text stringByAppendingFormat:@"-%@-%@ 00:00", self.gMonthLabel.text, self.gDayLabel.text];;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm ";
    df.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *dateInGrogrian = [df dateFromString:dateStr];
    

    NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCivilCalendar];
    
    NSDate *today = [NSDate date];
    [islamicCalendar rangeOfUnit:NSDayCalendarUnit startDate:&today interval:NULL forDate:today];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:islamicCalendar];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    //english output
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    //NSString * islamicDateString = [dateFormatter stringFromDate:dateInGrogrian];


    //NSLog(@"Orig = %@",[df stringFromDate:dateInGrogrian]);
    NSLog(@"Converted date to Islamic = %@",[dateFormatter stringFromDate:dateInGrogrian]);
    self.hDate.text = [NSString stringWithFormat: @"Converted date to Islamic = %@",[dateFormatter stringFromDate:dateInGrogrian]];
    */
    [self chrToIsl];
    }

// Define Gregoratian Date automatically
-(void) convertDatetoGregorian {
    
    [self islToChr];
}

-(int) intPart: (float) floatNum {
    if (floatNum < -0.0000001){
        return ceil(floatNum - 0.0000001);
	}
    return floor(floatNum+0.0000001);
}

-(void) islToChr {
	int d=  self.hDayLabel.text.intValue;
	int m = self.hMonthLabel.text.intValue;
	int y = self.hYearLabel.text.intValue;
	int jd;
    jd = [self intPart:(11 * y + 3) / 30] + 354 * y + 30 * m - [self intPart:((m-1) / 2 ) ]+ d + 1948440 - 385;
	//int JD = jd;
	//arg.wd.value=weekDay(jd%7)
    int l, n, i, j, k;
    if (jd > 2299160 )
    {
        l = jd + 68569;
        n = [self intPart:(((4*l)/146097))];
        l = l - [self intPart:((146097*n+3)/4)];
        i = [self intPart:((4000*(l+1))/1461001)];
        l= l - [self intPart:((1461*i)/4)]+31;
        j = [self intPart:((80*l)/2447)];
        d = l - [self intPart:((2447*j)/80)];
        l= [self intPart:(j/11)];
        m=j+2-12*l;
        y=100*(n-49)+i+l;
    }
    else
    {
        j=jd+1402;
        k=[self intPart:((j-1)/1461)];
        l=j-1461*k;
        n=[self intPart:((l-1)/365)]-[self intPart:(l/1461)];
        i=l-365*n+30;
        j=[self intPart:((80*i)/2447)];
        d=i-[self intPart:((2447*j)/80)];
        i=[self intPart:(j/11)];
        m=j+2-12*i;
        y=4*k+n+i-4716;
    }
    
    NSLog(@"Gregorian: %d %d %d", d, m, y);
    self.gDayLabel.text = [NSString stringWithFormat: @"%d", d];
    self.gMonthLabel.text = [NSString stringWithFormat: @"%d", m];
    self.gYearLabel.text = [NSString stringWithFormat: @"%d", y];
}

-(void) chrToIsl {
	int d=  self.gDayLabel.text.intValue;
	int m = self.gMonthLabel.text.intValue;
	int y = self.gYearLabel.text.intValue;
	int jd, l, n, j;
    if ((y>1582)||((y==1582)&&(m>10))||((y==1582)&&(m==10)&&(d>14)))
    {
        jd=[self intPart:((1461*(y+4800+[self intPart:((m-14)/12)]))/4) ]+[self intPart: ((367*(m-2-12*([self intPart:((m-14)/12) ])))/12)]-[self intPart:((3* ([self intPart:((y+4900+[self intPart:((m-14)/12)])/100)])) /4)]+d-32075;
    }
    else
    {
        jd = 367*y-[self intPart:((7*(y+5001+[self intPart:((m-9)/7)]))/4)]+[self intPart:((275*m)/9) ]+d+1729777;
    }
    //arg.JD.value=jd
    //arg.wd.value=weekDay(jd%7)
    l = jd-1948440+10632;
    n = [self intPart:((l-1)/10631) ];
    l = l-10631*n+354;
    j = ([self intPart:((10985-l)/5316)])*([self intPart:((50*l)/17719) ])+([self intPart:(l/5670) ])*([self intPart:((43*l)/15238) ]);
    l = l-([self intPart:((30-j)/15)])*([self intPart:((17719*j)/50) ])-([self intPart:(j/16) ])*([self intPart:((15238*j)/43) ])+29;
    m = [self intPart:((24*l)/709)];
    d = l-[self intPart:((709*m)/24)];
    y=30*n+j-30;
    
	NSLog(@"Hijri: %d %d %d", d, m, y);
    self.hDayLabel.text = [NSString stringWithFormat: @"%d", d];
    self.hMonthLabel.text = [NSString stringWithFormat: @"%d", m];
    self.hYearLabel.text = [NSString stringWithFormat: @"%d", y];
}


@end
