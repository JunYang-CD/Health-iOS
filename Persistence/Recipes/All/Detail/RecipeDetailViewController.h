//
//  RecipeDetailViewController.h
//  Persistence
//
//  Created by Jerry Yang on 10/18/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeDetailViewController : UIViewController<UIWebViewDelegate, UIPopoverPresentationControllerDelegate>

-(void) setData:(Recipe *) recipeCategory;
@end
