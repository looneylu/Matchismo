//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/21/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()


@end

@implementation HistoryViewController


- (NSMutableString *)historyString
{
    if (!_historyString)
        _historyString = [[NSMutableString alloc]init];
    
    return _historyString;
}

- (void) splitUpHistoryString:(NSString *)stringToSplitUp
{
    NSLog(@"String to split up is: ");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.history.text = self.historyString;

}


@end
