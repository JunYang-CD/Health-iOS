//
//  PSServerRegister.h
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSServer.h"

@interface PSServerRegistry : NSObject

+(id<PSServer>) server;
+(id<PSServer>) createServerWithStubEnabled: (BOOL)stubEnabled;

@end