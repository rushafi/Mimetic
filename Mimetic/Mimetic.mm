//
//  Mimetic.mm
//  Mimetic
//
//  Created by Wasik Mursalin on 1/22/18.
//  Copyright © 2018 mblsft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mimetic.h"
#import "mimetic/mimetic.h"

#define DATE_FIELD "Date"
#define LANGUAGE_FIELD "Content-Language"

using namespace std;
using namespace mimetic;

@implementation Mimetic

struct _opaque_mimetic {
	MimeEntity me;
	_opaque_mimetic(): me() {}
	_opaque_mimetic(string mime): me(mime.begin(), mime.end()) {}
};

- (id)init {
	if(self = [super init]) {
		mimetic = new _opaque_mimetic();
		
		rfcDateFormatter = [[NSDateFormatter alloc] init];
		rfcDateFormatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss 'GMT'";
	}
	
	return self;
}

- (id)initWithMime:(NSData *)data {
	if(self = [super init]) {
		NSString *mime = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		string mimeString([mime UTF8String]);
		
		mimetic = new _opaque_mimetic(mimeString);
		
		rfcDateFormatter = [[NSDateFormatter alloc] init];
		rfcDateFormatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss 'GMT'";
	}
	
	return self;
}

- (NSString *)getFrom {
	return [NSString stringWithCString:mimetic->me.header().from().str().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setFrom:(NSString *)from {
	mimetic->me.header().from(MailboxList([from UTF8String]));
}

- (NSString *)getTo {
	return [NSString stringWithCString:mimetic->me.header().to().str().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setTo:(NSString *)to {
	mimetic->me.header().to(AddressList([to UTF8String]));
}

- (NSDate *)getDate {
	if(mimetic->me.hasField(DATE_FIELD)) {
		string date = mimetic->me.header().field(DATE_FIELD).value();
		return [rfcDateFormatter dateFromString:[NSString stringWithCString:date.c_str() encoding:NSUTF8StringEncoding]];
	}
	
	return nil;
}

- (void)setDate:(NSDate *)date {
	NSString *dateString = [rfcDateFormatter stringFromDate:date];
	
	Field dateTimeField(DATE_FIELD, string([dateString UTF8String]));
	mimetic->me.header().push_back(dateTimeField);
}

- (NSString *)getSubject {
	return [NSString stringWithCString:mimetic->me.header().subject().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setSubject:(NSString *)subject {
	mimetic->me.header().subject([subject UTF8String]);
}

- (NSString *)getVersion {
	return [NSString stringWithCString:mimetic->me.header().mimeVersion().str().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setVersion:(NSString *)version {
	mimetic->me.header().mimeVersion(MimeVersion(string([version UTF8String])));
}

- (NSString *)getContentId {
	return [NSString stringWithCString:mimetic->me.header().contentId().str().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setContentId:(NSString *)contentId {
	mimetic->me.header().contentId(ContentId([contentId UTF8String]));
}

- (NSString *)getMessageId {
	return [NSString stringWithCString:mimetic->me.header().messageid().str().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setMessageId:(NSString *)messageId {
	mimetic->me.header().messageid(MessageId(string([messageId UTF8String])));
}

- (NSString *)getContentType {
	return [NSString stringWithCString:mimetic->me.header().contentType().str().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setContentType:(NSString *)contentType {
	mimetic->me.header().contentType(ContentType([contentType UTF8String]));
}

- (NSString *)getContentDisposition {
	return [NSString stringWithCString:mimetic->me.header().contentDisposition().str().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setContentDisposition:(NSString *)contentDisposition {
	mimetic->me.header().contentDisposition(ContentDisposition([contentDisposition UTF8String]));
}

- (NSString *)getContentLanguage {
	if(mimetic->me.hasField(LANGUAGE_FIELD)) {
		string contentLanguage = mimetic->me.header().field(LANGUAGE_FIELD).value();
		return [NSString stringWithCString:contentLanguage.c_str() encoding:NSUTF8StringEncoding];
	}
	
	return nil;
}

- (void)setContentLanguage:(NSString *)contentLanguage {
	Field languageField(LANGUAGE_FIELD, string([contentLanguage UTF8String]));
	mimetic->me.header().push_back(languageField);
}

- (NSString *)getContentTransferEncoding {
	return [NSString stringWithCString:mimetic->me.header().contentTransferEncoding().str().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setContentTransferEncoding:(NSString *)contentTransferEncoding {
	mimetic->me.header().contentTransferEncoding(ContentTransferEncoding([contentTransferEncoding UTF8String]));
}

- (NSString *)getBody {
	stringstream s;
	s << mimetic->me.body();
	
	return [NSString stringWithCString:s.str().c_str() encoding:NSUTF8StringEncoding];
}

- (void)setBody:(NSString *)body {
	mimetic->me.body().set(string([body UTF8String]));
}

- (BOOL)hasField:(NSString *)_field {
	string field([_field UTF8String]);
	return (BOOL)mimetic->me.hasField(field);
}

- (NSString *)mime {
	stringstream s;
	s << mimetic->me;
	
	return [NSString stringWithCString:s.str().c_str() encoding:NSUTF8StringEncoding];
}

@end
