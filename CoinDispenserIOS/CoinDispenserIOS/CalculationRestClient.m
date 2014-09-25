//
//  CalculationRestClient.m
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/24.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#pragma GCC diagnostic ignored "-Wundeclared-selector"

#import "CalculationRestClient.h"
#import "DispenseCalculation.h"
#import "DispenseCash.h"
#import <UIKit/UIKit.h>

@implementation CalculationRestClient

@synthesize result, controller;

-(id) init {
    self = [super init];
    result = [[DispenseCalculation alloc] init];
    return self;
}

-(void) calculate:(id)cntrller calculation:(DispenseCalculation *)calc {
    self.controller = cntrller;
    NSString *urlStr = @"http://localhost:8080/CoinDispenserWS/dispenser";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSString *json = [NSString stringWithFormat:@"{\"amountDue\": %.2f, \"noteReceived\":%.0f }", calc.amountDue, calc.noteReceived];
    NSLog(@"JSON: %@", json);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableURLRequest *req = [NSMutableURLRequest
                            requestWithURL:url
                            cachePolicy:NSURLRequestReloadIgnoringCacheData
                            timeoutInterval:30.0];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData *requestBodyData = [json dataUsingEncoding:NSUTF8StringEncoding];
    [req setHTTPBody:requestBodyData];
    
    [NSURLConnection connectionWithRequest:req delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"Received Response");
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        int status = (int)httpResponse.statusCode;
        
        if (!((status >= 200) && (status < 300))) {
            NSLog(@"Connection failed with status %d", status);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        } else {
            wipData = [[NSMutableData alloc] initWithCapacity:1024];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [wipData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
    [self parseDocument:wipData];
    
    if ([controller respondsToSelector:@selector(updateCalculation:)]) {
        [controller performSelector:@selector(updateCalculation:) withObject:result];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [self clearContentsOfElement];
    
    if ([elementName isEqualToString:@"dispenseCalculation"]) {
        wipResult = [[DispenseCalculation alloc] init];
    } else if ([elementName isEqualToString:@"cashToDispense"]) {
        wipCash = [[DispenseCash alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"dispenseCalculation"]) {
        result = wipResult;
        wipResult = nil;
    } else if([elementName isEqualToString:@"cashToDispense"]) {
        [wipResult.cashToDispense addObject:wipCash];
        wipCash = nil;
    } else if ([elementName isEqualToString:@"amountDue"]) {
        [wipResult setAmountDue:[_contentsOfElement doubleValue]];
    } else if ([elementName isEqualToString:@"noteReceived"]) {
        [wipResult setNoteReceived:[_contentsOfElement doubleValue]];
    } else if ([elementName isEqualToString:@"denomination"]) {
        [wipCash setDenomination:[_contentsOfElement doubleValue]];
    } else if ([elementName isEqualToString:@"quantity"]) {
        [wipCash setQuantity:[_contentsOfElement intValue]];
    } else if ([elementName isEqualToString:@"message"]) {
        [wipResult setMessage:_contentsOfElement];
    }
    
    [self clearContentsOfElement];
}

@end
