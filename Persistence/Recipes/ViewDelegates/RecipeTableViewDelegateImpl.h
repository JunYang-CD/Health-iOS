//
//  RecipeTableView.h
//  Persistence
//
//  Created by Jerry Yang on 10/21/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import <Foundation/Foundation.h>

@protocol RecipeTableViewDelegateImplDeleate

-(void) showRecipeDetail:(Recipe *) recipe;
-(void) loadMoreRecipe:(NSInteger) pageIndex;

@end


@interface RecipeTableViewDelegateImpl : NSObject<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) NSArray<Recipe *> *recipes;
@property(nonatomic) NSInteger pageIndex;
@property(nonatomic) id<RecipeTableViewDelegateImplDeleate> controllerDelegate;
@property(nonatomic) BOOL autoLoadMore;

-(instancetype) initWithData:(NSArray<Recipe *> *) recipes pageIndex:(NSInteger)pageIndex;

@end