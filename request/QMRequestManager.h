//
//  QMRequestManager.h
//  DMDownload
//
//  Created by detu on 16/2/29.
//  Copyright © 2016年 com.ggapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMBaseRequest.h"
#import "AFNetworking.h"

@interface QMRequestManager : AFURLSessionManager
-(NSURLSessionDataTask *)addRequest:(QMBaseRequest *)request;
@property (strong , nonatomic) AFHTTPRequestSerializer <AFURLRequestSerialization> *requestSerialiazer;

@property (strong , nonatomic) AFHTTPResponseSerializer <AFURLResponseSerialization> *responseSerialization;

- (NSURLSessionDataTask *)requestMethod:(NSString * )method withRequest:(QMBaseRequest *)request;


- (NSURLSessionDataTask *)requestMethod:(NSString *)method
                                    url:(NSString *)url
                             parameters:(id)parameters
                           timeInterval:(NSTimeInterval )timeInterval
                                success:(StartRequestSuccessBlockChange) success
                                 filure:(requestFilureBlockChange)filure;


- (NSURLSessionDataTask *)uploadRequest:(NSString *)url
                             parameters:(id)parameters
                               progress:(uploadProgressChangeBlock)progress
              constructingBodyWithBlock:(QMMultipartFormData)bodyBlock
                                success:(StartRequestSuccessBlockChange)success
                                 filure:(requestFilureBlockChange)filure;





@end
