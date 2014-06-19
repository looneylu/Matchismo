//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/10/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Deck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (nonatomic) BOOL selection;

@end



@implementation CardGameViewController

- (CardMatchingGame *)game
// instantiate game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        
        // by default, game should start off in 2 card match
        self.game.cardsToMatch = [self.gameMode selectedSegmentIndex] + 2;

        NSLog(@"New game has started");
    }

    
    return  _game;
}


- (Deck *)createDeck
// instantiates a playingCardDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)selectGameMode:(UISegmentedControl *)sender
{
    NSLog(@"selected segment index is %d", [sender selectedSegmentIndex]);
    NSLog(@"Game mode is %d", [self.gameMode selectedSegmentIndex]);
    
    // select how many cards to match in game
    if ([self.gameMode selectedSegmentIndex] == 0)
        self.game.cardsToMatch = 2;
    else
        self.game.cardsToMatch = 3;
    
    NSLog(@"Cards to match: %d", self.game.cardsToMatch);
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    if (!self.selection){
        // once user selects a card, disable gameMode selector
        // when new game starts, no switching of game mode
        NSLog(@"Game mode selection is %d", [self.gameMode selectedSegmentIndex]);
        self.gameMode.enabled = NO;

        NSLog(@"Game mode selector has been disabled");
        
        self.selection = YES;
    }

    int chosenButtonIndex = [self.cardButtons indexOfObject:sender]; //which card was selected
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
    
}
- (IBAction)restartGame:(UIButton *)sender
// restarts game
{
    // game is reset to nil
    self.game = nil;
    
    // reset game mode to 2 card match and enable game mode selector
    self.gameMode.selectedSegmentIndex = 0;
    self.gameMode.enabled = YES;
    
    self.selection = NO;
    
    // update the ui to reflect new game
    [self updateUI];

}

- (void)updateUI
// cycle through all the cardButtons and set title and background image
{
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        // if a card is matched, disable corresponding cardButton
        cardButton.enabled = !card.isMatched;
        
        // update scoreLabel
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    

}


- (NSString *)titleForCard:(Card *)card
// title depends on whether the card is chosen
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
// background depends on whether the card is chosen
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront": @"cardback"];
}


@end
