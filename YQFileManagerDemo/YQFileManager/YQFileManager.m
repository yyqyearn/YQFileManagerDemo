//
//  YQFileManager.m
//
//
//  Created by yyq on 15/11/10.
//  Copyright © 2015年 mobilenowgroup. All rights reserved.
//

#import "YQFileManager.h"

@implementation YQFileManager

#pragma mark - 公共方法
/**
 * 构造
 */
+ (instancetype)shareManager{
    YQFileManager *tool = [[YQFileManager alloc]init];
    return tool;
}

/**
 *  单例形式创建工具
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static YQFileManager *tool;
    if (tool == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tool = [super allocWithZone:zone]; // block里面的代码只会运行一次
        });
    }
    return tool;
}

#pragma mark - 文件管理基础方法

- (BOOL)creatFolderWithName:(NSString *)name dType:(DirectoryType)dType error:(NSError **)error
{
    // 创建文件管理器
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // 指向文件目录
    NSString *direcPath = [self dirPathWithDType:dType];
    NSString *fileDocPath = [direcPath stringByAppendingPathComponent:name];
    
    // 创建一个目录
    BOOL secc = [fileMgr createDirectoryAtPath:fileDocPath withIntermediateDirectories:YES attributes:nil error:error];
    return secc;
}


- (BOOL)writeData:(NSData*)data fileName:(NSString*)fileName folderName:(NSString*)folderName dType:(DirectoryType)dType error:(NSError **)error
{
    
    if (!data) {
        NSLog(@"data为空");
        return NO;
    }
    // 1.创建文件管理器
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // 2.查看是否存在当前目录
    NSString *folderPath = [self pathWithFolderName:folderName dType:dType];
    BOOL folderExist = [fileMgr isReadableFileAtPath:folderPath];
    if (!folderExist) {
        [self creatFolderWithName:folderName dType:dType error:error];
    }
    
    // 3.保存文件
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    BOOL fileSaved = [data writeToFile:filePath atomically:YES];
    return fileSaved;
}


- (NSData*)loadDataWithFileName:(NSString*)fileName folderName:(NSString*)folderName dType:(DirectoryType)dType
{
    
    // 1.查看是否存在当前目录
    NSString *folderPath = [self pathWithFolderName:folderName dType:dType];
    if (!folderPath) {
        NSLog(@"文件夹不存在");
        return nil;
    }
    
    // 2.查看文件是否存在
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    if (!filePath) {
        NSLog(@"文件不存在");
        return nil;
    }
    // 3.读取文件
    id data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

- (BOOL)removeItemsWithFileName:(NSString *)fileName folderName:(NSString *)folderName dType:(DirectoryType)dType error:(NSError **)error
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *path = [self pathWithFolderName:folderName dType:dType];
    path = [path stringByAppendingPathComponent:fileName];
    return [fileMgr removeItemAtPath:path error:error];
}

- (BOOL)removeAllItemsWithFolderName:(NSString*)folderName dType:(DirectoryType)dType error:(NSError **)error
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *path = [self pathWithFolderName:folderName dType:dType];
    return [fileMgr removeItemAtPath:path error:error];
}


#pragma mark - 封装快捷方法
- (BOOL)creatDocFolderWithName:(NSString*)name
{
    return [self creatFolderWithName:name dType:DTypeDocuments error:nil];
}


- (BOOL)writeDocData:(NSData*)data fileName:(NSString*)fileName folderName:(NSString*)folderName
{
    return [self writeData:data
                  fileName:fileName
                folderName:folderName
                     dType:DTypeDocuments
                     error:nil];
}

- (NSData*)loadDocDataWithFileName:(NSString*)fileName folderName:(NSString*)folderName{
    return [self loadDataWithFileName:fileName folderName:folderName dType:DTypeDocuments];
}

- (BOOL)removeAllItemsWithDocFileName:(NSString *)fileName folderName:(NSString*)folderName{
    return [self removeItemsWithFileName:fileName folderName:folderName dType:DTypeDocuments error:nil];
}

- (BOOL)removeAllItemsWithDocFolderName:(NSString*)folderName{
    return [self removeAllItemsWithFolderName:folderName dType:DTypeDocuments error:nil];
}


#pragma mark - 私有方法

#pragma mark - 路径方法

- (NSString*)dirPathWithDType:(DirectoryType)dType{
    NSString *direcPath = nil;
    switch (dType) {
        case DTypeHome:
            direcPath = [self dirHomePath];
            break;
        case DTypeDocuments:
            direcPath = [self dirDocPath];
            break;
        case DTypeCaches:
            direcPath = [self dirCachePath];
            break;
        case DTypeLibrary:
            direcPath = [self dirLibPath];
            break;
        case DTypeTemp:
            direcPath = [self dirTmpPath];
            break;
        default:
            direcPath = [self dirDocPath];//默认Document
            break;
    }
    return direcPath;
}

/**获取App根目录*/
- (NSString *)dirHomePath{
    return NSHomeDirectory();
}
/**获取Documents目录*/
- (NSString *)dirDocPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
/**获取Library目录*/
- (NSString *)dirLibPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                         NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
/**获取Cache目录*/
- (NSString *)dirCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                           NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
/**获取Tmp目录*/
- (NSString *)dirTmpPath{
    return  NSTemporaryDirectory();
}


/**
 *  获得某文件夹的路径
 *
 *  @param folderName 文件夹名称
 *  @param dType      文件夹存储类型
 *
 *  @return 该文件夹路径
 */
- (NSString*)pathWithFolderName:(NSString*)folderName dType:(DirectoryType)dType{
    //指向文件目录
    NSString *directoryPath = [self dirPathWithDType:dType];
    if (!folderName) {
        return directoryPath;
    }
    NSString *folderPath = [directoryPath stringByAppendingPathComponent:folderName];
    return folderPath;
}





@end
