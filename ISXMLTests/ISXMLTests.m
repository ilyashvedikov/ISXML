//
//  ISXMLTests.m
//  ISXMLTests
//
//  Created by Ilya Shvedikov on 6/28/19.
//  Copyright © 2019 Ilya Shvedikov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ISXML/ISXML.h>

@interface ISXMLTests : XCTestCase

@end

@implementation ISXMLTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_structure_and_indentation {
    NSString *expected = @"<Root>\
\n\t<First att=\"attValue\">firstValue</First>\
\n\t<Second/>\
\n\t<Third>\
\n\t\t<Fourth>Foo</Fourth>\
\n\t</Third>\
\n</Root>";
    
    
    ISXMLElement *root = [[ISXMLElement alloc] initWithName:@"Root"];
    
    ISXMLElement *first = [[ISXMLElement alloc] initWithName:@"First"];
    [first setValue:@"firstValue"];
    [first addAttributeWithName:@"att" value:@"attValue"];
    
    [root addChild:first];
    
    ISXMLElement *second = [[ISXMLElement alloc] initWithName:@"Second"];
    [root addChild:second];
    
    ISXMLElement *third = [[ISXMLElement alloc] initWithName:@"Third"];
    [root addChild:third];

    ISXMLElement *fourth = [[ISXMLElement alloc] initWithName:@"Fourth"];
    [fourth setValue:@"Foo"];
    [third addChild:fourth];
    
    XCTAssertEqualObjects(expected, root.description);
}

- (void)test_less_than_symbol_is_escaped_in_element_value
{
    NSString *expected = @"<Element>if (age &lt; 5)</Element>";
    
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual setValue:@"if (age < 5)"];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_greater_than_symbol_is_escaped_in_element_value
{
    NSString *expected = @"<Element>if (age &gt; 5)</Element>";
    
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual setValue:@"if (age > 5)"];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_ampersand_symbol_is_escaped_in_element_value
{
    NSString *expected = @"<Element>Smith&amp;Sons</Element>";
    
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual setValue:@"Smith&Sons"];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_qoute_symbol_is_escaped_in_element_value
{
    NSString *expected = @"<Element>She said &quot;OK&quot;</Element>";
    
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual setValue:@"She said \"OK\""];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_apostrophe_symbol_is_escaped_in_element_value
{
    NSString *expected = @"<Element>You&apos;re right</Element>";
    
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual setValue:@"You're right"];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_less_than_symbol_is_escaped_in_attribute_value
{
    NSString *expected = @"<Element attributeName=\"a&lt;b\"/>";
    
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual addAttributeWithName:@"attributeName" value:@"a<b"];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_greater_than_symbol_is_escaped_in_attribute_value
{
    NSString *expected = @"<Element attributeName=\"a&gt;b\"/>";
    
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual addAttributeWithName:@"attributeName" value:@"a>b"];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_ampersand_symbol_is_escaped_in_attribute_value
{
    NSString *expected = @"<Element attributeName=\"Smith&amp;Sons\"/>";
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual addAttributeWithName:@"attributeName" value:@"Smith&Sons"];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_qoute_symbol_is_escaped_in_attribute_value
{
    NSString *expected = @"<Element attributeName=\"He said &quot;OK&quot;\"/>";
    
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual addAttributeWithName:@"attributeName" value:@"He said \"OK\""];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_apostrophe_symbol_is_escaped_in_attribute_value
{
    NSString *expected = @"<Element attributeName=\"You&apos;re right\"/>";
    
    ISXMLElement *actual = [[ISXMLElement alloc] initWithName:@"Element"];
    [actual addAttributeWithName:@"attributeName" value:@"You're right"];
    
    XCTAssertEqualObjects(expected, actual.description);
}

- (void)test_parent_child_relations
{
    ISXMLElement *root = [[ISXMLElement alloc] initWithName:@"Root"];
    
    ISXMLElement *child =  [[ISXMLElement alloc] initWithName:@"Child"];
    [root addChild:child];
    
    ISXMLElement *childOfChild = [[ISXMLElement alloc] initWithName:@"ChildOfChild"];
    [child addChild:childOfChild];
    
    XCTAssertNil(root.parent);
    XCTAssertEqual(child.parent, root);
    XCTAssertEqual(childOfChild.parent, child);
    XCTAssertEqual(childOfChild.parent.parent, root);
}

- (void)test_parse_empty_string
{
    NSString *xml = @"";
    NSData *xmlData = [xml dataUsingEncoding:NSASCIIStringEncoding];
    ISXMLElement *element = [[ISXMLElement alloc] initWithData:xmlData];
    
    XCTAssertNil(element);
}

- (void)test_parse_invalid_xml
{
    NSString *xml = @"<Root><Child>";
    NSData *xmlData = [xml dataUsingEncoding:NSASCIIStringEncoding];
    ISXMLElement *element = [[ISXMLElement alloc] initWithData:xmlData];
    
    XCTAssertNil(element);
}

- (void)test_parse_valid_xml
{
    NSString *xml = @"<Root><Child att=\"childAtt\"><ChildOfChild>value1</ChildOfChild><ChildOfChild att=\"attVal\">value2</ChildOfChild></Child></Root>";
    NSData *xmlData = [xml dataUsingEncoding:NSASCIIStringEncoding];
    ISXMLElement *element = [[ISXMLElement alloc] initWithData:xmlData];
    XCTAssertEqualObjects(element.name, @"Root");
    XCTAssertEqualObjects(element[@"Child"].name, @"Child");
    XCTAssertEqualObjects(element[@"Child"].attributes[@"att"], @"childAtt");
    XCTAssertNil(element[@"Child"].value);
    XCTAssertEqualObjects(element[@"Child"].parent, element);
    XCTAssertEqualObjects(element[@"Child"][@"ChildOfChild"].value, @"value1");
    XCTAssertEqualObjects(element[@"Child"][@"ChildOfChild"].all[0].value, @"value1");
    XCTAssertEqual(element[@"Child"][@"ChildOfChild"].all.count, 2);
    XCTAssertEqualObjects(element[@"Child"][@"ChildOfChild"].all.lastObject.value, @"value2");
    XCTAssertEqualObjects(element[@"Child"][@"ChildOfChild"].all.lastObject.attributes[@"att"], @"attVal");
}


@end
