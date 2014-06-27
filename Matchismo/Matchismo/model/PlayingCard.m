//
//  PlayingCard.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/11/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

//

- (int)match:(NSArray *)otherCards
// keeps score when there's a match
// overrides superclass' match:
{
    int score = 0;
    
//    NSLog(@"matching %@ %@ %@", self.contents, [[otherCards objectAtIndex:0]contents], [[otherCards objectAtIndex:1]contents]);
    
//    NSLog(@"the array now has %d objects", otherCards.count);
    
    // match against a single other card
    if ([otherCards count] == 1){
        // get card in array
        PlayingCard *otherCard = [otherCards firstObject];
        // give 4 points for matching rank
        if (otherCard.rank == self.rank){
            score = 4;
            NSLog(@"The rank on the cards match!");
        } else if ([otherCard.suit isEqualToString:self.suit]){
            // give 1 point for only matching suit
            score = 1;
            NSLog(@"The suit on the cards match.");
        } else{
            NSLog(@"Cards don't match");
        }
    } else if ([otherCards count] == 2){
        NSLog(@"matching %@ against %@ and %@", self.contents, [[otherCards firstObject]contents], [[otherCards lastObject]contents]);
        // iterate through otherCards array and compare
        for (PlayingCard *otherCard in otherCards){
            if (otherCard.rank == self.rank){
                score += 4;
                
            } else if ([otherCard.suit isEqualToString:self.suit]){
                score += 1;
            } else {
                NSLog(@"Cards don't match");
            }
        }
        
        if ([[otherCards firstObject]rank] == [[otherCards lastObject]rank])
            score += 4;
        if ([[otherCards firstObject]suit] == [[otherCards lastObject]suit])
            score += 1;
    }
    
    return score;
}

- (NSString *)contents
// override superclass' contents method
{
    // make array with proper rank strings so that ranks above 10 are propery represented
    NSArray *rankStrings = [PlayingCard rankStrings];
    
    
    return  [rankStrings[self.rank] stringByAppendingString:self.suit];
}


@synthesize suit = _suit;

+ (NSArray *)validSuits
// returns an NSArray of NSStrings which are valid suits
{
    return @[@"♣️",@"♦️", @"♠️", @"♥️"];
}

- (void)setSuit:(NSString *)suit
// override setter for suit to have it check to be sure no one tries to set a suit to something invalid
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit
// override getter for suit to make a suit  of nil return ?
{
    return _suit ? _suit : @"?";
}


+ (NSArray *)rankStrings
// acceptable rank strings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
// uses maxRank to make sure rank is never set to improper value
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}


@end
