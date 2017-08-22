//
//  APINetworkConfig.m
//


#import "APINetworkConfig.h"
#import "AFNetworking.h"

@implementation APINetworkConfig {
    NSMutableArray *_urlFilters;
    NSMutableArray *_cacheDirPathFilters;
}

+ (APINetworkConfig *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _urlFilters = [NSMutableArray array];
        _cacheDirPathFilters = [NSMutableArray array];
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
    }
    return self;
}

- (void)addUrlFilter:(id<APIUrlFilterProtocol>)filter {
    [_urlFilters addObject:filter];
}

- (void)addCacheDirPathFilter:(id<APICacheDirPathFilterProtocol>)filter {
    [_cacheDirPathFilters addObject:filter];
}

- (NSArray *)urlFilters {
    return [_urlFilters copy];
}

- (NSArray *)cacheDirPathFilters {
    return [_cacheDirPathFilters copy];
}

@end
