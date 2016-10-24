//
//  ViewController.h
//  Persistence
//
//  Created by Jerry Yang on 10/21/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@protocol ToastDeletage
- (void)showToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position;
@end

@interface RecipeDetailMoreViewController : UIViewController
@property (weak, nonatomic) Recipe *recipe;
@property (nonatomic) BOOL isFav;
@property id<ToastDeletage> toastDelegate;
@end
