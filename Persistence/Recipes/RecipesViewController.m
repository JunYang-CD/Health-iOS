//
//  RecipesViewController.m
//  Persistence
//
//  Created by Jerry Yang on 9/28/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipesViewController.h"
#import "RecipeCellView.h"
#import "RecipeCellViewModel.h"
#import "RecipeModel.h"


@interface RecipesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *recipeTable;
@end

@implementation RecipesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
//    [[RecipeModel instance] getByID:@"1"];
    [[RecipeModel instance] getByName:@"水煮肉片"];
//    [[RecipeModel instance] getCategories:@"10"];
//    [[RecipeModel instance] getListByCategory:@"1"];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup{
    _recipeTable.dataSource = self;
    _recipeTable.delegate = self;
    [self registerObserver];
}



- (void)registerObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRecipes) name:RecipeModelRecipeListUpdate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRecipes) name:RecipeModelRecipeUpdate object:nil];
}

- (void)refreshRecipes{
    [_recipeTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[RecipeModel instance].recipes.recipes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipeCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"RecipeItem" bundle:nil] forCellReuseIdentifier:@"recipeCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    }
    
    NSArray *test =  [RecipeModel instance].recipes.recipes;
    Recipe* recipe = [test objectAtIndex:indexPath.row];
    RecipeCellViewModel *recipeCellViewModel = [[RecipeCellViewModel recipeCellViewModelWithNameImage:[NSString stringWithFormat:@"%@", recipe.name] imageUrl:recipe.imageUrl] initWithFoods:recipe.foods];
    [cell setData:recipeCellViewModel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
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
