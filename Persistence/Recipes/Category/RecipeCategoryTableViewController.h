//
//  RecipeCategoryTableViewController.h
//  Persistence
//
//  Created by Jerry Yang on 10/11/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeModel.h"
#import "RecipeCategoryViewModel.h"
#import "RecipeCategory.h"

@protocol SelectedCategory <NSObject>
@required
-(void) setSelectedCategories:(NSArray<RecipeCategory *> *) selectedCategories;

@end

@interface RecipeCategoryTableViewController : UITableViewController

@property (nonatomic, readonly) RecipeCategoryViewModel *categoryViewModel;
@property id<SelectedCategory> delegate;
@property (weak, nonatomic) NSArray<RecipeCategory *> *checkedCategories;

@end
