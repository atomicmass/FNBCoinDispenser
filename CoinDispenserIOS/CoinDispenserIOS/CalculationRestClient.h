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
    DispenseCash                *wipCash;
}

-(void) calculate:(DispenseCalculation *)calc completionHandler:(void(^)()) completionHandler;

@end
