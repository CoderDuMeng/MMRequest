//
//  QMBaseRequest.h
//  DMDownload
//
//  Created by detu on 16/2/29.
//  Copyright © 2016年 com.ggapple. All rights reserved.
//

#import <Foundation/Foundation.h>  
#import "AFNetworking.h"


@interface QMRequestInfo : NSObject
+(QMRequestInfo *)sharedInstance;
/**请求服务器地址*/
@property (copy , nonatomic)  NSString *baseUrl;

@end

/**请求方式*/
typedef enum {
    QMRequestMethodPost,
    QMRequestMethodGet,
    QMRequestMethodDelete,
    QMRequestMethodHead,
    QMRequestMethodPut,
    QMRequestMethodPatch
}QMRequestMethod;



typedef void (^uploadProgressChangeBlock)(NSInteger totalBytesWritten , NSInteger totalBytesExpectedToWrite);
typedef void(^QMMultipartFormData)(id <AFMultipartFormData> formData);
typedef void (^StartRequestSuccessBlockChange)(id responseObject ,NSURLResponse *response);

typedef void (^requestFilureBlockChange)(NSError *error);
@interface QMBaseRequest : NSObject

/**上传时候的进度*/
@property (copy , nonatomic) uploadProgressChangeBlock      uploadProgress;
/**请求成功的回调*/
@property (copy , nonatomic) StartRequestSuccessBlockChange successBlockChange;
/**请求失败的回调*/
@property (copy , nonatomic) requestFilureBlockChange       filureBlockChange;
/**类方法快速创建对象*/
+(instancetype)request;

- (void)start;
- (void)cancel;

/**请求网络调用  success成功的回调 filure失败的回调*/
- (void)startReqeustWithSuccess:(StartRequestSuccessBlockChange)success filure:(requestFilureBlockChange)filure;

/**子类返回请求方式*/
- (QMRequestMethod )requestMethod;

/**子类返回请求的url*/
- (NSString *)requestUrl;

/**返回要请求的参数*/
- (NSMutableDictionary *)requestParameters;

/**返回超时时间 默认设置是60  在子类可以设置你想要设置的值*/
- (NSTimeInterval )timeInterval;

/**请求完毕把成功和失败的Block 设置为nil*/
- (void)clearSuccessOrFilureBlock;

/**上传文件等 调用的Block  在子类从写找个方法 配置上传的文件信息数据等等*/
- (QMMultipartFormData)uploadDataMultipartBodyBlock;


@end
