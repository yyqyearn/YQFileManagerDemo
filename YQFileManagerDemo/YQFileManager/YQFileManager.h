//
//  YQFileManager.h
//  
//
//  Created by yyq on 15/11/10.
//  Copyright © 2015年 mobilenowgroup. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  目录类型
 */
typedef NS_ENUM(NSUInteger, DirectoryType) {

    /**
     * 程序根目录，通常不使用
     */
    DTypeHome = 0,

    /**
     *  保存应用运行时生成的需要持久化的数据，iTunes会自动备份该目录。苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
     */
    DTypeDocuments,
    
    /**
     *  存储程序的默认设置和其他状态信息，iTunes会自动备份该目录。
     */
    DTypeLibrary,
    
    /**
     *  存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除。一般存放体积比较大，不是特别重要的资源。
     */
    DTypeCaches,
    
    /**
     *  保存应用的所有偏好设置，ios的Settings（设置）应用会在该目录中查找应用的设置信息，iTunes会自动备份该目录。
     */
    DTypeTemp,
};


static NSString *const kFolderName = @"yourFolderName"; //随意作文件名


@interface YQFileManager : NSObject

/**
 *  单例创建
 */
+ (instancetype)shareManager;

/**
 *  依据类型创建文件夹
 *
 *  @param name  文件夹名称
 *  @param dType 文件类型
 *
 *  @return 是否创建成功
 */
- (BOOL)creatFolderWithName:(NSString *)name dType:(DirectoryType)dType error:(NSError **)error;


/**
 *  写入文件到指定文件夹
 *
 *  @param data       写入的数据
 *  @param fileName   为文件命名
 *  @param folderName 文件夹名称/如果不存在，将自动创建
 *  @param dType      文件存储类型
 *  @param error      错误信息
 *
 *  @return 是否写入成功
 */
- (BOOL)writeData:(NSData*)data
         fileName:(NSString*)fileName
       folderName:(NSString*)folderName
            dType:(DirectoryType)dType
            error:(NSError **)error;


/**
 *  获得指定文件
 *
 *  @param fileName   文件名
 *  @param folderName 所属文件夹名
 *  @param dType      文件存储类型
 *
 *  @return 取出的文件，错误则为nil
 */
- (NSData*)loadDataWithFileName:(NSString*)fileName
                folderName:(NSString*)folderName
                     dType:(DirectoryType)dType;

/**
 *  删除指定文件
 *
 *  @param fileName   文件名
 *  @param folderName 所属文件夹名
 *  @param dType      存储类型
 *  @param error      错误信息
 *
 *  @return 是否成功删除
 */
- (BOOL)removeItemsWithFileName:(NSString *)fileName folderName:(NSString *)folderName dType:(DirectoryType)dType error:(NSError **)error;

/**
 *  删除指定文件夹及其所有内部子文件
 *
 *  @param folderName 文件夹名称
 *  @param dType      存储类型
 *  @param error      错误信息
 *
 *  @return 是否成功删除
 */
- (BOOL)removeAllItemsWithFolderName:(NSString*)folderName dType:(DirectoryType)dType error:(NSError **)error;



#pragma mark - Doc快捷方法
/**
 *  创建一个文件夹 在doc目录下
 */
- (BOOL)creatDocFolderWithName:(NSString*)name;

/**
 *  保存一个文件到doc
 *
 *  @param data       需要保存的文件
 *  @param fileName   保存的文件名
 *  @param folderName 保存的文件夹名称
 *
 *  @return 是否保存成功
 */
- (BOOL)writeDocData:(NSData*)data fileName:(NSString*)fileName folderName:(NSString*)folderName;


/**
 *  从Doc读取一个文件
 *
 *  @param fileName   文件名
 *  @param folderName 文件夹名
 */
- (NSData*)loadDocDataWithFileName:(NSString*)fileName folderName:(NSString*)folderName;

/**
 *  删除Doc一个文件夹中的内容
 */
- (BOOL)removeAllItemsWithDocFolderName:(NSString*)folderName;

@end
