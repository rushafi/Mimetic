//
//  _Group.h
//  Mimetic
//
//  Created by Wasik Mursalin on 1/30/18.
//  Copyright © 2018 mblsft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _Group : NSObject {
	NSString *stringRepresentation;
}

@property (nonatomic, strong, readonly) NSString *name;

- (id)initWithString:(NSString *)group;
- (NSString *)description;
- (BOOL)isEqual:(_Group *)group;

@end
