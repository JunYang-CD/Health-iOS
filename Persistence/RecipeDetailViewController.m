//
//  RecipeDetailViewController.m
//  Persistence
//
//  Created by Jerry Yang on 10/18/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RecipeModel.h"

@interface RecipeDetailViewController ()

@property(nonatomic, readonly) Recipe *recipe;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UIWebView *recipeWebView;

@end

@implementation RecipeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(_recipe){
        [_recipeImageView sd_setImageWithURL:[NSURL URLWithString:_recipe.imageUrl] placeholderImage:[UIImage imageNamed:@"first"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setData:(Recipe *)recipe{
    if(recipe){
        _recipe = recipe;
        self.title = recipe.name;
        [self registerNotificationObserver];
        [[RecipeModel instance] getByID:recipe.ID];
    }
    //    [_recipeWebView loadHTMLString:recipe.steps baseURL:nil];
    
}

-(void) registerNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRecipe:) name: RecipeModelRecipeUpdate object:nil];
}

-(void)refreshRecipe:(NSNotification *) notification{
    Recipe *recipe = notification.userInfo[@"recipeObj"];
    _recipe = recipe;
    [_recipeWebView loadHTMLString:recipe.steps baseURL:nil];

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
