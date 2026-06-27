#import "GRServerConfig.h"

@implementation GRServerConfig

- (instancetype)initWithServerURL:(NSURL *)serverURL
                         username:(NSString *)username
                         password:(NSString *)password
{
    self = [super init];
    if (self) {
        _serverURL = serverURL;
        _username = [username copy];
        _password = [password copy];
        _apiVersion = @"1.16.1";
        _clientName = @"Grooove";
    }
    return self;
}

@end
