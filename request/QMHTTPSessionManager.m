//
//  QMHTTPSessionManager.m
//  DMDownload
//
//  Created by detu on 16/2/29.
//  Copyright © 2016年 com.ggapple. All rights reserved.
//

#import "QMHTTPSessionManager.h" 
@interface QMHTTPSessionManager()
@property (strong , nonatomic) QMRequestManager *requestManager;
@end

@implementation QMHTTPSessionManager
-(instancetype)init{
    if (self=[super init]) {
        _requestManager = [[QMRequestManager alloc]init];
    }
    return self;
}
+(instancetype)sessionManager{
    return [[self alloc] init];
}
-(NSURLSessionDataTask *)POST:(NSString *)url parameters:(id)parameters
    success:(sessionSuccess)success
     filure:(sessionFilure)filure{
    
 return  [self sessionDataTask:url parmeters:parameters
                   method:@"POST"
                  success:success filure:filure];
}
-(NSURLSessionDataTask *)GET:(NSString *)url parameters:(id)parameters success:(sessionSuccess)success filure:(sessionFilure)filure{
    
 return    [self sessionDataTask:url parmeters:parameters
                   method:@"GET"
                  success:success filure:filure];
    
    
}
-(NSURLSessionDataTask *)PUT:(NSString *)url parameters:(id)parameters success:(sessionSuccess)success filure:(sessionFilure)filure{
    
 return    [self sessionDataTask:url parmeters:parameters
                   method:@"PUT"
                  success:success filure:filure];
    
}
-(NSURLSessionDataTask *)DELETE:(NSString *)url parameters:(id)parameters success:(sessionSuccess)success filure:(sessionFilure)filure{
 return    [self sessionDataTask:url parmeters:parameters
                   method:@"DELETE"
                  success:success filure:filure];
    
}
-(NSURLSessionDataTask *)HEAD:(NSString *)url parameters:(id)parameters success:(sessionSuccess)success filure:(sessionFilure)filure{
    
 return    [self sessionDataTask:url parmeters:parameters
                   method:@"HEAD"
                  success:success filure:filure];
    
}

-(NSURLSessionDataTask *)PATCH:(NSString *)url parameters:(id)parameters success:(sessionSuccess)success filure:(sessionFilure)filure{
    
    
 return  [self sessionDataTask:url parmeters:parameters
                   method:@"PATCH"
                  success:success filure:filure];
    
}

- (NSURLSessionDataTask *)sessionDataTask:(NSString *)url
              parmeters:(id)parmeters
                 method:(NSString *)method
                success:(sessionSuccess)success
                 filure:(sessionFilure)filure{
    
    if (url == nil || url.length==0)return  nil;
    
    NSURLSessionDataTask *dataTask = nil;
    if (self.timeoutInterval == 0) {
        self.timeoutInterval = 60;
    }
    NSString *requestUrl =  nil;
    if ([QMRequestInfo sharedInstance].baseUrl) {
        requestUrl = [[QMRequestInfo sharedInstance].baseUrl stringByAppendingString:url];
    }else{
        requestUrl = [url copy];
    }
    dataTask =   [self.requestManager requestMethod:method url:requestUrl parameters:parmeters timeInterval:self.timeoutInterval success:^(id  responseObject, NSURLResponse *response) {
        !success ? : success(responseObject,response);
        
    } filure:^(NSError *error) {
        !filure ? :filure(error);
    }];
    [dataTask resume];
  
    return dataTask;
    
}

@end
