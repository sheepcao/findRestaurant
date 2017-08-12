//
//  AllDataReceivedModel.h
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseModel.h"
@interface AllDataReceivedModel : NSObject

@property (nonatomic, strong) ResponseModel *response;

+(id) responseDataWithJSONString:(NSString *)JSONString;

@end
