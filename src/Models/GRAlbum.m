#import "GRAlbum.h"

@implementation GRAlbum

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _albumId = dictionary[@"id"];
        _name = dictionary[@"name"];
        _artist = dictionary[@"artist"];
        _artistId = dictionary[@"artistId"];
        _coverArt = dictionary[@"coverArt"];
        _songCount = [dictionary[@"songCount"] integerValue];
        _duration = [dictionary[@"duration"] integerValue];
        _year = [dictionary[@"year"] integerValue];
    }
    return self;
}

@end
