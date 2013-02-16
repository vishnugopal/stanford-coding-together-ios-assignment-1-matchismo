//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Vishnu Gopal on 17/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) int lastScore;
@property (nonatomic, readwrite) Card* lastFlippedCard;
@property (nonatomic, readwrite) NSArray* lastMatchedCards;
@property (nonatomic) NSMutableArray* cardsInMatchQueue;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)cardsInMatchQueue {
    if(!_cardsInMatchQueue) _cardsInMatchQueue = [[NSMutableArray alloc] init];
    
    return _cardsInMatchQueue;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
                break;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    self.numberOfCardsToMatch = 2;
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define CardMatchingGameFlipCost 1
#define CardMatchingGameMatchBonus 4
#define CardMatchingGameMismatchPenalty 2

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.lastFlippedCard = nil;
    self.lastMatchedCards = nil;
    self.lastScore = 0;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.lastFlippedCard = card;
            [self.cardsInMatchQueue addObject:card];
            if ([self.cardsInMatchQueue count] == self.numberOfCardsToMatch) {
                [self finalizeTurnScore];
            }
            self.score -= CardMatchingGameFlipCost;
        } else {
            [self.cardsInMatchQueue removeObject:card];
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (void)finalizeTurnScore {
    self.lastMatchedCards = [self.cardsInMatchQueue copy];
    
    Card* card = [self.cardsInMatchQueue lastObject];
    [self.cardsInMatchQueue removeLastObject];
    
    int matchScore = [card match:self.cardsInMatchQueue];
    if (matchScore) {
        for (Card* otherCard in self.cardsInMatchQueue) {
            otherCard.unplayable = YES;
        }
        card.unplayable = YES;
        self.lastScore = matchScore * CardMatchingGameMatchBonus;
        self.score += self.lastScore;
        self.cardsInMatchQueue = nil;
    } else {
        for (Card* otherCard in self.cardsInMatchQueue) {
            otherCard.faceUp = NO;
        }
        self.lastScore = -CardMatchingGameMismatchPenalty;
        self.score += self.lastScore;
        self.cardsInMatchQueue = nil;
        [self.cardsInMatchQueue addObject:card];
    }
    
}

@end
