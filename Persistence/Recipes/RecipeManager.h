//
//  RecipeManager.h
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RecipeFetcher

-(NSString*) getRecipeCategories: (NSString*)categoryID;
-(NSString*) getRecipeListByCategory: (NSString*)categoryID;
-(NSString*) getRecipeByName: (NSString*) recipeName;
-(NSString*) getRecipeByID: (NSString*)recipeID;

@end

@interface RecipeManager : NSObject

@property (nonatomic, readonly) RecipeManager* recipeMangaer;

@end
