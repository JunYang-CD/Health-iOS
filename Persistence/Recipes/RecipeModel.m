//
//  RecipeManager.m
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeModel.h"
#import "PSServerRegistry.h"
#import <Realm/RLMRealm.h>
#import <Realm/RLMResults.h>

@implementation RecipeModel

NSString *const RecipeModelRecipeUpdate = @"RecipeModelRecipeUpdate";
NSString *const RecipeModelRecipeListUpdate = @"RecipeModelRecipeListUpdate";
NSString *const RecipeModelRecipeCategoryUpdate = @"RecipeModelRecipeCategoryUpdate";
NSString *const RecipeModelRecipeSubCategoryUpdate = @"RecipeModelRecipeSubCategoryUpdate";
NSString *const RecipeModelRecipeFavUpdate = @"RecipeModelRecipeFavUpdate";

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
        NSError *error;
        RecipeResponseModel *recipes = [MTLJSONAdapter modelOfClass:RecipeResponseModel.class fromJSONDictionary: data error:&error];
        [[NSNotificationCenter defaultCenter] postNotificationName:RecipeModelRecipeListUpdate object:self userInfo:@{@"recipeName": name, @"recipeObj": recipes.recipes}];
        
    } withError:^(NSError* error){}];
    
}

-(void)getCategories:(NSString*)categoryID{
    
    NSString *cookClass = categoryID;
    NSString* notificatioName = nil;
    NSString* ID = nil;
    if(!categoryID){
        notificatioName = RecipeModelRecipeCategoryUpdate;
        cookClass = @"0";
        ID = @"-1";
    }else{
        notificatioName = RecipeModelRecipeSubCategoryUpdate;
        ID = categoryID;
    }
    
    NSArray<RecipeCategory *> *recipeCategories = [self getPersistentRecipeCategories:cookClass];
    if(recipeCategories && [recipeCategories count] > 0){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notificatioName object:self userInfo:@{@"categoryID": ID, @"categoryObj": recipeCategories}];
    }else{
        
        [self.psServer getRecipeCategories:categoryID withSuccess:^(NSDictionary *data) {
            NSLog(@"%@", data[@"tngou"][0][@"keywords"]);
            NSError *error;
            @synchronized (self) {
                RecipeCategoryResponseModel *recipeCategories = [MTLJSONAdapter modelOfClass:RecipeCategoryResponseModel.class fromJSONDictionary:data error:&error];
                
                [self persistentRecipeCategories:recipeCategories.recipeCategories];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:notificatioName object:self userInfo:@{@"categoryID": ID, @"categoryObj": recipeCategories.recipeCategories}];
            }
            
        } withError:^(NSError *error) {}];
    }
}

-(void)getListByCategory:(NSString *)categoryID pageIndex:(NSInteger)pageIndex{
    [self. psServer getRecipeListByCategory:categoryID pageIndex:pageIndex withSuccess:^(NSDictionary *data) {
        NSError *error;
        RecipeResponseModel *recipes = [MTLJSONAdapter modelOfClass:RecipeResponseModel.class fromJSONDictionary: data error:&error];
        NSString* ID = nil;
        NSString* notificatioName = nil;
        if(!categoryID){
            ID = @"-1";
        }else{
            ID = categoryID;
        }
        
        if(recipes.recipes){
            [self persistentRecipes:recipes.recipes];
            [[NSNotificationCenter defaultCenter] postNotificationName:RecipeModelRecipeListUpdate object:self userInfo:@{@"categoryID": ID, @"recipeObj": recipes.recipes}];
        }
        
        
    } withError:^(NSError *error) {}];
    
}

-(void) persistentRecipeCategories:(NSArray<RecipeCategory *> *) recipeCategories{
    if(recipeCategories){
        for(RecipeCategory* recipeCategory in recipeCategories){
            [self persistentRecipeCategory: recipeCategory];
        }
    }
}

-(void) persistentRecipeCategory: (RecipeCategory* )recipeCategory{
    RLMRealm *realm = [RLMRealm defaultRealm];
    RecipeCategoryRealmObject *recipeCategoryRO = [[RecipeCategoryRealmObject new] initWithMantleModel:recipeCategory];
    [realm beginWriteTransaction];
    [realm addObject:recipeCategoryRO];
    [realm commitWriteTransaction];
    
}

-(NSArray<RecipeCategory *> *)getPersistentRecipeCategories:(NSString *)cookclass{
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"cookclass = %@", cookclass];
    RLMResults<RecipeCategoryRealmObject*> *recipeCategoriesRO = [RecipeCategoryRealmObject objectsWithPredicate:pred];
    NSMutableArray<RecipeCategory *> * recipeCategories = [NSMutableArray new];
    for(RecipeCategoryRealmObject* recipeCategoryRO in recipeCategoriesRO){
        RecipeCategory* recipeCategory = recipeCategoryRO.recipeCategory;
        [recipeCategories addObject:recipeCategory];
    }
    return [recipeCategories copy];
    
}


-(void) persistentRecipes:(NSArray<Recipe *> *) recipes{
    if(recipes){
        for(Recipe *recipe in recipes){
            [self persistentRecipe:recipe];
        }
    }
}


-(void) persistentRecipe: (Recipe *) recipe{
    RLMRealm *realm = [RLMRealm defaultRealm];
    RecipeRealmObject *recipeRO = [[RecipeRealmObject new] initWithData:recipe];
    [realm beginWriteTransaction];
    [realm addObject:recipeRO];
    [realm commitWriteTransaction];
}

-(void) persistentFavRecipe: (Recipe *) recipe{
    RLMRealm *realm = [RLMRealm defaultRealm];
    RecipeFavRealmObject *recipeFavRO = [[RecipeFavRealmObject new] initWithData:recipe];
    [realm beginWriteTransaction];
    [realm addObject:recipeFavRO];
    [realm commitWriteTransaction];
}


-(NSArray<Recipe *> *) getPersistentFavRecipes{
    RLMResults<RecipeFavRealmObject *> *favRecipes = [RecipeFavRealmObject allObjects];
    NSMutableArray<Recipe *> *recipes = [NSMutableArray new];
    for(RecipeFavRealmObject *recipeFavRealmObj in favRecipes){
        [recipes addObject:recipeFavRealmObj.recipeObj];
    }
    return [recipes copy];
}

@end
