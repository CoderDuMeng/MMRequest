//
//  QMRequest.m
//  DMDownload
//
//  Created by detu on 16/2/29.
//  Copyright © 2016年 com.ggapple. All rights reserved.
//

#import "QMRequest.h"
@implementation QMRequest

-(NSString *)requestUrl{
   return @"api/mobile2/get_home_channels";

}



-(QMRequestMethod)requestMethod{
    return QMRequestMethodPost;
}

//-(QMMultipartFormData)uploadDataMultipartBodyBlock{
//    return ^(id <AFMultipartFormData> fromData){
//        
//        [fromData appendPartWithFileData:nil name:nil fileName:nil mimeType:nil];
//       
//    };
//    
//}
@end
