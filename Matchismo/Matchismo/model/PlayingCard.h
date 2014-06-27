//
//  PlayingCard.h
//  Matchismo
//
//  Created by Luis Carbuccia on 6/11/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

//

// suit is represesented as NSString that simply contains
// a single character corresponding to the suit
// (i.e. ♣️♦️♠️♥️). If property is nil, suit isn't set
@property (strong, nonatomic) NSString *suit;

// rank is an integer from 0 (rank not set) to 13 (a King)
@property (nonatomic) NSUInteger rank;

// returns an NSArray of NSStrings which are valid suits
+ (NSArray *)validSuits;

+ (NSUInteger)maxRank;

@end
