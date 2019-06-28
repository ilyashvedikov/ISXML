//
//  ISXMLWriter.h
//  ISXML
//
//  Created by Ilya Shvedikov on 6/28/19.
//  Copyright © 2019 Ilya Shvedikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISXMLElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISXMLWriter : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithElement:(ISXMLElement *)element;

- (NSString *)write;

@end

NS_ASSUME_NONNULL_END
