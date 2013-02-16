//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Vishnu Gopal on 16/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck* deck;
@end

@implementation CardGameViewController

-(Deck*) deck {
    if(!_deck) _deck = [[PlayingCardDeck alloc] init];
    
    return _deck;
}

-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Flips updated to: %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender {
    Card *card = [self.deck drawRandomCard];
    [sender setTitle:card.contents forState:UIControlStateSelected];
    sender.selected = !sender.isSelected;
    self.flipCount++;
}


@end
