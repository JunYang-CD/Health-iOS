//
//  RecipesViewController.h
//  Persistence
//
//  Created by Jerry Yang on 9/28/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeCategoryTableViewController.h"

@interface RecipesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, SelectedCategory>
- (void)refreshRecipes;

@end
