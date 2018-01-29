//
//  Mimetic.h
//  Mimetic
//
//  Created by Wasik Mursalin on 1/22/18.
//  Copyright © 2018 mblsft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mimetic : NSObject {
	struct _opaque_mimetic *mimetic;
	NSDateFormatter *rfcDateFormatter;
}

@property (nonatomic, strong, getter=getFrom, setter=setFrom:) NSString *from;
@property (nonatomic, strong, getter=getTo, setter=setTo:) NSString *to;
@property (nonatomic, strong, getter=getDate, setter=setDate:) NSDate *date;
@property (nonatomic, strong, getter=getSubject, setter=setSubject:) NSString *subject;
@property (nonatomic, strong, getter=getVersion, setter=setVersion:) NSString *version;
@property (nonatomic, strong, getter=getContentId, setter=setContentId:) NSString *contentId;
@property (nonatomic, strong, getter=getMessageId, setter=setMessageId:) NSString *messageId;
@property (nonatomic, strong, getter=getContentType, setter=setContentType:) NSString *contentType;
@property (nonatomic, strong, getter=getContentDisposition, setter=setContentDisposition:) NSString *contentDisposition;
@property (nonatomic, strong, getter=getContentLanguage, setter=setContentLanguage:) NSString *contentLanguage;
@property (nonatomic, strong, getter=getContentTransferEncoding, setter=setContentTransferEncoding:) NSString *contentTransferEncoding;
@property (nonatomic, strong, getter=getBody, setter=setBody:) NSString *body;


- (id)initWithMime:(NSData *)data;
- (BOOL)hasField:(NSString *)field;
- (NSString *)mime;

@end
