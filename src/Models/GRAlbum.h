#import <Foundation/Foundation.h>

@interface GRAlbum : NSObject

@property (nonatomic, copy) NSString *albumId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *artistId;
@property (nonatomic, copy) NSString *coverArt;
@property (nonatomic, assign) NSInteger songCount;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger year;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
