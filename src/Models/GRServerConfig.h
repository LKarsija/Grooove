#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GRServerConfig : NSObject

@property (nonatomic, strong) NSURL *serverURL;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *apiVersion;
@property (nonatomic, copy) NSString *clientName;

- (instancetype)initWithServerURL:(NSURL *)serverURL
                         username:(NSString *)username
                         password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
