//
//  ViewController.m
//  test
//
//  Created by wangxu的air on 2020/11/12.
//  Copyright © 2020 wangxu的air. All rights reserved.
//

#import "ViewController.h"
#import "WLCustomKeyboardView.h"


@interface ViewController ()<WLCustomKeyboardViewDelegate>

@property(nonatomic,strong)UILabel * lable;
@property(nonatomic,strong)WLCustomKeyboardView * kb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WLCustomKeyboardView * view=[[WLCustomKeyboardView alloc]initWithWidth:[UIScreen mainScreen].bounds.size.width  height:[UIScreen mainScreen].bounds.size.height];
    view.delegate=self;
    [self.view addSubview:view];
    
    self.kb=view;
    
    self.lable=[[UILabel alloc]initWithFrame:CGRectMake(100, 300, 200, 50)];
    [self.view addSubview:self.lable];
    self.lable.backgroundColor=[UIColor greenColor];
    self.lable.textColor=[UIColor blackColor];
    
    
    UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(300, 300, 100, 50)];
    [self.view addSubview: button];
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"删除" forState:UIControlStateNormal];
    
    
    [button addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

-(void)delete{
    NSLog(@"delete");
    [self.kb deleteInputString];
    
    self.lable.text=@"";
}
/**
 键盘输入内容改变
 */
- (void)keyboardTextDidChange:(NSString *)text{
    self.lable.text=text;
}

/**
 键盘输入完成键
*/
- (void)keyboardShouldReturn:(NSString *)text{
    
}


-(void)keyboardAction{
    
}



@end
