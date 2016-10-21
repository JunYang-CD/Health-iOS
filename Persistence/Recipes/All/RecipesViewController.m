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
#import "RecipeCategoryTableViewController.h"
#import "RecipeDetailViewController.h"


@interface RecipesViewController ()
@property (nonatomic, readonly)  NSMutableArray<Recipe *> *recipes;;
@property (weak, nonatomic) IBOutlet UITableView *recipeTable;
@property (weak, nonatomic) IBOutlet UIStackView *selectedCategoryStack;
@property (weak, nonatomic) NSLayoutConstraint *selectedCategoryWidthConstraint;
@property (nonatomic) NSMutableArray<RecipeCategory *> *selectedCategoryItems;
@property (nonatomic) BOOL editSelectedCategories;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *recipeTableViewTopConstraint;
@property (weak, nonatomic, readonly) Recipe *selectedRecipe;
@property (nonatomic, readonly) NSInteger pageIndex;
@property (weak, nonatomic) IBOutlet UITextField *recipeSearchTextField;
@property (nonatomic) BOOL recipeSearchTextFieldChanged;

@property (weak, nonatomic) IBOutlet UILabel *emptyRecipeNoteLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *recipeLoadIndicator;

@end

@implementation RecipesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _editSelectedCategories = false;
    _recipes = [NSMutableArray new];
    _pageIndex = 1;
    // Do any additional setup after loading the view.
    [self setup];
    //    [[RecipeModel instance] getByID:@"1"];
    //    [[RecipeModel instance] getByName:@"水煮肉片"];
    //    [[RecipeModel instance] getCategories:@"10"];
    //    [[RecipeModel instance] getListByCategory:@"1"];
    
    [self initViewModel];
    _recipeTableViewTopConstraint.constant = -30;
    [_recipeSearchTextField setDelegate: self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup{
    _recipeTable.dataSource = self;
    _recipeTable.delegate = self;
    _recipeTable.userInteractionEnabled = true;
    [self registerObserver];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector( cancleEditSelectedCategory:) ];
    tapGesture.cancelsTouchesInView = false;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)initViewModel{
    [_recipes removeAllObjects];
    _pageIndex = 1;
    
    //  todo: Remove below block. Disable search feature when there is selected categories in temp. As server API is not ready for search recipe in categories.
    if([self.selectedCategoryItems count] >0 ){
        self.recipeSearchTextField.text = @"";
        self.recipeSearchTextField.enabled = false;
    }else{
        self.recipeSearchTextField.enabled = true;
    }

    [self.recipeLoadIndicator startAnimating];
    [self requestRecipes];
}

- (void)requestRecipes{
    
    if([_selectedCategoryItems count] == 0){
        if(![self.recipeSearchTextField.text isEqualToString:@""]){
            [[RecipeModel instance] getByName:self.recipeSearchTextField.text];
        }else{
            [[RecipeModel instance] getListByCategory:@"10" pageIndex:_pageIndex];
        }
    }else{
        if([self.recipeSearchTextField.text isEqualToString:@""]){
            for(RecipeCategory* recipeCategory in _selectedCategoryItems){
                [[RecipeModel instance] getListByCategory: recipeCategory.ID pageIndex:_pageIndex] ;
            }
        }else{
//        todo: Search recipe name in selected recipe categories. The server needs to add one API for this.
        }
       
    }
}


- (void)registerObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRecipes:) name:RecipeModelRecipeListUpdate object:nil];
}
- (IBAction)recipeSearchTextFieldChanged:(UITextField *)sender {
    self.recipeSearchTextFieldChanged = true;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.recipeSearchTextField resignFirstResponder];
    if(self.recipeSearchTextField.text){
        [self initViewModel];
    }
    self.recipeSearchTextFieldChanged = false;
    return true;
}

- (void)refreshRecipes: (NSNotification *) notification{
    [self.recipeLoadIndicator stopAnimating];
    [_recipes addObjectsFromArray: notification.userInfo[@"recipeObj"]];
    if(_recipes){
        [_recipeTable reloadData];
        if([_recipes count] > 0){
            self.emptyRecipeNoteLabel.hidden = true;
            _recipeTable.hidden = false;
        }else{
            self.emptyRecipeNoteLabel.hidden = false;
            _recipeTable.hidden = true;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.recipes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipeCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"RecipeItem" bundle:nil] forCellReuseIdentifier:@"recipeCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    }
    
    Recipe* recipe = [self.recipes objectAtIndex:indexPath.row];
    RecipeCellViewModel *recipeCellViewModel = [[RecipeCellViewModel recipeCellViewModelWithNameImage:[NSString stringWithFormat:@"%@", recipe.name] imageUrl:recipe.imageUrl] initWithFoods:recipe.foods];
    [cell setData:recipeCellViewModel];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_recipes && [_recipes count] >= indexPath.row){
        _selectedRecipe = [self.recipes objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"showRecipeDetail" sender:self];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//todo: measure how many rows can be displayed on the screen at one time.
    if(indexPath.row >= 7 && indexPath.row == [_recipes count] -1 && [self.recipeSearchTextField.text isEqualToString:@""]){
        _pageIndex ++;
        [self requestRecipes];
    }
    
}

- (void)setSelectedCategories:(NSArray<RecipeCategory *> *)selectedCategories{
    _selectedCategoryItems = [NSMutableArray arrayWithArray:selectedCategories];
    [self updateRecipeCategoryTopMargin];
    [self updateSelectedCategoryStackView];
    [self initViewModel];
    
}

- (void) updateRecipeCategoryTopMargin{
    if ([_selectedCategoryItems count] > 0){
        if(self.editSelectedCategories){
            _recipeTableViewTopConstraint.constant = 30;
        }else{
            _recipeTableViewTopConstraint.constant = 10;
        }
    }else{
        _recipeTableViewTopConstraint.constant = -30;
    }
    
}

- (void) updateSelectedCategoryStackView{
    for (UIView *view in [self.selectedCategoryStack subviews]){
        [self.selectedCategoryStack removeArrangedSubview:view];
        [view removeFromSuperview];
        
    }
    NSInteger width = 0;
    for (RecipeCategory* recipeCategory in self.selectedCategoryItems){
        
        NSArray<UIView *> *views = [[NSBundle mainBundle] loadNibNamed:@"RecipeCategoryFilterView" owner:self options:nil];
        UIView *view = [views objectAtIndex:0];
        ((UILabel*)[view viewWithTag:1]).text = recipeCategory.name;
        UILongPressGestureRecognizer *gesRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [view addGestureRecognizer:gesRecognizer];
        [view viewWithTag:2].hidden = !self.editSelectedCategories;
        UITapGestureRecognizer *removeCategoryGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCategoryGesture:)];
        [view setUserInteractionEnabled:true];
        [view addGestureRecognizer:removeCategoryGesture];
        
        [self.selectedCategoryStack addArrangedSubview:view];
        width += 40;
    }
    
    self.selectedCategoryWidthConstraint != nil ? [self.selectedCategoryStack removeConstraint: self.selectedCategoryWidthConstraint] : nil;
    self.selectedCategoryWidthConstraint = [self.selectedCategoryStack.widthAnchor constraintEqualToConstant:width];
    self.selectedCategoryWidthConstraint.active = true;
    
}

-(void) handleLongPress:(UILongPressGestureRecognizer*) gusterReconginze{
    if (gusterReconginze.state == UIGestureRecognizerStateBegan) {
        NSLog(@"filter long pressed ");
        if(self.selectedCategoryItems != nil){
            self.editSelectedCategories = true;
        }
        [self updateSelectedCategoryStackView];
    }
    
}
-(void)removeCategoryGesture:(UITapGestureRecognizer*) tapGesture{
    
    if(self.editSelectedCategories){
        NSInteger index = -1;
        NSInteger removeIndex = index;
        for(UIView *view in self.selectedCategoryStack.subviews){
            index ++;
            if(view  == tapGesture.view){
                removeIndex = index;
            }
        }
        if(removeIndex >= 0){
            [self.selectedCategoryItems removeObjectAtIndex: removeIndex];
            [self updateSelectedCategoryStackView];
            if([self.selectedCategoryItems count] == 0){
                [self cancleEditSelectedCategory: nil];
            }
        }
    }
}

-(void)cancleEditSelectedCategory:(UITapGestureRecognizer*) tapGesture{
    if(self.editSelectedCategories){
        self.editSelectedCategories = false;
        [self updateSelectedCategoryStackView];
        [self updateRecipeCategoryTopMargin];
        [self initViewModel];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    self.editSelectedCategories = false;
    if([segue.identifier isEqualToString:@"showRecipeCategory"] ){
        [(RecipeCategoryTableViewController *)[segue destinationViewController] setDelegate:self];
        [(RecipeCategoryTableViewController *)[segue destinationViewController] setCheckedCategories: self.selectedCategoryItems];
    }else if([segue.identifier isEqualToString:@"showRecipeDetail"]){
        [(RecipeDetailViewController *)segue.destinationViewController setData:_selectedRecipe];
    }
}


@end
