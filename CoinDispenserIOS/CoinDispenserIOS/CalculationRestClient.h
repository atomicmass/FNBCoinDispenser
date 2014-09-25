//
//  CalculationRestClient.h
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/24.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRestClient.h"
@class DispenseCalculation;
@class DispenseCash;

@interface CalculationRestClient : BaseRestClient {
    NSMutableData               *wipData;		// The data being received from the rest service
    DispenseCalculation			*wipResult;		// the work in progress result
    DispenseCash                *wipCash;
}

@property (nonatomic) DispenseCalculation *result;
@property (nonatomic) id controller;

-(void) calculate:(id)cntrller calculation:(DispenseCalculation *)calc;

@end
