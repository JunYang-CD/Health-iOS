//
//  PSServerRegister.m
//  Persistence
//
//  Created by Jerry Yang on 10/8/16.
//  Copyright © 2016 Jerry Yang. All rights reserved.
//

#import "PSServerRegistry.h"
#import "NetworkServer.h"

@implementation PSServerRegistry

+(id<PSServer>)server{
    static id<PSServer> _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [self createServerWithStubEnabled:false];
    });
    return _instance;
}

+(id<PSServer>)createServerWithStubEnabled:(BOOL)stubEnabled{
    id<PSServer> server = nil;
    if(stubEnabled){
        server = [NetworkServer networkServer];
    }else{
        server = [NetworkServer networkServer];
    }
    return server;
}


@end
