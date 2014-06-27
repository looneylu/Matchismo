//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/19/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

//

- (instancetype)init
// initialize a full deck of card
{
    self = [super init];
    
//    NSLog(@"Initializing SetCardDeck");
    
    if (self)
    {
        // iterate through all the suits and then through all the ranks in that suit
        for (NSString *symbol in [SetCard validSymbols]){
            for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++){
                for (NSString *color in [SetCard validColors]){
                    for(NSString *shading in [SetCard validShading]){
                        // initialize a new playing card and set its suit and rank
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shapeColor = color;
                        card.shapeShading = shading;
                        
                        // add card to the deck (addCard:(Card *)card is a method of superclass Deck)
                        [self addCard:card];
                    }
                

                }
            }
        }
//        NSLog(@"SetCardDeck initialized");
    }
    
    return  self;
}

@end
