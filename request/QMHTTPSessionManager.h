//
//  QMHTTPSessionManager.h
//  DMDownload
//
//  Created by detu on 16/2/29.
//  Copyright © 2016年 com.ggapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QMRequestManager.h"  
#import "QMBaseRequest.h"

typedef void (^sessionSuccess)(id responseObject , NSURLResponse *response);
typedef void (^sessionFilure)(NSError *error);
@interface QMHTTPSessionManager : NSObject

+(instancetype)sessionManager;

/**设置时间超时*/
@property (nonatomic, assign) NSTimeInterval timeoutInterval;



- (NSURLSessionDataTask *)POST:(NSString *)url
  parameters:(id)parameters
     success:(sessionSuccess)success
      filure:(sessionFilure)filure;


- (NSURLSessionDataTask *)GET:(NSString *)url
  parameters:(id)parameters
     success:(sessionSuccess)success
      filure:(sessionFilure)filure;


- (NSURLSessionDataTask *)HEAD:(NSString *)url
 parameters:(id)parameters
    success:(sessionSuccess)success
     filure:(sessionFilure)filure;


- (NSURLSessionDataTask *)PUT:(NSString *)url
 parameters:(id)parameters
    success:(sessionSuccess)success
     filure:(sessionFilure)filure;

- (NSURLSessionDataTask *)DELETE:(NSString *)url
 parameters:(id)parameters
    success:(sessionSuccess)success
     filure:(sessionFilure)filure;

- (NSURLSessionDataTask *)PATCH:(NSString *)url
 parameters:(id)parameters
    success:(sessionSuccess)success
     filure:(sessionFilure)filure;

@end
