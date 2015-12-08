# YQFileManagerDemo
一个简单的文件管理器
通过简单封装，实现比较快捷的沙盒操作，比如创建文件夹、保存数据、读取数据、删除数据等。


举例：
引入头文件YQFileManager.h
保存字符串：

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

保存数组

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
