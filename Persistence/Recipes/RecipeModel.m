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

NSString *const RecipeModelRecipeUpdate = @"RecipeModelRecipeUpdate";
NSString *const RecipeModelRecipeListUpdate = @"RecipeModelRecipeListUpdate";
NSString *const RecipeModelRecipeCategoryUpdate = @"RecipeModelRecipeCategoryUpdate";

+(instancetype)instance{
    static RecipeModel *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [RecipeModel new];
        _instance->_psServer = [PSServerRegistry createServerWithStubEnabled:false];

    });
    return _instance;
}

-(void)getByID:(NSString *)ID{
    [self.psServer getRecipeByID: ID withSuccess:^(NSDictionary* data){
        NSLog(@"%@", data[@"description"]);
        NSError *error;
        _recipe = [MTLJSONAdapter modelOfClass:Recipe.class fromJSONDictionary:data error:&error];
        [[NSNotificationCenter defaultCenter] postNotificationName:RecipeModelRecipeUpdate object:self];
        
    } withError:^(NSError* error){}];
    
}

-(void)getByName:(NSString *)name{
    [self.psServer getRecipeByName:name withSuccess:^(NSDictionary* data){
        NSLog(@"%@", data[@"tngou"][0][@"food"]);
        NSError *error;
        _recipes = [MTLJSONAdapter modelOfClass:RecipeResponseModel.class fromJSONDictionary: data error:&error];
        [[NSNotificationCenter defaultCenter] postNotificationName:RecipeModelRecipeListUpdate object:self];
        
    } withError:^(NSError* error){}];
    
}

-(void)getCategories:(NSString*)categoryID{
    [self.psServer getRecipeCategories:categoryID withSuccess:^(NSDictionary *data) {
        NSLog(@"%@", data[@"tngou"][0][@"keywords"]);
        NSError *error;
        _recipeCategories = [MTLJSONAdapter modelOfClass:RecipeCategoryResponseModel.class fromJSONDictionary:data error:&error];
        [[NSNotificationCenter defaultCenter] postNotificationName:RecipeModelRecipeCategoryUpdate object:self];
        
    } withError:^(NSError *error) {}];
}

-(void)getListByCategory:(NSString *)categoryID{
    [self. psServer getRecipeListByCategory:categoryID withSuccess:^(NSDictionary *data) {
        NSLog(@"%@", data[@"tngou"][0][@"keywords"]);
        NSError *error;
        _recipes = [MTLJSONAdapter modelOfClass:RecipeResponseModel.class fromJSONDictionary: data error:&error];
        [[NSNotificationCenter defaultCenter] postNotificationName:RecipeModelRecipeListUpdate object:self];
        
    } withError:^(NSError *error) {}];
    
}

@end
