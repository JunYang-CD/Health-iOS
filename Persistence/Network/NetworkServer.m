//
//  ApiRequest.m
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "NetworkServer.h"
#import "Api.h"

@implementation NetworkServer

+(instancetype)networkServer {
    return [[self alloc] initWithManager:nil];
}

-(instancetype)initWithManager:(AFURLSessionManager*)sessionManager{
    self = [super init];
    
    if(!self){
        return nil;
    }
    if(sessionManager){
        _manager = sessionManager;
    }else{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
    
}

-(BOOL)getRecipeByID:(NSString *)recipeID withSuccess: (void (^)(NSDictionary *data))successBlock withError: (void (^)(NSError *error))errorBlock{
    NSMutableString *api = [NSMutableString stringWithString:RecipeByID];
    NSString *parameter = [NSString stringWithFormat:@"?id=%@", recipeID];
    [api appendString:parameter];
    
    NSURL *url = [NSURL URLWithString:api];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            if([responseObject isKindOfClass:[NSDictionary class]]){
                successBlock(responseObject);
            }
        }
    }];
    [dataTask resume];
    return true;
}

-(BOOL)getRecipeByName:(NSString *)recipeName withSuccess: (void (^)(NSDictionary *data))successBlock withError: (void (^)(NSError *error))errorBlock{
    NSMutableString *api = [NSMutableString stringWithString:RecipeByName];
    NSString *parameter = [NSString stringWithFormat:@"?name=%@", recipeName];
    
    [api appendString:parameter];
    api = [api stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:api];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            if([responseObject isKindOfClass:[NSDictionary class]]){
                successBlock(responseObject);
            }
        }
    }];
    [dataTask resume];
    return true;
}

-(BOOL)getRecipeCategories: (NSString*)categoryID withSuccess:(void (^)(NSDictionary *data))successBlock withError: (void (^)(NSError *error))errorBlock{
    NSMutableString *api = [NSMutableString stringWithString:RecipeCategories];
    if(categoryID){
        NSString *parameter = [NSString stringWithFormat:@"?id=%@", categoryID];
        [api appendString:parameter];
    }
    
    NSURL *url = [NSURL URLWithString:api];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            if([responseObject isKindOfClass:[NSDictionary class]]){
                successBlock(responseObject);
            }
        }
    }];
    [dataTask resume];
    return true;
}

-(BOOL)getRecipeListByCategory:(NSString *)categoryID pageIndex:(NSInteger) pageIndex withSuccess: (void (^)(NSDictionary *data))successBlock withError: (void (^)(NSError *error))errorBlock{
    NSMutableString *api = [NSMutableString stringWithString:RecipeListByCategory];
    NSString *parameter = [NSString stringWithFormat:@"?id=%@&page=%ld", categoryID, (long)pageIndex];
    [api appendString:parameter];
    
    NSURL *url = [NSURL URLWithString:api];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            if([responseObject isKindOfClass:[NSDictionary class]]){
                successBlock(responseObject);
            }
        }
    }];
    [dataTask resume];
    return true;
}

@end
