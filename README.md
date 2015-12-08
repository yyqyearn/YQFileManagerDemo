# YQFileManagerDemo
一个简单的文件管理器
通过简单封装，实现比较快捷的沙盒操作，比如创建文件夹、保存数据、读取数据、删除数据等。


#基本方法
#保存数据

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



#读取数据

 *  读取指定文件
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




#删除数据

 *  删除指定文件
 *
 *  @param fileName   文件名
 *  @param folderName 所属文件夹名
 *  @param dType      存储类型
 *  @param error      错误信息
 *
 *  @return 是否成功删除
 */
- (BOOL)removeItemsWithFileName:(NSString *)fileName
                     folderName:(NSString *)folderName
                          dType:(DirectoryType)dType
                          error:(NSError **)error;
