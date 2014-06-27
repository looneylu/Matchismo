//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/19/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"


@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController
//

- (Deck *) createDeck
// creates a playing card deck
{
    return [[PlayingCardDeck alloc] init];
}

- (UIView *)createViewForCard:(Card *)card
{
    PlayingCardView *playingCardView = [[PlayingCardView alloc] init];
    
    [self updateView:playingCardView forCard:card];
    
    return playingCardView;
}



- (void)updateView:(UIView *)cardView forCard:(Card *)card
{
    if (![card isKindOfClass:[PlayingCard class]])
        return;
    if (![cardView isKindOfClass:[PlayingCardView class]])
        return;
    
    PlayingCard *playingCard = (PlayingCard *)card;
    PlayingCardView *playingCardView = (PlayingCardView *)cardView;
    
    playingCardView.rank = playingCard.rank;
    playingCardView.suit = playingCard.suit;
    playingCardView.faceUp = playingCard.chosen;
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.numberOfCards = 30;
    self.maxCardSize = CGSizeMake(80.0, 120.0);
}
@end
