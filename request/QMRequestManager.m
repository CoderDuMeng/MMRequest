//
//  QMRequestManager.m
//  DMDownload
//
//  Created by detu on 16/2/29.
//  Copyright © 2016年 com.ggapple. All rights reserved.
//

#import "QMRequestManager.h"

@implementation QMRequestManager

-(instancetype)init{
    self = [super initWithSessionConfiguration:nil];
        if (self) {
    self.requestSerialiazer = [AFHTTPRequestSerializer serializer];
         
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

-(NSURLSessionDataTask *)addRequest:(QMBaseRequest *)request{
    if (request == nil) return nil;
    QMRequestMethod method = [request requestMethod]; //拿到请求方式
    if (method==QMRequestMethodPost) {
       return [self requestMethod:@"POST" withRequest:request];
    }else if (method == QMRequestMethodGet){
    return  [self requestMethod:@"GET"  withRequest:request];
    }else if (method == QMRequestMethodHead){
     return [self requestMethod:@"HEAD" withRequest:request];
    }else if (method == QMRequestMethodPatch){
      return [self requestMethod:@"PATCH" withRequest:request];
    }else if (method == QMRequestMethodDelete){
     return  [self requestMethod:@"DELETE" withRequest:request];
    }else {
       return [self requestMethod:@"PUT" withRequest:request];
    }
}

- (NSURLSessionDataTask *)requestMethod:(NSString * )method withRequest:(QMBaseRequest *)request{
    NSString  *baseUrl = [QMRequestInfo sharedInstance].baseUrl;
    NSString *requestUrl = nil;
    if (!baseUrl.length || baseUrl == nil){
        requestUrl = [request requestUrl];
    }else{
        requestUrl = [baseUrl stringByAppendingString:[request requestUrl]];
    }
    NSMutableDictionary *param = [request requestParameters];
    NSURLSessionDataTask *dataTask = nil;
    if ([method isEqualToString:@"POST"] && [request uploadDataMultipartBodyBlock]) {
   
        dataTask = [self uploadRequest:requestUrl parameters:param progress:^(NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
     
       !request.uploadProgress ? :request.uploadProgress(totalBytesWritten,totalBytesExpectedToWrite);
            
   } constructingBodyWithBlock:request.uploadDataMultipartBodyBlock success:^(id responseObject, NSURLResponse *response) {
      
       !request.successBlockChange ? :request.successBlockChange(responseObject,response);
   } filure:^(NSError *error) {
       !request.filureBlockChange ? :request.filureBlockChange(error);

   }];
        return dataTask;

}
   
    dataTask = [self requestMethod:method url:requestUrl parameters:param timeInterval:[request timeInterval]  success:^(id responseObject, NSURLResponse *response) {
        !request.successBlockChange ? :request.successBlockChange(responseObject , response);
    } filure:^(NSError *error) {
        !request.filureBlockChange ? :request.filureBlockChange(error);
}];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)requestMethod:(NSString *)method url:(NSString *)url parameters:(id)parameters  timeInterval:(NSTimeInterval)timeInterval success:(StartRequestSuccessBlockChange) success filure:(requestFilureBlockChange)filure{
 
    NSError *requestError = nil;
    self.requestSerialiazer.timeoutInterval = timeInterval;
    NSMutableURLRequest *request = [self.requestSerialiazer requestWithMethod:method URLString:url parameters:parameters error:&requestError];
    if (requestError) {
        if (filure) {
            dispatch_async(dispatch_get_main_queue(), ^{
            filure(requestError);
            });
        }
        return nil;
    }
    NSURLSessionDataTask *dataTask = nil;
    __weak typeof(self)weakSelf = self;
    [self startNetworkActivity];
    
   dataTask =  [self dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       if (error) {
           if (filure) {
               filure(error);
           }
       }else{
           if (success) {
               success(responseObject,response);
           }
       }
       [weakSelf stopNetworkActivity];
    }];
   return dataTask;
}

- (NSURLSessionDataTask *)uploadRequest:(NSString *)url
           parameters:(id)parameters
             progress:(uploadProgressChangeBlock)progress
constructingBodyWithBlock:(QMMultipartFormData)bodyBlock
              success:(StartRequestSuccessBlockChange)success
               filure:(requestFilureBlockChange)filure{
    
    NSURLSessionDataTask *dataTask = nil;
    [[AFHTTPSessionManager manager]POST:url parameters:parameters constructingBodyWithBlock:bodyBlock progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject,task.response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (filure) {
            filure(error);
        }
    }];
    return dataTask;
}


- (void)startNetworkActivity{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 }

- (void)stopNetworkActivity{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
