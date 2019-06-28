//
//  ISXMLElement.m
//  ISXML
//
//  Created by Ilya Shvedikov on 6/21/19.
//

#import "ISXMLElement.h"
#import "ISXMLWriter.h"

@interface ISXMLElement ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *mutableAttributes;
@property (nonatomic, strong) NSMutableArray <ISXMLElement *> *mutableChildren;

@end

@implementation ISXMLElement

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.value = nil;
        self.mutableAttributes = [@{} mutableCopy];
        self.mutableChildren = [@[] mutableCopy];
    }
    return self;
}

- (void)addAttributeWithName:(NSString *)name
                       value:(NSString *)value
{
    [self.mutableAttributes setObject:value
                               forKey:name];
}

- (void)addChild:(ISXMLElement *)child
{
    [self.mutableChildren addObject:child];
}

#pragma mark - getters
- (NSDictionary<NSString *, NSString *> *)attributes
{
    return [self.mutableAttributes copy];
}

- (NSArray <ISXMLElement *> *)children
{
    return [self.mutableChildren copy];
}

#pragma mark - description

- (NSString *)description
{
    ISXMLWriter *writer = [[ISXMLWriter alloc] initWithElement:self];
    NSString *xmlString = [writer write];
    return xmlString;
}

@end
