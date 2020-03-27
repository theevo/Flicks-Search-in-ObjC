//
//  TTVMovieController.m
//  Flicks Search -ObjC
//
//  Created by theevo on 3/27/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

#import "TTVMovieController.h"
#import "TTVMovie.h"

static NSString * const searchURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString * const posterURLString = @"https://image.tmdb.org/t/p/w500";
static NSString * const apiKeyTMDB = @"api_key";
static NSString * const apiValueTMDB = @"fca5a8c85d8154a8d7591cf4881ab8d1";
static NSString * const searchKeyTMDB = @"query";

@implementation TTVMovieController

+(void) fetchMoviesWithString:(NSString *)searchTerm completion:(void (^)(NSArray<TTVMovie *> * _Nullable))completion
{
    NSURL *searchURL = [NSURL URLWithString:searchURLString];
    
    NSURLQueryItem *apiQueryItem = [[NSURLQueryItem alloc] initWithName:searchKeyTMDB value:searchTerm];
    
    NSURLQueryItem *searchQueryItem = [[NSURLQueryItem alloc] initWithName:apiKeyTMDB value:apiValueTMDB];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    [queryItems addObject:apiQueryItem];
    [queryItems addObject:searchQueryItem];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:searchURL resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching posts: %@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error. No data was returned: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        
        NSArray *resultsArray = topLevelJSON[@"results"];
        
        NSMutableArray *moviesArray = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in resultsArray)
        {
            TTVMovie *movie = [[TTVMovie alloc] initWithDictionary:currentDictionary];
            [moviesArray addObject:movie];
        }
        
        completion(moviesArray);
        
    }] resume];
}

+(void) fetchMoviePosterForMovie:(TTVMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSString *posterPath = movie.posterPath;
    
    NSURL *posterURL = [[NSURL URLWithString:posterURLString] URLByAppendingPathComponent:posterPath];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:posterURL resolvingAgainstBaseURL:true];
    
    NSURL *finalURL = [urlComponents URL];
    
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error fetching posts: %@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error. No data was returned: %@", error);
            completion(nil);
            return;
        }
        
        UIImage *posterImage = [[UIImage alloc] initWithData:data];
                
        completion(posterImage);
        
    }] resume];
}

@end
