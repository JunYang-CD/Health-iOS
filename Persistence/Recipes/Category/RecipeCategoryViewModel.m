//
//  RecipeCategoryViewModel.m
//  Persistence
//
//  Created by Jerry Yang on 10/11/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeCategoryViewModel.h"
@implementation Category

-(instancetype)initWithRecipeCategory:(RecipeCategory *)rootCategory subCategories:(NSArray<RecipeCategory *> *)subCategories{
    _rootCategory = rootCategory;
    _subCategories = subCategories;
    _collapse = true;
    return self;
}

-(void)updateCollapseStatus{
    _collapse = !_collapse;
}

-(BOOL)shouldSectionCollapsed{
    return _collapse;
}

@end

@implementation RecipeCategoryViewModel

-(instancetype)initWithCategories:(NSArray<Category *> *)categories{
    _categories = categories;
    return self;
}

-(NSInteger)sectionCount{
    if(_categories){
        return [_categories count];
    }
    return 0;
}

-(NSArray<RecipeCategory *> *)getSubCategories:(NSInteger)categoryIndex{
    if(self.categories && [self.categories count] >= categoryIndex){
        return self.categories[categoryIndex].subCategories;
    }
    return nil;
}
@end
