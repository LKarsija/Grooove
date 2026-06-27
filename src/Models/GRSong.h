#import <Foundation/Foundation.h>

@interface GRSong : NSObject

@property (nonatomic, copy) NSString *songId;
@property (nonatomic, copy) NSString *albumId;
@property (nonatomic, copy) NSString *artistId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, assign) NSInteger track;
@property (nonatomic, assign) NSInteger discNumber;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, copy) NSString *coverArt;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *suffix;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
