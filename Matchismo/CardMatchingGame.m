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
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
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
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.lastFlippedCard = nil;
    self.lastMatchedCards = nil;
    self.lastScore = 0;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.lastFlippedCard = card;
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.lastScore = matchScore * MATCH_BONUS;
                        self.score += self.lastScore;
                    } else {
                        otherCard.faceUp = NO;
                        self.lastScore = -MISMATCH_PENALTY;
                        self.score += self.lastScore;
                    }
                    self.lastMatchedCards = @[card, otherCard];
                }
            }
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

@end
