//
//  TTVMovieController.h
//  Flicks Search -ObjC
//
//  Created by theevo on 3/27/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TTVMovie;

@interface TTVMovieController : NSObject

+(void) fetchMoviesWithString:(NSString *)searchTerm
                   completion:(void(^)(NSArray<TTVMovie *> *_Nullable))completion;

+(void) fetchMoviePosterForMovie:(TTVMovie *)movie
                      completion:(void(^)(UIImage *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
