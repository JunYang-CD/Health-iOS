//
//  RecipesViewController.h
//  Persistence
//
//  Created by Jerry Yang on 9/28/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeCategoryTableViewController.h"
#import "RecipeTableViewDelegateImpl.h"

@interface RecipesViewController : UIViewController<RecipeTableViewDelegateImplDeleate, SelectedCategory, UITextFieldDelegate>

@end
