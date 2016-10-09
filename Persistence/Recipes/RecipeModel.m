//
//  RecipeManager.m
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeModel.h"
#import "PSServerRegistry.h"

@implementation RecipeModel


+(instancetype)instance{
    static RecipeModel *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [RecipeModel new];
        
    });
    _instance->_psServer = [PSServerRegistry createServerWithStubEnabled:false];
    return _instance;
}

-(void)getByID:(NSString *)ID{
    [self.psServer getRecipeByID: ID withSuccess:^(NSDictionary* data){
        NSLog(@"%@", data[@"description"]);
    } withError:^(NSError* error){}];
    
}

-(void)getByName:(NSString *)name{
    [self.psServer getRecipeByName:name withSuccess:^(NSDictionary* data){
        NSLog(@"%@", data[@"tngou"][0][@"food"]);
    } withError:^(NSError* error){}];
    
}

-(void)getCategories:(NSString*)categoryID{
    [self.psServer getRecipeCategories:categoryID withSuccess:^(NSDictionary *data) {
        NSLog(@"%@", data[@"tngou"][0][@"keywords"]);
    } withError:^(NSError *error) {
        
    }];
}

-(void)getListByCategory:(NSString *)categoryID{
    [self. psServer getRecipeListByCategory:categoryID withSuccess:^(NSDictionary *data) {
        NSLog(@"%@", data[@"tngou"][0][@"keywords"]);
        
    } withError:^(NSError *error) {
        
    }];
    
}

@end
