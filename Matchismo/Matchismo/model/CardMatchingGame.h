//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Luis Carbuccia on 6/12/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

@property (nonatomic) NSInteger cardsToMatch;
@property (nonatomic) NSUInteger numberOfDealtCards; //number of cards dealt in game

//
// initializes new game
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

// choose card in card matching game
- (void)chooseCardAtIndex:(NSUInteger)index;

// get a card
-(Card *)cardAtIndex:(NSUInteger)index;

// keep game score
@property (nonatomic, readonly) NSInteger score;

@end
