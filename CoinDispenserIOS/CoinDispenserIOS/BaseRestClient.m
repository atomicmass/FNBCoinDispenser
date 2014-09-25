//
//  BaseRestClient.m
//  CoinDispenserIOS
//
//  Created by Sean Coetzee on 2014/09/23.
//  Copyright (c) 2014 Sean Coetzee. All rights reserved.
//

#import "BaseRestClient.h"

@implementation BaseRestClient

- (id) init {
    self = [super init];
    return self;
}

- (void) clearContentsOfElement {
    _contentsOfElement = [[NSMutableString alloc] init];
}

/**
 * Start parsing the XML documnent using the parser in the child classes
 */
- (void) parseDocument:(NSData *) data {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [_contentsOfElement appendString:string];
}

- (NSString *)trim:(NSString *)inStr {
    return [inStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
