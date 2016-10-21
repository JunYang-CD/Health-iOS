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
#import "RecipeDetailMoreViewController.h"

@interface RecipeDetailViewController ()

@property(nonatomic, readonly) Recipe *recipe;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UIWebView *recipeWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *recipeDetailLoadIndicator;

@end

@implementation RecipeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(_recipe){
        [self.recipeImageView sd_setImageWithURL:[NSURL URLWithString:_recipe.imageUrl] placeholderImage:[UIImage imageNamed:@"main-dishes"]];
    }
    UIBarButtonItem *topRightbtn = [[UIBarButtonItem alloc]
                                    initWithTitle:@"More"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(moreActionTriggered)];
    self.navigationItem.rightBarButtonItem = topRightbtn;
    
}


-(void) moreActionTriggered{
    [self performSegueWithIdentifier:@"recipeShowMore" sender:self];
}

-(void)setData:(Recipe *)recipe{
    if(recipe){
        _recipe = recipe;
        self.title = recipe.name;
        [self registerNotificationObserver];
        [[RecipeModel instance] getByID:_recipe.ID];
    }
}

-(void) registerNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRecipe:) name: RecipeModelRecipeUpdate object:nil];
}

-(void)refreshRecipe:(NSNotification *) notification{
    Recipe *recipe = notification.userInfo[@"recipeObj"];
    [_recipeWebView setDelegate:self];
    [_recipeWebView loadHTMLString:recipe.steps baseURL:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.recipeDetailLoadIndicator stopAnimating];
}


#pragma mark - Navigation

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"recipeShowMore"]){
        RecipeDetailMoreViewController *popController = [segue destinationViewController];
        popController.modalPresentationStyle = UIModalPresentationPopover;
        [popController.popoverPresentationController setDelegate:self];
        [popController setRecipe:self.recipe];
    }
    
    
}


@end
