//
//  ViewController.m
//  YQFileManagerDemo
//
//  Created by yyq on 15/12/8.
//  Copyright © 2015年 yyqyearn. All rights reserved.
//

#import "ViewController.h"

#import "YQFileManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self saveString];
    [self saveDic];
    [self saveArray];
    [self saveImage];
}

- (void)saveImage{
    //配置存取信息
    UIImage *image = [UIImage imageNamed:@"Jobs.jpg"];
    NSString *folderName = @"ImageFolder";
    NSString *fileName= @"ImageFile";
    DirectoryType dt = DTypeCaches;
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    //存储
    NSError *error = nil;
    [[YQFileManager shareManager] writeData:data fileName:fileName folderName:folderName dType:dt error:&error];
    NSLog(@"存储内容 = %@\n错误 = %@",image,error.localizedDescription);
    
    //读取
    NSData *loadData = [[YQFileManager shareManager] loadDataWithFileName:fileName folderName:folderName dType:dt];
    UIImage *loadImage = [UIImage imageWithData:loadData];
    NSLog(@"取出结果 = %@",loadImage);
    [self.imageView setImage:loadImage];
}

- (void)saveDic{
    //配置存取信息
    NSDictionary *dic = @{
                          @"123":@"ABC",
                          @"456":@"DEF"
                          };
    NSString *folderName = @"DicFolder";
    NSString *fileName= @"DicFile";
    DirectoryType dt = DTypeCaches;
    NSData *data =[NSKeyedArchiver archivedDataWithRootObject:dic];
    
    //存储
    NSError *error = nil;
    [[YQFileManager shareManager] writeData:data fileName:fileName folderName:folderName dType:dt error:&error];
    NSLog(@"存储内容 = %@\n错误 = %@",dic,error.localizedDescription);
    
    //读取
    NSData *loadData = [[YQFileManager shareManager] loadDataWithFileName:fileName folderName:folderName dType:dt];
    NSDictionary *loadDic = [NSKeyedUnarchiver unarchiveObjectWithData:loadData];
    NSLog(@"取出结果 = %@",loadDic);
}

- (void)saveArray{
    
    //配置存取信息
    NSArray *array = @[@"111",@"222",@3,@4];
    NSString *folderName = @"ArrayFolder";
    NSString *fileName= @"ArrayFile";
    DirectoryType dt = DTypeCaches;
    NSData *data =[NSKeyedArchiver archivedDataWithRootObject:array];
    
    //存储
    NSError *error = nil;
    [[YQFileManager shareManager] writeData:data fileName:fileName folderName:folderName dType:dt error:&error];
    NSLog(@"存储内容 = %@\n错误 = %@",array,error.localizedDescription);
    
    //读取
    NSData *loadData = [[YQFileManager shareManager] loadDataWithFileName:fileName folderName:folderName dType:dt];
    NSArray *loadArray = [NSKeyedUnarchiver unarchiveObjectWithData:loadData];
    NSLog(@"取出结果 = %@",loadArray);
}


- (void)saveString{
    
    //配置存取信息
    NSString *string = @"123";
    NSString *folderName = @"StringFolder";
    NSString *fileName = @"StringFile";
    DirectoryType dt = DTypeDocuments;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //存储
    NSError *error = nil;
    [[YQFileManager shareManager] writeData:data fileName:fileName folderName:folderName dType:dt error:&error];
    NSLog(@"存储内容 = %@\n错误 = %@",string,error.localizedDescription);
    
    //读取
    NSData *loadData = [[YQFileManager shareManager] loadDataWithFileName:fileName folderName:folderName dType:dt];
    NSString *loadString = [[NSString alloc]initWithData:loadData encoding:NSUTF8StringEncoding];
    NSLog(@"取出结果 = %@",loadString);

}
@end
