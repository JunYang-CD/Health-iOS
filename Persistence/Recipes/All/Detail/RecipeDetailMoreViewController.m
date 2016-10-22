//
//  ViewController.m
//  Persistence
//
//  Created by Jerry Yang on 10/21/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeDetailMoreViewController.h"
#import "RecipeModel.h"

@interface RecipeDetailMoreViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *addIconVIew;
@property (weak, nonatomic) IBOutlet UILabel *addTextView;
@property (weak, nonatomic) IBOutlet UIImageView *shareIconView;
@property (weak, nonatomic) IBOutlet UILabel *shareTextView;

@end

@implementation RecipeDetailMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGestures];
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    // Dispose of any resources that can be recreated.
}

-(void) addGestures{
    UITapGestureRecognizer *addFavGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFavRecipe)];
    UITapGestureRecognizer *shareRecipeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareRecipe)];
    
    [self.addIconVIew addGestureRecognizer:addFavGesture];
    [self.addTextView addGestureRecognizer:addFavGesture];
    [self.shareIconView addGestureRecognizer:shareRecipeGesture];
    [self.shareIconView addGestureRecognizer:shareRecipeGesture];

}

-(void) addFavRecipe{
    NSLog(@"add fav recipe");
    [[RecipeModel instance] persistentFavRecipe:self.recipe];
    
}

-(void) shareRecipe{
    NSLog(@"share recipe");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
