//
//  ISXMLParser.h
//  ISXML
//
//  Created by Ilya Shvedikov on 7/9/19.
//  Copyright © 2019 Ilya Shvedikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISXMLElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISXMLParser : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithData:(NSData *)data;

- (nullable ISXMLElement *)parse;

@end

NS_ASSUME_NONNULL_END
