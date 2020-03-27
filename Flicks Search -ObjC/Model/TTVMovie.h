//
//  TTVMovie.h
//  Flicks Search -ObjC
//
//  Created by theevo on 3/27/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTVMovie : NSObject

@property (nonatomic, readonly) NSString * title;
@property (nonatomic, readonly) NSNumber * rating;
@property (nonatomic, readonly) NSString * movieDescription;
@property (nonatomic, readonly, nullable) NSString * posterPath;

-(instancetype)initWithTitle:(NSString *)title
                      rating:(NSNumber *)rating
            movieDescription:(NSString *)movieDescription
                  posterPath:(NSString *)posterPath;

@end


@interface TTVMovie (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
