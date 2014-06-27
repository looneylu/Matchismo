//
//  SetCard.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/19/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

//
- (int)match:(NSArray *)otherCards
// keeps score when there's a match
// overrides superclass' match:
{
    int score = 0;
    
    if ([otherCards count] == 2){
        NSLog(@"matching %@ against %@ and %@", self.contents, [[otherCards firstObject]contents], [[otherCards lastObject]contents]);
        // iterate through otherCards array and compare
        for (SetCard *otherCard in otherCards){
            if (otherCard.number == self.number){
                if ([[otherCards firstObject]number] == [[otherCards lastObject]number])
                    score += 4;
                
            } else if ([otherCard.symbol isEqualToString:self.symbol]){
                if ([[otherCards firstObject]symbol] == [[otherCards lastObject]symbol])
                    score += 1;
            } else {
                NSLog(@"Cards don't match");
            }
        }

    }
    
    return score;
}

- (NSString *)contents
// override superclass' contents method
{
    NSString *cardContents = [NSString stringWithFormat:@"%d:%@:%@:%@", self.number, self.symbol, self.shapeColor, self.shapeShading];
    
    return cardContents ;
}


+ (NSArray *) validColors
// returns an NSArray of UIColors which are valid colors
{
    return @[@"red", @"blue",@"green"];
}


@synthesize symbol = _symbol;

+ (NSArray *)validSymbols
// returns an NSArray of NSStrings which are valid symbols
{
    return @[@"■",@"▲",@"●"];
}

- (void)setSymbol:(NSString *)symbol
// override setter for symbol to have it check to be sure no one tries to set a symbol to something invalid
{
    if ([[SetCard validSymbols] containsObject:symbol]){
        _symbol = symbol;
    }
}

- (NSString *)symbol
// override getter for suit to make a suit  of nil return ?
{
    return _symbol ? _symbol : @"?";
}


+ (NSArray *)numberStrings
// acceptable rank strings
{
    return @[@"?",@"1",@"2",@"3"];
}

+ (NSUInteger)maxNumber
{
    return [[self numberStrings] count] - 1;
}

- (void)setNumber:(NSUInteger)number
// uses maxRank to make sure rank is never set to improper value
{
    if (number <= [SetCard maxNumber])
    {
        _number = number;
    }
}

+ (NSArray *)validShading
// acceptable shades for cars
{
    return @[@"open", @"solid", @"striped"];
}

- (void)setShapeShading:(NSString *)shapeShading
{
    if ([[SetCard validShading] containsObject:shapeShading])
        _shapeShading = shapeShading;
}

- (void)setShapeColor:(NSString *)shapeColor
{
        if ([[SetCard validColors] containsObject:shapeColor])
            _shapeColor = shapeColor;
}



@end
