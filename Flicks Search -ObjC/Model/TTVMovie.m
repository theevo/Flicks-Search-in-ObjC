//
//  TTVMovie.m
//  Flicks Search -ObjC
//
//  Created by theevo on 3/27/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

#import "TTVMovie.h"

@implementation TTVMovie

-(instancetype)initWithTitle:(NSString *)title
                      rating:(NSNumber *)rating
            movieDescription:(NSString *)movieDescription
                  posterPath:(NSString *)posterPath
{
    self = [super init];
    if (self)
    {
        _title = title;
        _rating = rating;
        _movieDescription = movieDescription;
        _posterPath = posterPath;
    }
    return self;
}

@end


@implementation TTVMovie (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSNumber *rating = dictionary[@"vote_average"];
    NSString *movieDescription = dictionary[@"overview"];
    NSString *posterPath = nil;
    
    if ( [dictionary[@"poster_path"] isKindOfClass:[NSString class]] ) {
        posterPath = dictionary[@"poster_path"];
    }
    
    return [self initWithTitle:title rating:rating movieDescription:movieDescription posterPath:posterPath];
}

@end
