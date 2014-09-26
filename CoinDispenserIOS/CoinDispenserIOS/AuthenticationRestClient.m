#import "AuthenticationRestClient.h"

#import "BaseRestClient.h"
#import "LoginResult.h"
#import <UIKit/UIKit.h>

@implementation AuthenticationRestClient

/**
 * Asynchorniously trigger the REST service to authdnticate the user
 */
-(void) authenticateUser:(NSString *)uname password:(NSString *)pass completionHandler:(void(^)()) completionHandler loginResult:(LoginResult *)rslt {
    self.completionHandler = completionHandler;
    self.result = rslt;
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/CoinDispenserWS/user/%@/%@", uname, pass]; //TODO parameterize
    NSURL *url = [NSURL URLWithString:urlStr];
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLRequest *req = [NSURLRequest
                         requestWithURL:url
                         cachePolicy:NSURLRequestReloadIgnoringCacheData
                         timeoutInterval:30.0];
    
    [NSURLConnection connectionWithRequest:req delegate:self];
}

/**
 * XML parsing. On start element we may need to setup stuff
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [self clearContentsOfElement];
}

/**
 * Element ended - set the value on the model
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"result"]) {
        [(LoginResult *)self.result setResult:contentsOfElement];
        
    } else if ([elementName isEqualToString:@"success"]) {
        [(LoginResult *)self.result setSuccess:contentsOfElement];
    }
    [self clearContentsOfElement];
}

@end

