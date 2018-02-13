//
//  _Mailbox.mm
//  Mimetic
//
//  Created by Wasik Mursalin on 1/30/18.
//  Copyright © 2018 mblsft. All rights reserved.
//

#import "_Mailbox.h"
#import "mimetic/rfc822/mailbox.h"

using namespace std;
using namespace mimetic;

@implementation _Mailbox

@synthesize mailbox;
@synthesize domain;
@synthesize label;

- (id)initWithString:(NSString *)string {
	if(self = [super init]) {
		Mailbox m([string UTF8String]);
		stringRepresentation = [NSString stringWithUTF8String:m.str().c_str()];
		
		mailbox = [NSString stringWithUTF8String:m.mailbox().c_str()];
		domain = [NSString stringWithUTF8String:m.domain().c_str()];
		
		if((BOOL)m.label().empty()) {
			label = self.mailbox.capitalizedString;
		}
		else {
			label = [NSString stringWithUTF8String:m.label().c_str()];
		}
	}
	
	return self;
}

- (id)initWithLabel:(NSString *)l mailbox:(NSString *)mb andDomain:(NSString *)d {
	if(self = [super init]) {
		Mailbox m;
		
		label = [[NSString alloc] initWithString:l];
		mailbox = [[NSString alloc] initWithString:mb];
		domain = [[NSString alloc] initWithString:d];
		
		m.label(string([label UTF8String]));
		m.mailbox(string([mailbox UTF8String]));
		m.domain(string([domain UTF8String]));
		
		stringRepresentation = [NSString stringWithUTF8String:m.str().c_str()];
	}
	
	return self;
}

- (BOOL)isEqual:(_Mailbox *)right {
	return [self.mailbox isEqualToString:right.mailbox] && ([self.domain caseInsensitiveCompare:right.domain] == NSOrderedSame);
}

- (NSString *)description {
	return stringRepresentation;
}

@end
