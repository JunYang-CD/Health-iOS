//
//  RecipeDetailViewController.h
//  Persistence
//
//  Created by Jerry Yang on 10/18/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "RecipeDetailMoreViewController.h"

@interface RecipeDetailViewController : UIViewController<UIWebViewDelegate, UIPopoverPresentationControllerDelegate, ToastDeletage>

-(void) setData:(Recipe *) recipeCategory;
@end
