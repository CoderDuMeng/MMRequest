//
//  QMBaseRequest.m
//  DMDownload
//
//  Created by detu on 16/2/29.
//  Copyright © 2016年 com.ggapple. All rights reserved.
//

#import "QMBaseRequest.h" 
#import "QMRequestManager.h"
#import <objc/runtime.h>
@implementation QMRequestInfo
+(QMRequestInfo *)sharedInstance{
    static QMRequestInfo *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info =  [[QMRequestInfo alloc] init];
    });
    return info;
}
@end


@interface QMBaseRequest()
@end
const void *dataTaskKey;

@implementation QMBaseRequest
+(instancetype)request{
    return [[self alloc] init];
}
-(NSString *)requestUrl{
    return @"";
}
-(QMRequestMethod)requestMethod{
    return QMRequestMethodPost;
}
-(NSMutableDictionary *)requestParameters{
    return nil;
}
-(NSTimeInterval)timeInterval{
    return 60;
}
-(QMMultipartFormData)uploadDataMultipartBodyBlock{
    return nil;
}
-(void)start{
    QMRequestManager *manager = [[QMRequestManager alloc] init];
    NSURLSessionDataTask *dataTask = [manager addRequest:self];
    objc_setAssociatedObject(self, &dataTaskKey, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(void)cancel{
    NSURLSessionDataTask *dataTask  = objc_getAssociatedObject(self, &dataTaskKey);
    if (dataTask) {
        [dataTask cancel];
    }
}

-(void)startReqeustWithSuccess:(StartRequestSuccessBlockChange)success filure:(requestFilureBlockChange)filure{
   
    [self start];
    [self startCompletionWithSuccess:success filure:filure];
    
}

- (void)startCompletionWithSuccess:(StartRequestSuccessBlockChange)success filure:(requestFilureBlockChange)filure{
    self.successBlockChange = success;
    self.filureBlockChange  = filure;
    
}
-(void)clearSuccessOrFilureBlock{
    if (self.successBlockChange) {
        self.successBlockChange = nil;
    }
    if (self.filureBlockChange) {
        self.filureBlockChange = nil;
    }
}



@end
