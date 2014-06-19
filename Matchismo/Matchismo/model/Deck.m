//
//  Deck.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/10/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "Deck.h"
//#import "Card.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@end

@implementation Deck

- (NSMutableArray *)cards
//mutable array to hold card objects
{
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    return  _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop){
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
// grabs card from a random spot in the self.cards array
{
    Card *randomCard = nil;
    
    if ([self.cards count]) // make sure array isn't empty
    {
        // pick random card
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        
        // remove card from array so that it doesn't get picked again
        [self.cards removeObjectAtIndex:index];
        
    }

    return randomCard;
}

@end
