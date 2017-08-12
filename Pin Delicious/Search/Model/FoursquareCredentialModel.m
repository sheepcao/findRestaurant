//
//  FoursquareCredentialModel.m
//  Pin Delicious
//
//  Created by Eric on 8/12/17.
//  Copyright © 2017 ericcao. All rights reserved.
//

#import "FoursquareCredentialModel.h"

@implementation FoursquareCredentialModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.clientID = @"U5ERKRODALRDJ4QY2LIGJUKP5G3XWBGM0G0WHNOD0UNPZYGA";
        self.clientSecret = @"U513FYEAHYOQ4CI420TMY1HFHSH2JDF430424ZGITGZK50RG";
    }
    return self;
}
@end
