//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/19/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController



- (Deck *) createDeck
// creates a playing card deck of SetCard
{

    return [[SetCardDeck alloc] init];
}

- (NSInteger)numberToMatch
{
    return 3;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.numberOfCards = 12;
    self.maxCardSize = CGSizeMake(120.0, 120.0);
}


- (void)updateUI
// cycle through all the cardButtons and set title and background image
{

    // update scoreLabel
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    
    
}




- (NSAttributedString *)attributedTitleForCard:(Card *)card
// title depends on whether the card is chosen
{
    NSAttributedString *title;
    
    if (card.isChosen){
        // go through card.contents and find out components of card (number,symbol,color,shading)
        // each one of these is separated by a ":" in card.contents
        NSArray *contentComponents = [card.contents componentsSeparatedByString:@":"];
        
        // card components are number, shape, color, and shading
        
        // find out card number
        NSUInteger cardNumber;
        if ([contentComponents containsObject:@"1"]){
            cardNumber = 1;
        }else if ([contentComponents containsObject:@"2"]){
            cardNumber = 2;
        }else if ([contentComponents containsObject:@"3"])
            cardNumber = 3;
        
        // find out card symbol (@"■",@"▲",@"●")
        NSString *cardSymbol;
        
        if ([contentComponents containsObject:@"■"])
            cardSymbol = @"■";
        else if ([contentComponents containsObject:@"▲"])
            cardSymbol = @"▲";
        else if ([contentComponents containsObject:@"●"])
            cardSymbol = @"●";
        
        NSMutableString *numSymCombo = [[NSMutableString alloc] init];
        for (int i = 0 ; i < cardNumber ; i++)
            [numSymCombo appendFormat:@"%@", cardSymbol];
        
        
        // find out card color
        UIColor *color;
        
        if ([contentComponents containsObject:@"red"])
            color = [UIColor redColor];
        else if ([contentComponents containsObject:@"blue"])
            color = [UIColor blueColor];
        else if ([contentComponents containsObject:@"green"])
            color = [UIColor greenColor];
        
        // add attibutes
        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        
        [attributes setObject:color forKey:NSForegroundColorAttributeName];
        
        // find out shading
        if ([contentComponents containsObject:@"solid"])
            [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        if ([contentComponents containsObject:@"open"])
            [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
        if ([contentComponents containsObject:@"striped"]){
            [attributes addEntriesFromDictionary:@{NSStrokeWidthAttributeName : @-5,
                                                   NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName],
                                                   NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName]colorWithAlphaComponent:0.1]}];
        }
        
        
        // put components together in attributed string
        title = [[NSAttributedString alloc] initWithString:numSymCombo attributes:attributes];
    }else
        title = [[NSAttributedString alloc] initWithString:@""];
    
    return title;
}


@end
