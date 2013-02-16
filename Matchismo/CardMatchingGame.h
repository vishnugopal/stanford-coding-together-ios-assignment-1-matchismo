//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Vishnu Gopal on 17/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck*)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card*)cardAtIndex:(NSUInteger)index;

@property (nonatomic) NSUInteger numberOfCardsToMatch;
@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) int lastScore;
@property (nonatomic, readonly) Card* lastFlippedCard;
@property (nonatomic, readonly) NSArray* lastMatchedCards;

@end
