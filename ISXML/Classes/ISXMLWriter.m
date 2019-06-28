//
//  ISXMLWriter.m
//  ISXML
//
//  Created by Ilya Shvedikov on 6/28/19.
//  Copyright © 2019 Ilya Shvedikov. All rights reserved.
//

#import "ISXMLWriter.h"

@interface ISXMLWriter ()

@property (nonatomic, strong) ISXMLElement *element;
@property (nonatomic, strong) NSMutableString *xmlString;
@property (nonatomic) NSUInteger indentationLevel;

@end

@implementation ISXMLWriter

- (instancetype)initWithElement:(ISXMLElement *)element
{
    self = [super init];
    if (self)
    {
        self.element = element;
        self.xmlString = [@"" mutableCopy];
        self.indentationLevel = 0;
    }
    return self;
}

- (NSString *)write
{
    [self writeElement:self.element];
    return [self.xmlString copy];
}

- (void)writeElement:(ISXMLElement *)element
{
    [self writeIndents:self.indentationLevel];
    [self writeOpenElementWithName:element.name];
    [self writeAttributes:element.attributes];

    if (element.children.count > 0)
    {
        [self writeChildrenForElement:element];
    }
    else if (element.value)
    {
        [self write:@">"];
        [self writeEscape:element.value];
        [self write:@"</"];
        [self write:element.name];
        [self write:@">"];
    }
    else
    {
        [self write:@"/>"];
    }
    
    if (self.indentationLevel > 0)
    {
        [self write:@"\n"];
    }
}

- (void)write:(NSString *)string
{
    [self.xmlString appendString:string];
}

- (void)writeEscape:(NSString *)string
{
    for (NSInteger idx = 0; idx < string.length; idx++)
    {
        unichar character = [string characterAtIndex:idx];
        int characterCode = (int)character;
        switch (characterCode) {
            case 34:
                [self write:@"&quot;"];
                break;
            case 38:
                [self write:@"&amp;"];
                break;
            case 39:
                [self write:@"&apos;"];
                break;
            case 60:
                [self write:@"&lt;"];
                break;
            case 62:
                [self write:@"&gt;"];
                break;
            default:
                [self write:[NSString stringWithFormat:@"%C", character]];
        }
    }
}

- (void)writeIndents:(NSUInteger)level
{
    for (int i = 0; i < level; i++)
    {
        [self write:@"\t"];
    }
}

- (void)writeOpenElementWithName:(NSString *)name
{
    [self write:@"<"];
    [self write:name];
}

- (void)writeAttributes:(NSDictionary <NSString *, NSString *> *)attributes
{
    for (NSString *key in attributes)
    {
        [self write:@" "];
        [self write:key];
        [self write:@"=\""];
        [self writeEscape:attributes[key]];
        [self write:@"\""];
    }
}

- (void)writeChildrenForElement:(ISXMLElement *)element
{
    [self write:@">"];
    [self write:@"\n"];
    self.indentationLevel++;
    for (ISXMLElement *child in element.children)
    {
        [self writeElement:child];
    }
    self.indentationLevel--;
    [self writeIndents:self.indentationLevel];
    [self write:@"</"];
    [self write:element.name];
    [self write:@">"];
}

@end
