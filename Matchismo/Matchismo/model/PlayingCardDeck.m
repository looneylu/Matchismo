//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/11/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

//

- (instancetype)init
// initialize a full deck of card
{
    self = [super init];
    
    if (self)
    {
        // iterate through all the suits and then through all the ranks in that suit
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                // initialize a new playing card and set its suit and rank
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                
                // add card to the deck (addCard:(Card *)card is a method of superclass Deck) 
                [self addCard:card];
            }
        }
 //       NSLog(@"PlayingCardDeck initialized");
    }
    
    return  self;
}

@end
