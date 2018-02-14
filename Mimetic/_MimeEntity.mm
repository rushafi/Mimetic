//
//  _MimeEntity.mm
//  Mimetic
//
//  Created by Wasik Mursalin on 1/22/18.
//  Copyright © 2018 mblsft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "mimetic/mimetic.h"
#import "mimetic/mimeentitylist.h"
#import "mimetic/rfc822/field.h"

#import "_MimeEntity.h"
#import "_Group.h"
#import "_Mailbox.h"

#define DATE_FIELD "Date"
#define LANGUAGE_FIELD "Content-Language"

using namespace std;
using namespace mimetic;

@implementation _MimeEntity

struct _opaque_mime_entity {
	MimeEntity me;
	_opaque_mime_entity(): me() {}
	_opaque_mime_entity(string mime): me(mime.begin(), mime.end()) {}
};

#pragma mark - Initializers

- (id)init {
	if(self = [super init]) {
		[self setup];
		mimetic = new _opaque_mime_entity();
	}
	
	return self;
}

- (id)initWithMimeString:(NSString *)mime {
	if(self = [super init]) {
		[self setup];
		mimetic = new _opaque_mime_entity(string([mime UTF8String]));
		
		[self parseAddressList:mimetic->me.header().to() inMutableArray:self.to];
		[self parseAddressList:mimetic->me.header().replyto() inMutableArray:self.replyTo];
		[self parseAddressList:mimetic->me.header().cc() inMutableArray:self.cc];
		[self parseAddressList:mimetic->me.header().bcc() inMutableArray:self.bcc];
	}
	
	return self;
}

#pragma mark - Setup utility

- (void)setup {
	rfcDateFormatter = [[NSDateFormatter alloc] init];
	rfcDateFormatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss 'GMT'";
	
	_to = [[NSMutableArray alloc] init];
	_replyTo = [[NSMutableArray alloc] init];
	_cc = [[NSMutableArray alloc] init];
	_bcc = [[NSMutableArray alloc] init];
}

- (void)parseAddressList:(AddressList)list inMutableArray:(NSMutableArray *)array {
	AddressList::iterator it;
	
	for(it = list.begin(); it != list.end(); ++it) {
		Address address = *it;
		if(address.isGroup()) {
			NSString *stringRepresentation = [NSString stringWithUTF8String:address.group().str().c_str()];
			_Group *group = [[_Group alloc] initWithString:stringRepresentation];
			
			[array addObject:group];
		}
		else {
			NSString *stringRepresentation = [NSString stringWithUTF8String:address.mailbox().str().c_str()];
			_Mailbox *mailbox = [[_Mailbox alloc] initWithString:stringRepresentation];
			
			[array addObject:mailbox];
		}
	}
}

- (id)initWithMimeData:(NSData *)data {
	NSString *mime = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return [self initWithMimeString:mime];
}

#pragma mark - List setters

- (void)setToList {
	if(self.to.count == 0) return;
	
	NSMutableString *list = [[NSMutableString alloc] init];
	
	for(NSObject *object in self.to) {
		if([object isKindOfClass:[_Mailbox class]]) {
			[list appendFormat:@"%@", [(_Mailbox *)object description]];
		}
		
		if([object isKindOfClass:[_Group class]]) {
			[list appendFormat:@"%@", [(_Group *)object description]];
		}
		
		if(![object isEqual:self.to.lastObject]) {
			[list appendFormat:@", "];
		}
	}
	
	AddressList toList([list UTF8String]);
	mimetic->me.header().to(toList);
}

- (void)setReplyToList {
	if(self.replyTo.count == 0) return;
	
	NSMutableString *list = [[NSMutableString alloc] init];
	
	for(NSObject *object in self.replyTo) {
		if([object isKindOfClass:[_Mailbox class]]) {
			[list appendFormat:@"%@", [(_Mailbox *)object description]];
		}
		
		if([object isKindOfClass:[_Group class]]) {
			[list appendFormat:@"%@", [(_Group *)object description]];
		}
		
		if(![object isEqual:self.replyTo.lastObject]) {
			[list appendFormat:@", "];
		}
	}
	
	AddressList replyToList([list UTF8String]);
	mimetic->me.header().replyto(replyToList);
}

- (void)setCcList {
	if(self.cc.count == 0) return;
	
	NSMutableString *list = [[NSMutableString alloc] init];
	
	for(NSObject *object in self.cc) {
		if([object isKindOfClass:[_Mailbox class]]) {
			[list appendFormat:@"%@", [(_Mailbox *)object description]];
		}
		
		if([object isKindOfClass:[_Group class]]) {
			[list appendFormat:@"%@", [(_Group *)object description]];
		}
		
		if(![object isEqual:self.cc.lastObject]) {
			[list appendFormat:@", "];
		}
	}
	
	AddressList ccList([list UTF8String]);
	mimetic->me.header().cc(ccList);
}

- (void)setBccList {
	if(self.bcc.count == 0) return;
	
	NSMutableString *list = [[NSMutableString alloc] init];
	
	for(NSObject *object in self.bcc) {
		if([object isKindOfClass:[_Mailbox class]]) {
			[list appendFormat:@"%@", [(_Mailbox *)object description]];
		}
		
		if([object isKindOfClass:[_Group class]]) {
			[list appendFormat:@"%@", [(_Group *)object description]];
		}
		
		if(![object isEqual:self.bcc.lastObject]) {
			[list appendFormat:@", "];
		}
	}
	
	AddressList bccList([list UTF8String]);
	mimetic->me.header().bcc(bccList);
}

#pragma mark - Header Fields

// Getter & Setter for From (MailboxList)

- (_Mailbox *)getFrom {
	MailboxList list = mimetic->me.header().from();
	Mailbox m = *(list.begin());
	
	NSString *stringRepresentation = [NSString stringWithUTF8String:m.str().c_str()];
	_Mailbox *mailbox = [[_Mailbox alloc] initWithString:stringRepresentation];
	
	return mailbox;;
}

- (void)setFrom:(_Mailbox *)from {
	MailboxList list([[from description] UTF8String]);
	mimetic->me.header().from(list);
}


// Getter & Setter for Subject

- (NSString *)getSubject {
	return [NSString stringWithUTF8String:mimetic->me.header().subject().c_str()];
}

- (void)setSubject:(NSString *)subject {
	
	mimetic->me.header().subject(string([subject UTF8String]));
}

// Getter & Setter for MessageId

- (NSString *)getMessageId {
	return [NSString stringWithUTF8String:mimetic->me.header().messageid().str().c_str()];
}

- (void)setMessageId:(NSString *)messageId {
	mimetic->me.header().messageid(MessageId(string([messageId UTF8String])));
}

// Getter & Setter for MIME version

- (NSString *)getVersion {
	return [NSString stringWithUTF8String:mimetic->me.header().mimeVersion().str().c_str()];
}

- (void)setVersion:(NSString *)version {
	mimetic->me.header().mimeVersion(MimeVersion(string([version UTF8String])));
}

// Getter & Setter for Date

- (NSDate *)getDate {
	if([self hasHeaderField:@DATE_FIELD]) {
		return [rfcDateFormatter dateFromString:[self valueForHeaderField:@DATE_FIELD]];
	}
	
	return nil;
}

- (void)setDate:(NSDate *)date {
	NSString *dateString = [rfcDateFormatter stringFromDate:date];
	
	Field dateTimeField(DATE_FIELD, string([dateString UTF8String]));
	mimetic->me.header().push_back(dateTimeField);
}

// Getter & Setter for Content Type

- (NSString *)getContentType {
	return [NSString stringWithUTF8String:mimetic->me.header().contentType().str().c_str()];
}

- (void)setContentType:(NSString *)contentType {
	mimetic->me.header().contentType(ContentType([contentType UTF8String]));
}

// Getter & Setter for Content Transfer Encoding

- (NSString *)getContentTransferEncoding {
	return [NSString stringWithUTF8String:mimetic->me.header().contentTransferEncoding().str().c_str()];
}

- (void)setContentTransferEncoding:(NSString *)contentTransferEncoding {
	mimetic->me.header().contentTransferEncoding(ContentTransferEncoding([contentTransferEncoding UTF8String]));
}

// Getter & Setter for Content Disposition

- (NSString *)getContentDisposition {
	return [NSString stringWithUTF8String:mimetic->me.header().contentDisposition().str().c_str()];
}

- (void)setContentDisposition:(NSString *)contentDisposition {
	mimetic->me.header().contentDisposition(ContentDisposition([contentDisposition UTF8String]));
}

// Getter & Setter for Content Description

- (NSString *)getContentDescription {
	return [NSString stringWithUTF8String:mimetic->me.header().contentDescription().str().c_str()];
}

- (void)setContentDescription:(NSString *)contentDescription {
	mimetic->me.header().contentDescription(ContentDescription([contentDescription UTF8String]));
}

// Getter & Setter for Content ID

- (NSString *)getContentId {
	return [NSString stringWithUTF8String:mimetic->me.header().contentId().str().c_str()];
}

- (void)setContentId:(NSString *)contentId {
	mimetic->me.header().contentId(ContentId([contentId UTF8String]));
}

// Getter & Setter for Content Language

- (NSString *)getContentLanguage {
	if([self hasHeaderField:@LANGUAGE_FIELD]) {
		return [self valueForHeaderField:@LANGUAGE_FIELD];
	}
	
	return nil;
}

- (void)setContentLanguage:(NSString *)contentLanguage {
	Field languageField(LANGUAGE_FIELD, string([contentLanguage UTF8String]));
	mimetic->me.header().push_back(languageField);
}

#pragma mark - Header utility

- (BOOL)hasHeaderField:(NSString *)name {
	return (BOOL)mimetic->me.hasField(string([name UTF8String]));
}

- (NSString *)valueForHeaderField:(NSString *)name {
	Field field = mimetic->me.header().field(string([name UTF8String]));
	return [NSString stringWithUTF8String:field.value().c_str()];
}

- (void)setValue:(NSString *)value forHeaderField:(NSString *)name {
	string fieldName(name.UTF8String);
	string fieldValue(value.UTF8String);
	
	Field headerField(fieldName, fieldValue);
	mimetic->me.header().push_back(headerField);
}

#pragma mark - Body

- (NSString *)getBody {
	stringstream s;
	s << mimetic->me.body();
	
	return [NSString stringWithUTF8String:s.str().c_str()];
}

- (void)setBody:(NSString *)body {
	mimetic->me.body().set(string([body UTF8String]));
}

- (NSString *)getPreamble {
	return [NSString stringWithUTF8String:mimetic->me.body().preamble().c_str()];
}

- (void)setPreamble:(NSString *)preamble {
	mimetic->me.body().preamble(string([preamble UTF8String]));
}

- (NSString *)getEpilogue {
	return [NSString stringWithUTF8String:mimetic->me.body().epilogue().c_str()];
}

- (void)setEpilogue:(NSString *)epilogue {
	mimetic->me.body().epilogue(string([epilogue UTF8String]));
}

- (NSArray *)mimeBodyParts {
	MimeEntityList list = mimetic->me.body().parts();
	MimeEntityList::iterator it;
	
	NSMutableArray *_list = [[NSMutableArray alloc] init];
	
	for(it = list.begin(); it != list.end(); ++it) {
		MimeEntity *entity = *it;
		
		stringstream s;
		s << *entity;
		
		NSString *mimeString = [NSString stringWithUTF8String:s.str().c_str()];
		_MimeEntity *_entity = [[_MimeEntity alloc] initWithMimeString:mimeString];
		
		[_list addObject:_entity];
	}
	
	return _list;
}

#pragma mark - MIME

- (NSString *)description {
	[self setToList];
	[self setReplyToList];
	[self setCcList];
	[self setBccList];
	
	stringstream s;
	s << mimetic->me;
	
	return [NSString stringWithUTF8String:s.str().c_str()];
}

@end
