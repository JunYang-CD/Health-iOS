//
//  RecipeCategoryViewModel.h
//  Persistence
//
//  Created by Jerry Yang on 10/11/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeCategory.h"

@interface Category : NSObject

@property (nonatomic, readonly) BOOL collapse;
@property (nonatomic, readonly) RecipeCategory* rootCategory;
@property (nonatomic, readonly) NSArray<RecipeCategory *> *subCategories;

-(instancetype) initWithRecipeCategory: (RecipeCategory *) rootCategory subCategories: (NSArray<RecipeCategory *> *)subCategories;
-(void) updateCollapseStatus;
-(BOOL) shouldSectionCollapsed;

@end


@interface RecipeCategoryViewModel : NSObject

@property (nonatomic, readonly) NSArray<Category *> *categories;

@property (nonatomic, readonly) NSInteger sectionCount;

-(instancetype) initWithCategories: (NSArray<Category *> *) categories;
-(NSArray<RecipeCategory *> *) getSubCategories : (NSInteger) categoryIndex;

@end
