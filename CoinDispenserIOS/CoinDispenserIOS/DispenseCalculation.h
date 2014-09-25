//
//  DispenseCalculation.h
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/25.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DispenseCalculation : NSObject

@property (nonatomic) double amountDue;
@property (nonatomic) double noteReceived;
@property (nonatomic, copy) NSMutableArray *cashToDispense;
@property (nonatomic, copy) NSString *message;

@end
