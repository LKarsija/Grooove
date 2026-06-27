#import "GRSong.h"

@implementation GRSong

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _songId = dictionary[@"id"];
        _albumId = dictionary[@"albumId"];
        _artistId = dictionary[@"artistId"];
        _title = dictionary[@"title"];
        _album = dictionary[@"album"];
        _artist = dictionary[@"artist"];
        _track = [dictionary[@"track"] integerValue];
        _discNumber = [dictionary[@"discNumber"] integerValue];
        _duration = [dictionary[@"duration"] integerValue];
        _coverArt = dictionary[@"coverArt"];
        _contentType = dictionary[@"contentType"];
        _suffix = dictionary[@"suffix"];
    }
    return self;
}

@end
