//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Luis Carbuccia on 6/10/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//




/********************* ABSTRACT CLASS **************************/

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) NSUInteger numberOfCards;
@property (nonatomic) CGSize maxCardSize;


//

-(Deck *)createDeck; //abstract

- (NSInteger)numberToMatch; //abstract

- (void)updateUI; //cycle through all the cardButtons and set tittle and background image


- (UIView *)createViewForCard:(Card *)card; // dummy method to be overwritten by subclass
- (void)updateView:(UIView *)cardView forCard:(Card *)card; // dummy method



@end
