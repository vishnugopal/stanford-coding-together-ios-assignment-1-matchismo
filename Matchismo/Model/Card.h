//
//  Card.h
//  Matchismo
//
//  Created by Vishnu Gopal on 16/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString* contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

-(int)match:(NSArray *)otherCard;


@end
