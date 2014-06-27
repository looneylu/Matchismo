//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Luis Carbuccia on 6/21/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *history;
@property (nonatomic, strong) NSMutableString *historyString;
@property (nonatomic, strong) NSArray *historyArray; 



- (void) splitUpHistoryString:(NSString *)stringToSplitUp;


@end
