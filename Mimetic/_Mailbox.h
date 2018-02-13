//
//  _Mailbox.h
//  Mimetic
//
//  Created by Wasik Mursalin on 1/30/18.
//  Copyright © 2018 mblsft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _Mailbox : NSObject {
	NSString *stringRepresentation;
}

@property (nonatomic, strong, readonly) NSString *mailbox;
@property (nonatomic, strong, readonly) NSString *domain;
@property (nonatomic, strong, readonly) NSString *label;

- (id)initWithString:(NSString *)mailbox;
- (id)initWithLabel:(NSString *)label mailbox:(NSString *)mailbox andDomain:(NSString *)domain;
- (BOOL)isEqual:(_Mailbox *)mailbox;
- (NSString *)description;

@end
