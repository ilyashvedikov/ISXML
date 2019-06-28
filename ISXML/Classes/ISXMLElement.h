//
//  ISXMLElement.h
//  ISXML
//
//  Created by Ilya Shvedikov on 6/21/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ISXMLElement : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, nullable) NSString *value;
@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSString *> *attributes;
@property (nonatomic, copy, readonly) NSArray<ISXMLElement *> *children;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name;
- (void)addAttributeWithName:(NSString *)name
                       value:(NSString *)value;
- (void)addChild:(ISXMLElement *)child;

@end

NS_ASSUME_NONNULL_END
