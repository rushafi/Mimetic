//
//  MimeticTests.mm
//  MimeticTests
//
//  Created by Wasik Mursalin on 1/25/18.
//  Copyright © 2018 mblsft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Mimetic/Mimetic.h>

@interface MimeticTests : XCTestCase

@property(nonatomic, strong) NSString *contentType;
@property(nonatomic, strong) NSString *contentTransferEncoding;
@property(nonatomic, strong) NSString *from;
@property(nonatomic, strong) NSString *to;
@property(nonatomic, strong) NSDate *date;
@property(nonatomic, strong) NSString *mimeVersion;
@property(nonatomic, strong) NSString *messageId;
@property(nonatomic, strong) NSString *contentLanguage;
@property(nonatomic, strong) NSString *subject;
@property(nonatomic, strong) NSString *body;
@property(nonatomic, strong) NSString *mimeMessage;

@end

@implementation MimeticTests

- (void)setUp {
    [super setUp];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss 'GMT'"];
	
	_contentType = @"text/plain; charset=\"utf-8\"";
	_contentTransferEncoding = @"quoted-printable";
	_from = @"Wasik Mursalin <Wasik@ciphr.io>";
	_to = @"Wasik@ciphr.io";
	_date = [dateFormatter dateFromString:@"Fri, 12 Jan 2018 21:03:18 GMT"];
	_mimeVersion = @"1.0";
	_messageId = @"658879ec-4cda-4e8a-8cbd-43f85d70f962";
	_contentLanguage = @"en-US";
	_subject = @"Greetings from MBLSFT";
	
	_body = @"-----BEGIN PGP MESSAGE-----\nVersion: Ciphr 1.1\nhHUDaSbuuUNaIQJmAcDq7aAX5iDh38LE9Y6BIPDeAAPxT894mM8X2pOVXIMs/pd/ODt/1YqYoeO=\nBawh1wsbwvk18h3ryNDC65FJJbQwu5Su0aB3p3IcxmawpGBGRj7h/S6qh0dynC7SwaQ8yMwpK+/B=\nullUD09+EdQMIfJJFZMvBTmYBv3/56IX69CAzjzYXzVVWoLZmRhsYkm05tf9jQJdthHqEEZgR3+S=\nHqPc1hCVJU0Fs7HNW+GOHLDNNMBd3svxkklQG++MbipsWU4bEydfdvM3DiaBMdVpkTdU5VNGHepE=\nQTV0FFpQy07NSctLApQFRNxpMi9O6Pb1E63Xqc3+GJT+dSyp4Qo7Pfmae+0/CxpVSOe21pipKsNz=\nwgFOBEq7w/iG3dc0KcVkMEnr4PS4cEL73RoMWzRmLjnamXh7oO9KzqcWEipmcWrUryMgdN2HkT/7=\nTZRQkuduyMj0iwC3Il/Q9JUcQRv9Y9CzPHB3JwjK4Hb0wwD6sRprgMEzSBusPFZlHmL8DVgzf442=\nLgOdue7lxWvnIg3EF3sM4HfYXa/FYc84r5tT7rM7bh9u+WIC0k3fyd/axQ4JUXn7WaRaBoud2sXz=\nXmfHifZ5YhRJUo8w96z1YivV0wN2/jkBpoPf9+pIGOMP2BMBDg8q47h5O20m/vl7mVTO3vleF0oh=\nC6mZZXj4x6rqRzCPmu+bBTGkoCySpsziC9zb8qLVVs2t5JKGpl3lh2QOrS1uOkDmk0ARaBivSCAa=\nz7x2mkTVKdJXCyAX6yL1dQ++lk7vSZigKHePjPw=3D=3D=3D4/7k\n-----END PGP MESSAGE-----";
	
	_mimeMessage = @"Content-Type: text/plain; charset=\"utf-8\"\nContent-Transfer-Encoding: quoted-printable\nFrom: Wasik Mursalin <Wasik@ciphr.io>\nTo: Wasik@ciphr.io\nDate: Fri, 12 Jan 2018 21:03:18 GMT\nMime-Version: 1.0\nMessage-ID: 658879ec-4cda-4e8a-8cbd-43f85d70f962\nContent-Language: en-US\nSubject: Greetings from MBLSFT\n\n-----BEGIN PGP MESSAGE-----\nVersion: Ciphr 1.1\nhHUDaSbuuUNaIQJmAcDq7aAX5iDh38LE9Y6BIPDeAAPxT894mM8X2pOVXIMs/pd/ODt/1YqYoeO=\nBawh1wsbwvk18h3ryNDC65FJJbQwu5Su0aB3p3IcxmawpGBGRj7h/S6qh0dynC7SwaQ8yMwpK+/B=\nullUD09+EdQMIfJJFZMvBTmYBv3/56IX69CAzjzYXzVVWoLZmRhsYkm05tf9jQJdthHqEEZgR3+S=\nHqPc1hCVJU0Fs7HNW+GOHLDNNMBd3svxkklQG++MbipsWU4bEydfdvM3DiaBMdVpkTdU5VNGHepE=\nQTV0FFpQy07NSctLApQFRNxpMi9O6Pb1E63Xqc3+GJT+dSyp4Qo7Pfmae+0/CxpVSOe21pipKsNz=\nwgFOBEq7w/iG3dc0KcVkMEnr4PS4cEL73RoMWzRmLjnamXh7oO9KzqcWEipmcWrUryMgdN2HkT/7=\nTZRQkuduyMj0iwC3Il/Q9JUcQRv9Y9CzPHB3JwjK4Hb0wwD6sRprgMEzSBusPFZlHmL8DVgzf442=\nLgOdue7lxWvnIg3EF3sM4HfYXa/FYc84r5tT7rM7bh9u+WIC0k3fyd/axQ4JUXn7WaRaBoud2sXz=\nXmfHifZ5YhRJUo8w96z1YivV0wN2/jkBpoPf9+pIGOMP2BMBDg8q47h5O20m/vl7mVTO3vleF0oh=\nC6mZZXj4x6rqRzCPmu+bBTGkoCySpsziC9zb8qLVVs2t5JKGpl3lh2QOrS1uOkDmk0ARaBivSCAa=\nz7x2mkTVKdJXCyAX6yL1dQ++lk7vSZigKHePjPw=3D=3D=3D4/7k\n-----END PGP MESSAGE-----";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParsing {
	Mimetic *mimetic = [[Mimetic alloc] initWithMime:[_mimeMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	XCTAssertTrue([mimetic.contentType isEqualToString:_contentType]);
	XCTAssertTrue([mimetic.contentTransferEncoding isEqualToString:_contentTransferEncoding]);
	XCTAssertTrue([mimetic.from isEqualToString:_from]);
	XCTAssertTrue([mimetic.to isEqualToString:_to]);
	XCTAssertTrue([mimetic.date isEqualToDate:_date]);
	XCTAssertTrue([mimetic.version isEqualToString:_mimeVersion]);
	XCTAssertTrue([mimetic.messageId isEqualToString:_messageId]);
	XCTAssertTrue([mimetic.contentLanguage isEqualToString:_contentLanguage]);
	XCTAssertTrue([mimetic.subject isEqualToString:_subject]);
	XCTAssertTrue([mimetic.body isEqualToString:_body]);
}

- (void)testMimeBuilding {
	Mimetic *mimetic = [[Mimetic alloc] init];
	
	[mimetic setContentType:_contentType];
	[mimetic setContentTransferEncoding:_contentTransferEncoding];
	[mimetic setFrom:_from];
	[mimetic setTo:_to];
	[mimetic setDate:_date];
	[mimetic setVersion:_mimeVersion];
	[mimetic setMessageId:_messageId];
	[mimetic setContentLanguage:_contentLanguage];
	[mimetic setSubject:_subject];
	[mimetic setBody:_body];

	XCTAssertTrue([mimetic hasField:@"Content-Type"]);
	XCTAssertTrue([mimetic hasField:@"Content-Transfer-Encoding"]);
	XCTAssertTrue([mimetic hasField:@"From"]);
	XCTAssertTrue([mimetic hasField:@"To"]);
	XCTAssertTrue([mimetic hasField:@"Date"]);
	XCTAssertTrue([mimetic hasField:@"Mime-Version"]);
	XCTAssertTrue([mimetic hasField:@"Message-ID"]);
	XCTAssertTrue([mimetic hasField:@"Content-Language"]);
	XCTAssertTrue([mimetic hasField:@"Subject"]);
	
	XCTAssertNotNil([mimetic mime]);
}

@end
