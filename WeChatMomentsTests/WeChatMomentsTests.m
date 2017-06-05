//
//  WeChatMomentsTests.m
//  WeChatMomentsTests
//
//  Created by Owen on 2017/6/3.
//  Copyright © 2017年 Owen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>

#import "QBCache.h"
NSString *kImageTestKey = @"TestImageKey.jpg";

@interface WeChatMomentsTests : XCTestCase

@property (strong, nonatomic) QBCache *sharedCache;
@end

@implementation WeChatMomentsTests

- (void)setUp {
    [super setUp];
    self.sharedCache = [QBCache sharedCache];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}
- (void)test01SharedCache {
    expect(self.sharedCache).toNot.beNil();
}
- (void)test02Singleton{
    expect(self.sharedCache).to.equal([QBCache sharedCache]);
}
- (void)test03QBCacheCanBeInstantiated {
    QBCache *cache = [[QBCache alloc] init];
    expect(cache).toNot.equal([QBCache sharedCache]);
}

- (void)test04ClearQBCache{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Clear disk cache"];
    [self.sharedCache setObject:[self imageForTesting] withImageData:[self imageDataForTesting] forKey:kImageTestKey];
    
    [self.sharedCache removeAllObjectsWithBlock:^{
        [self.sharedCache containsObjectForKey:kImageTestKey withBlock:^(NSString *key, BOOL contains) {
            if (!contains) {
                [expectation fulfill];
            } else {
                XCTFail(@"Image should not be in cache");
            }
        }];
    }];
    [self waitForExpectationsWithTimeout:2 handler:nil];
}
- (void)test06InsertionOfImage {
    XCTestExpectation *expectation = [self expectationWithDescription:@"storeImage forKey"];
    
    UIImage *image = [self imageForTesting];
    NSData *imageData = [self imageDataForTesting];
    [self.sharedCache setObject:image withImageData:imageData forKey:kImageTestKey];
    expect([self.sharedCache.memoryCache objectForKey:kImageTestKey]).to.equal(image);
    
    [self.sharedCache.diskCache  containsObjectForKey:kImageTestKey withBlock:^(NSString *key, BOOL contains) {
        
        if (contains) {
            [expectation fulfill];
        } else {
            XCTFail(@"Image should be in cache");
        }
    }];
    [self waitForExpectationsWithTimeout:2 handler:nil];
    
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (UIImage *)imageForTesting{
    static UIImage *reusableImage = nil;
    if (!reusableImage) {
        reusableImage = [UIImage imageWithContentsOfFile:[self testImagePath]];
    }
    return reusableImage;
}

- (NSData *)imageDataForTesting{
    static NSData *reusableData = nil;
    if (!reusableData) {
        reusableData = [NSData dataWithContentsOfFile:[self testImagePath]];
    }
    return reusableData;
}

- (NSString *)testImagePath {
    
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    return [testBundle pathForResource:@"TestImage" ofType:@"jpg"];
}
@end
