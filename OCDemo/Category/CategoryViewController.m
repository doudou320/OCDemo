//
//  CategoryViewController.m
//  OCDemo
//
//  Created by songyuliang on 2022/7/10.
//

#import "CategoryViewController.h"
#import "Person.h"
#import "Student.h"
#import "Teacher.h"
#import "Woman.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    Person *p = [Person alloc];
//    [p walk];
    
//    [Student initialize];
//    [Student initialize];
    Student *student = [[Student alloc] init];
    [student walk];
    
//    Teacher *teacher = [[Teacher alloc] init];
//    [teacher walk];
//
//    Woman *woman = [[Woman alloc] init];
//    [woman walk];
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
