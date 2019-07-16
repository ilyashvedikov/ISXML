//
//  ISXMLParser.m
//  ISXML
//
//  Created by Ilya Shvedikov on 7/9/19.
//  Copyright © 2019 Ilya Shvedikov. All rights reserved.
//

#import "ISXMLParser.h"

@interface ISXMLParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSData *data;
@property (nonatomic, readwrite) NSError *parseError;
@property (nonatomic, strong) ISXMLElement *rootElement;
@property (nonatomic, strong) ISXMLElement *currentElement;
@property (nonatomic, strong) NSMutableString *foundCharacters;

@end

@implementation ISXMLParser

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self)
    {
        self.data = data;
    }
    return self;
}

- (nullable ISXMLElement *)parse
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.data];
    [parser setDelegate:self];
    [parser parse];
    if (self.parseError)
    {
        return nil;
    }
    return self.rootElement;
}

#pragma mark - NSXMLParserDelegare methods

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    ISXMLElement *element = [[ISXMLElement alloc] initWithName:elementName];
    for (NSString *key in attributeDict)
    {
        [element addAttributeWithName:key
                                value:attributeDict[key]];
    }
    if (!self.rootElement)
    {
        self.rootElement = element;
        self.currentElement = element;
    }
    else
    {
        [self.currentElement addChild:element];
        self.currentElement = element;
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if (self.foundCharacters && ![self.foundCharacters isEqualToString:@""])
    {
        self.currentElement.value = [self.foundCharacters copy];
    }
    self.foundCharacters = nil;
    self.currentElement  = self.currentElement.parent;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.foundCharacters == nil)
    {
        self.foundCharacters = [@"" mutableCopy];
    }
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self.foundCharacters appendString:trimmedString];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    self.parseError = parseError;
}

@end
