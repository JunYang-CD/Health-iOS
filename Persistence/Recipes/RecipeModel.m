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
NSString *const RecipeModelRecipeSubCategoryUpdate = @"RecipeModelRecipeSubCategoryUpdate";

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
        Recipe *recipe = [MTLJSONAdapter modelOfClass:Recipe.class fromJSONDictionary:data error:&error];
        [[NSNotificationCenter defaultCenter] postNotificationName:RecipeModelRecipeUpdate object:self userInfo:@{@"recipeID": ID, @"recipeObj": recipe}];
        
    } withError:^(NSError* error){}];
    
}

-(void)getByName:(NSString *)name{
    [self.psServer getRecipeByName:name withSuccess:^(NSDictionary* data){
        NSLog(@"%@", data[@"tngou"][0][@"food"]);
        NSError *error;
        RecipeResponseModel *recipes = [MTLJSONAdapter modelOfClass:RecipeResponseModel.class fromJSONDictionary: data error:&error];
        [[NSNotificationCenter defaultCenter] postNotificationName:RecipeModelRecipeListUpdate object:self userInfo:@{@"recipeName": name, @"recipeObj": recipes.recipes}];
        
    } withError:^(NSError* error){}];
    
}

-(void)getCategories:(NSString*)categoryID{
    [self.psServer getRecipeCategories:categoryID withSuccess:^(NSDictionary *data) {
        NSLog(@"%@", data[@"tngou"][0][@"keywords"]);
        NSError *error;
        @synchronized (self) {
            NSString* ID = nil;
            NSString* notificatioName = nil;
            if(!categoryID){
                ID = @"-1";
                notificatioName = RecipeModelRecipeCategoryUpdate;
            }else{
                ID = categoryID;
                notificatioName = RecipeModelRecipeSubCategoryUpdate;
            }
            RecipeCategoryResponseModel *recipeCategories = [MTLJSONAdapter modelOfClass:RecipeCategoryResponseModel.class fromJSONDictionary:data error:&error];
            [[NSNotificationCenter defaultCenter] postNotificationName:notificatioName object:self userInfo:@{@"categoryID": ID, @"categoryObj": recipeCategories.recipeCategories}];
        }
        
    } withError:^(NSError *error) {}];
}

-(void)getListByCategory:(NSString *)categoryID{
    [self. psServer getRecipeListByCategory:categoryID withSuccess:^(NSDictionary *data) {
        NSLog(@"%@", data[@"tngou"][0][@"keywords"]);
        NSError *error;
        RecipeResponseModel *recipes = [MTLJSONAdapter modelOfClass:RecipeResponseModel.class fromJSONDictionary: data error:&error];
        NSString* ID = nil;
        NSString* notificatioName = nil;
        if(!categoryID){
            ID = @"-1";
        }else{
            ID = categoryID;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:RecipeModelRecipeListUpdate object:self userInfo:@{@"categoryID": ID, @"categoryObj": recipes.recipes}];
        
    } withError:^(NSError *error) {}];
    
}

@end
