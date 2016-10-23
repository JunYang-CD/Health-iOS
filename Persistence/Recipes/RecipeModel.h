//
//  RecipeManager.h
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"
#import "RecipeCategory.h"

@protocol RecipeFetcher

-(BOOL) getRecipeCategories: (NSString*)categoryID withSuccess:(void (^)(NSDictionary *data))successBlock withError: (void (^)(NSError *error))errorBlock;
-(BOOL) getRecipeListByCategory: (NSString*)categoryID pageIndex:(NSInteger) pageIndex withSuccess: (void (^)(NSDictionary *data))successBlock withError: (void (^)(NSError *error))errorBlock;
-(BOOL) getRecipeByName: (NSString*) recipeName withSuccess: (void (^)(NSDictionary *data))successBlock withError: (void (^)(NSError *error))errorBlock;
-(BOOL) getRecipeByID: (NSString*)recipeID withSuccess: (void (^)(NSDictionary *data))successBlock withError: (void (^)(NSError *error))errorBlock;

@end


extern NSString *const RecipeModelRecipeUpdate;
extern NSString *const RecipeModelRecipeListUpdate;
extern NSString *const RecipeModelRecipeCategoryUpdate;
extern NSString *const RecipeModelRecipeSubCategoryUpdate;
extern NSString *const RecipeModelRecipeFavUpdate;

@protocol PSServer;

@interface RecipeModel : NSObject


+(instancetype) instance;

@property (nonatomic) id<PSServer> psServer;
//@property (nonatomic, readonly) Recipe* recipe;

-(void) getCategories: (NSString*) categoryID;
-(void) getListByCategory: (NSString*) categoryID pageIndex:(NSInteger)pageIndex;
-(void) getByName: (NSString*) name;
-(void) getByID: (NSString*) ID;

-(void) persistentRecipeCategories:(NSArray<RecipeCategory *> *) recipeCategories;
-(void) persistentRecipeCategory: (RecipeCategory* )recipeCategory;
-(NSArray<RecipeCategory*> *) getPersistentRecipeCategories:(NSString *)cookclass;

-(void) persistentFavRecipe: (Recipe *)recipe;
-(NSArray<Recipe *> *) getPersistentFavRecipes;
-(void) removeFavRecipe: (Recipe *)recipe;
-(BOOL) isRecipeFav: (NSString *)recipeID;


@end
