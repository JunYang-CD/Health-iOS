//
//  RecipeFavViewController.m
//  Persistence
//
//  Created by Jerry Yang on 10/22/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeFavViewController.h"
#import "Recipe.h"
#import "RecipeModel.h"

@interface RecipeFavViewController ()
@property (weak, nonatomic) IBOutlet UITableView *recipeFavTableView;
@property (nonatomic) NSMutableArray<Recipe *> *recipesFav;
@property (nonatomic) RecipeTableViewDelegateImpl * recipeTableViewDelegate;
@property (nonatomic) BOOL needUpdateViewModel;

@end

@implementation RecipeFavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViewModel];
    self.needUpdateViewModel = false;
    [self registerObserver];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    if(self.needUpdateViewModel){
        [self updateViewModel];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateViewModel{
    self.recipesFav = [[NSMutableArray arrayWithArray:[[RecipeModel instance] getPersistentFavRecipes]] copy];
    self.recipeTableViewDelegate = [[RecipeTableViewDelegateImpl new] initWithData:self.recipesFav pageIndex:0];
    [self.recipeFavTableView setDataSource: self.recipeTableViewDelegate];
    [self.recipeFavTableView setDelegate: self.recipeTableViewDelegate];
    [self.recipeFavTableView reloadData];
    self.needUpdateViewModel = false;
}

-(void) showRecipeDetail:(Recipe *) recipe{
    
}

-(void) registerObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(favRecipesUpdated:) name:RecipeModelRecipeFavUpdate object:nil];
}

-(void) favRecipesUpdated:(NSNotification *)notification{
    self.needUpdateViewModel = true;
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