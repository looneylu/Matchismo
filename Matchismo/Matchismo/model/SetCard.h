//
//  SetCard.h
//  Matchismo
//
//  Created by Luis Carbuccia on 6/19/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

//

// symbol is represented as NSString that simply contains a single character
// corresponding to the symbol (i.e. @"■",@"▲",@"●")
// if property is nil, symbol isn't set
@property (strong, nonatomic) NSString *symbol;

// number is an integer from 0 (number not set) to 3
@property (nonatomic) NSUInteger number;

// colors for cards
@property (strong, nonatomic) NSString *shapeColor;

// shading for card
@property (strong, nonatomic) NSString *shapeShading;

// returns and NSArray of NSStrings which are valid shading
+ (NSArray *)validShading;

// returns an NSArray of NSStrings which are valid symbols
+ (NSArray *)validSymbols;

// returns qn NSArray of UIColors which are valid colors
+ (NSArray *)validColors;

+ (NSUInteger) maxNumber; 

@end
