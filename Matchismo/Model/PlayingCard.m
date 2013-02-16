//
//  PlayingCard.m
//  Matchismo
//
//  Created by Vishnu Gopal on 16/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard 

-(NSString*)contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray*)validSuits {
    static NSArray *validSuits = nil;
    if(!validSuits) validSuits = @[@"♠", @"♣", @"♥", @"♦"];
    return validSuits;
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray*) rankStrings {
    static NSArray *rankStrings = nil;
    if(!rankStrings) rankStrings = @[@"?",@"A", @"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    
    return rankStrings;
}

+ (NSUInteger)maxRank {
    return [self.rankStrings count] - 1;
}

@end
