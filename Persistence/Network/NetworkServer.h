//
//  ApiRequest.h
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSServer.h"
#import "AFURLSessionManager.h"

@interface NetworkServer : NSObject <PSServer>

@property (nonatomic, readonly)AFURLSessionManager *manager;
+(instancetype)networkServer;
-(instancetype)initWithManager:(AFURLSessionManager*) sessionManager;

@end
