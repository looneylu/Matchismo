//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/12/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score; //allow read/write to score privately
@property (nonatomic, strong) NSMutableArray *cards; // to keep track of cards
@property (nonatomic, strong) NSMutableArray *otherCards; // to keep track of selected cards
@end

@implementation CardMatchingGame
//
- (NSUInteger)numberOfDealtCards
{
    return [self.cards count];
}

- (void)setCardsToMatch:(NSInteger)cardsToMatch
{
    _cardsToMatch = cardsToMatch;
}


- (NSMutableArray *)cards
// array for holding card objects
{
    // if array hasn't been initialized, do so
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

- (NSMutableArray *)otherCards
{
    if (!_otherCards)
        _otherCards = [[NSMutableArray alloc] init];
    
    return _otherCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
// start off initializer by letting superclass have a chance
// to initialize itself
{
    self = [super init]; //super's designated initializer

    if (self){
        
        // to initialize game, iterate through the passed count of cards
        // drawRandomCard from the passed deck, the addObject: to NSMutable array
        // of cards
        for (int i = 0 ; i < count ; i++){
            Card *card = [deck drawRandomCard];
            
            // make sure card is non-nil
            if (card){
                [self.cards addObject:card];
            }else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}



- (Card *)cardAtIndex:(NSUInteger)index
// get a card
{
    // check for out of bounds
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
// choose card in card matching game
{
    Card *card = [self cardAtIndex:index]; //card to be chosen
    
    
    if (!card.isMatched) // only unmatched cards can be chosen
    {
        if (card.isChosen){
            card.chosen = NO; // if card is already chosen, unchoose it
        } else {
            
            self.otherCards = nil;
            
            // match against other chosen cards
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    
                    // add otherCard to array
                    [self.otherCards addObject:otherCard];
                }
            }
            
            // if the total number of cards = cardsToMatch
            if (self.cardsToMatch == [self.otherCards count] + 1){
                int matchScore = [card match:self.otherCards];
                
                    // if there's a match
                    if (matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        for (Card *other in self.otherCards)
                            other.matched = YES;
                        card.matched = YES;
                            
                        //set array to nil
                        self.otherCards = nil;
                    } else {
                        // if there's no match, impose penalty
                        self.score -= MISMATCH_PENALTY;
                        for (Card *other in self.otherCards){
                            other.chosen = NO;
                        }
                            
                        // set array to nil
                        self.otherCards = nil;
                    }
                }
        
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
