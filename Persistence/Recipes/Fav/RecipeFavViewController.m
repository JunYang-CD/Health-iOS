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
#import "RecipeDetailViewController.h"

@interface RecipeFavViewController ()
@property (weak, nonatomic) IBOutlet UITableView *recipeFavTableView;
@property (nonatomic) NSMutableArray<Recipe *> *recipesFav;
@property (nonatomic) NSArray<Recipe *> *recipesFavViewModel;
@property (nonatomic) RecipeTableViewDelegateImpl * recipeTableViewDelegate;
@property (nonatomic) BOOL needUpdateViewModel;
@property (weak, nonatomic) Recipe *selectedRecipe;
@property (weak, nonatomic) IBOutlet UITextField *recipeFavSearchTextField;
@property (weak, nonatomic) IBOutlet UIButton *recipeSearchTextFieldClearBtn;

@end

@implementation RecipeFavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViewModel];
    self.needUpdateViewModel = false;
    [self registerObserver];
    [self.recipeFavSearchTextField setDelegate:self];
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
    if(![self.recipeFavSearchTextField.text isEqualToString:@""]){
        self.recipeSearchTextFieldClearBtn.hidden = false;
        NSMutableArray<Recipe *> *filteredFavRecipes = [NSMutableArray new];
        for(Recipe *recipe in self.recipesFav){
            if([recipe.name containsString:self.recipeFavSearchTextField.text]){
                [filteredFavRecipes addObject:recipe];
            }
        }
        self.recipesFavViewModel = [filteredFavRecipes copy];

    }else{
        self.recipeSearchTextFieldClearBtn.hidden = true;
        self.recipesFav = [[NSMutableArray arrayWithArray:[[RecipeModel instance] getPersistentFavRecipes]] copy];
        self.recipesFavViewModel = self.recipesFav;
    }
    self.recipeTableViewDelegate = [[RecipeTableViewDelegateImpl new] initWithData:self.recipesFavViewModel pageIndex:0];
    [self.recipeFavTableView setDataSource: self.recipeTableViewDelegate];
    [self.recipeFavTableView setDelegate: self.recipeTableViewDelegate];
    [self.recipeTableViewDelegate setControllerDelegate:self];
    [self.recipeFavTableView reloadData];
    self.needUpdateViewModel = false;
}

-(void) showRecipeDetail:(Recipe *) recipe{
    self.selectedRecipe = recipe;
    [self performSegueWithIdentifier:@"showFavRecipeDetail" sender: self];
}

-(void) registerObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(favRecipesUpdated:) name:RecipeModelRecipeFavUpdate object:nil];
}

-(void) favRecipesUpdated:(NSNotification *)notification{
    self.needUpdateViewModel = true;
}

- (IBAction)recipeSeachTextChanged:(UITextField *)sender {
    [self updateViewModel];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.recipeFavSearchTextField endEditing:true];
    return true;
}
- (IBAction)clearRecipeClearTextField:(UIButton *)sender {
    [self.recipeFavSearchTextField setText:nil];
    [self updateViewModel];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showFavRecipeDetail"]){
        RecipeDetailViewController *recipeDetailController = [segue destinationViewController];
        [recipeDetailController setData: self.selectedRecipe];
    }
}


@end
