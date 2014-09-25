//
//  DispenseCalculation.m
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/25.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import "DispenseCalculation.h"

@implementation DispenseCalculation

@synthesize amountDue, noteReceived, cashToDispense, message;

- (id) init {
    self = [super init];
    cashToDispense =[[NSMutableArray alloc] init];
    return self;
}

@end
