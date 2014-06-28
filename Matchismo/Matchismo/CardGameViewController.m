//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/10/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "CardGameViewController.h"
#import "Grid.h"


@interface CardGameViewController ()

@property (nonatomic, strong) Deck *deck;
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (nonatomic) BOOL gameHasStarted;
@property (strong, nonatomic) Grid *grid;

@end


@implementation CardGameViewController
//
- (Grid *) grid
// lazily instantiate grid
{
    if (!_grid){
        _grid = [[Grid alloc] init];
        _grid.cellAspectRatio = self.maxCardSize.width / self.maxCardSize.height;
        _grid.minimumNumberOfCells = self.numberOfCards;
        _grid.maxCellWidth = self.maxCardSize.width;
        _grid.maxCellHeight = self.maxCardSize.height;
        _grid.size = self.gridView.frame.size;
    }
    return _grid;
}

- (NSMutableArray *)cardViews
// lazily instantiate cardViews
{
    if (!_cardViews)
        _cardViews = [[NSMutableArray alloc] initWithCapacity:self.numberOfCards];
    
    return  _cardViews;
}

- (CardMatchingGame *)game
// instantiate game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.numberOfCards
                                                  usingDeck:[self createDeck]];
        
        // by default, game should start off in 2 card match
        self.game.cardsToMatch = [self.gameMode selectedSegmentIndex] + [self numberToMatch];
    }
    
    return  _game;
}


- (Deck *)createDeck // abstract method
// instantiates a playingCardDeck
{
    return nil;
}

- (NSInteger)numberToMatch
{
    return 2;
}


- (IBAction)selectGameMode:(id)sender
{
        // select how many cards to match in game
    if ([self.gameMode selectedSegmentIndex] == 0)
        self.game.cardsToMatch = 2;
    else
        self.game.cardsToMatch = 3;
        

}



- (IBAction)restartGame:(UIButton *)sender
// restarts game
{
    // game is reset to nil
    self.game = nil;
    
    // reset game mode to 2 card match and enable game mode selector
    self.gameMode.selectedSegmentIndex = 0;
    self.gameMode.enabled = YES;
    self.gameHasStarted = NO;
    
    // erase the card views
    for (UIView *subView in self.cardViews) {
        [subView removeFromSuperview];
    }
    
    // cardViews array is set to nil
    self.cardViews = nil;
    
    // update the ui to reflect new game
    [self updateUI];

}

#define CARD_SPACING_PERCENT 0.08

- (void)updateUI
{
    
    // loop over all cards in game
    // To know if a view for a card does exist, store the index of the card in the tag property of the view
    // If it doesn't exist, create a new view for that card, set the tag value, add a tap gesture to the view
    // and finally add the "button" to the grid view and store it in the cards array. If the view does exist,
    // update the view and mark matched cards. Finally, calculate the gram of teh card using the grid class.
    // Because the grid class does not leave any space between cards, inset them slightly.
    for (int cardIndex = 0 ; cardIndex < self.game.numberOfDealtCards ; cardIndex++)
    {
        Card *card = [self.game cardAtIndex:cardIndex];
        
        NSUInteger viewIndex = [self.cardViews indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]]){
                if (((UIView *)obj).tag == cardIndex)return YES;
            }
            return NO;
        }];
        
        UIView *cardView;
        if (viewIndex == NSNotFound){
            cardView = [self createViewForCard:card];
            cardView.tag = cardIndex;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCard:)];
            
            [cardView addGestureRecognizer:tap];
            [self.cardViews addObject:cardView];
            viewIndex = [self.cardViews indexOfObject:cardView];
            [self.gridView addSubview:cardView];
        } else {
            cardView = self.cardViews[viewIndex];
            [self updateView:cardView forCard:card];
            cardView.alpha = card.matched ? 0.06 :1.0;
        }
        
        CGRect frame = [self.grid frameOfCellAtRow: viewIndex / self.grid.columnCount
                                          inColumn:viewIndex % self.grid.columnCount];
        frame = CGRectInset(frame, frame.size.width * CARD_SPACING_PERCENT, frame.size.height * CARD_SPACING_PERCENT);
        cardView.frame = frame;
    }
        
    // update scoreLabel
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

}

- (UIView *)createViewForCard:(Card *)card
// dummy method to be overwritten by subclasses
{
    UIView *cardView = [[UIView alloc] init];
    [self updateView:cardView forCard:card];
    return cardView;
}

- (void)updateView:(UIView *)cardView forCard:(Card *)card
// dummy method to be overwritten by subclasses
{
    cardView.backgroundColor = [UIColor blueColor];
}

- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    if (!self.gameHasStarted){
        // once user selects a card, disable gameMode selector
        // when new game starts, no switching of game mode
        self.gameMode.enabled = NO;
        self.gameHasStarted = YES;
    }
    
    Card* card = [self.game cardAtIndex:gesture.view.tag];
    
    // when card is chosen, use flip transition
    [UIView transitionWithView:gesture.view duration:0.25
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        card.chosen = !card.chosen;
                        [self updateView:gesture.view forCard:card];
                    } completion:^(BOOL finished){
                        card.chosen = !card.chosen;
                        [self.game chooseCardAtIndex:gesture.view.tag];
                        [self updateUI];
                    }];

}






@end
