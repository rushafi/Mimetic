//
//  _Group.mm
//  Mimetic
//
//  Created by Wasik Mursalin on 1/30/18.
//  Copyright © 2018 mblsft. All rights reserved.
//

#import "_Group.h"
#import "mimetic/rfc822/group.h"

using namespace std;
using namespace mimetic;

@implementation _Group

@synthesize name;

- (id)initWithString:(NSString *)group {
	if(self = [super init]) {
		Group g([group UTF8String]);
		name = [NSString stringWithUTF8String:g.name().c_str()];
	}
	
	return self;
}

- (NSString *)description {
	return stringRepresentation;
}

- (BOOL)isEqual:(_Group *)right {
	return (BOOL)[self.description isEqualToString:right.description];
}

@end
