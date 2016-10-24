//
//  ViewController.m
//  Persistence
//
//  Created by Jerry Yang on 10/21/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "RecipeDetailMoreViewController.h"
#import "RecipeModel.h"
#import "UIView+Toast.h"

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

- (void)viewWillAppear:(BOOL)animated{
    [self updateMenuItems];
}

- (void)didReceiveMemoryWarning {
    // Dispose of any resources that can be recreated.
}

-(void) addGestures{
    UITapGestureRecognizer *updateFavGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateFavRecipe)];
    UITapGestureRecognizer *shareRecipeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareRecipe)];
    
    [self.addIconVIew addGestureRecognizer:updateFavGesture];
    [self.addTextView addGestureRecognizer:updateFavGesture];
    [self.shareIconView addGestureRecognizer:shareRecipeGesture];
    [self.shareIconView addGestureRecognizer:shareRecipeGesture];
}

-(void) updateMenuItems{
    if(self.isFav){
        [self.addTextView setText:@"Remove Fav"];
        [self.addIconVIew setImage:[UIImage imageNamed:@"Dash"]];
    }else{
        [self.addTextView setText:@"Add as Fav"];
        [self.addIconVIew setImage:[UIImage imageNamed:@"Add"]];
    }
}

-(void) updateFavRecipe{
    NSLog(@"add fav recipe");
    if(self.isFav){
        [[RecipeModel instance] removeFavRecipe:self.recipe];
        if(self.toastDelegate){
            [self.toastDelegate showToast: @"Remove from favorate list successfully."  duration:2.0 position:CSToastPositionCenter];
        }
    }else{
        [[RecipeModel instance] persistentFavRecipe:self.recipe];
        if(self.toastDelegate){
            [self.toastDelegate showToast: @"Add to favorate list successfully." duration:2.0 position:CSToastPositionCenter];
        }
    }
    self.isFav = !self.isFav;
    [self dismissViewControllerAnimated:true completion:nil];
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
