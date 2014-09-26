#import "AuthenticationRestClient.h"

#import "BaseRestClient.h"
#import "LoginResult.h"
#import <UIKit/UIKit.h>

@implementation AuthenticationRestClient

@synthesize result;

-(id) init {
    self = [super init];
    result = [[LoginResult alloc] init];
    return self;
}

/**
 * Asynchorniously trigger the REST service to authdnticate the user
 */
-(void) authenticateUser:(NSString *)uname password:(NSString *)pass completionHandler:(void(^)(LoginResult *)) completionHandler {
    self.completionHandler = completionHandler;
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
    
    if ([elementName isEqualToString:@"loginResult"]) {
        wipResult = [[LoginResult alloc] init];
    }
}

/**
 * Element ended - set the value on the model
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"loginResult"]) {
        result = wipResult;
        wipResult = nil;
    } else if ([elementName isEqualToString:@"result"]) {
        [wipResult setResult:contentsOfElement];
        
    } else if ([elementName isEqualToString:@"success"]) {
        [wipResult setSuccess:contentsOfElement];
    }
    [self clearContentsOfElement];
}

@end

