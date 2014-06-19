//
//  Card.m
//  Matchismo
//
//  Created by Luis Carbuccia on 6/10/14.
//  Copyright (c) 2014 Luis Carbuccia. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *) otherCards
{
    int score = 0;
    
    // score 1 point if ANY of the passed otherCards' contents match the
    // receiving  Card's contents
    for (Card *card in otherCards)
    {
        NSLog(@"MATCH     %@ , %@", card.contents, self.contents);
        if ([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }

    
    return score;
}

@end
