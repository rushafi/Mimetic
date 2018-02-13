//
//  _MimeEntity.h
//  Mimetic
//
//  Created by Wasik Mursalin on 1/22/18.
//  Copyright © 2018 mblsft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class _Address, _Group, _Mailbox;

@interface _MimeEntity : NSObject {
	struct _opaque_mime_entity *mimetic;
	NSDateFormatter *rfcDateFormatter;
}

@property (nonatomic, strong, getter=getFrom, setter=setFrom:) _Mailbox *from;
@property (nonatomic, strong, readonly) NSMutableArray *to;
@property (nonatomic, strong, readonly) NSMutableArray *replyTo;
@property (nonatomic, strong, readonly) NSMutableArray *cc;
@property (nonatomic, strong, readonly) NSMutableArray *bcc;

@property (nonatomic, strong, getter=getSubject, setter=setSubject:) NSString *subject;
@property (nonatomic, strong, getter=getMessageId, setter=setMessageId:) NSString *messageId;
@property (nonatomic, strong, getter=getVersion, setter=setVersion:) NSString *version;
@property (nonatomic, strong, getter=getDate, setter=setDate:) NSDate *date;
@property (nonatomic, strong, getter=getContentType, setter=setContentType:) NSString *contentType;
@property (nonatomic, strong, getter=getContentTransferEncoding, setter=setContentTransferEncoding:) NSString *contentTransferEncoding;
@property (nonatomic, strong, getter=getContentDisposition, setter=setContentDisposition:) NSString *contentDisposition;
@property (nonatomic, strong, getter=getContentDescription, setter=setContentDescription:) NSString *contentDescription;
@property (nonatomic, strong, getter=getContentId, setter=setContentId:) NSString *contentId;
@property (nonatomic, strong, getter=getContentLanguage, setter=setContentLanguage:) NSString *contentLanguage;

@property (nonatomic, strong, getter=getBody, setter=setBody:) NSString *body;
@property (nonatomic, strong, getter=getPreamble, setter=setPreamble:) NSString *preamble;
@property (nonatomic, strong, getter=getEpilogue, setter=setEpilogue:) NSString *epilogue;

- (id)init;
- (id)initWithMimeString:(NSString *)mime;
- (id)initWithMimeData:(NSData *)data;

- (BOOL)hasHeaderField:(NSString *)field;
- (NSString *)valueForHeaderField:(NSString *)field;
- (void)setValue:(NSString *)value forHeaderField:(NSString *)field;
- (NSArray *)mimeBodyParts;

- (NSString *)description;

@end
