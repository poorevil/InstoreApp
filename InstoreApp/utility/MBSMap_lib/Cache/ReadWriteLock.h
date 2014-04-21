//
//  ReadWriteLock.h
//
//  Created by Lee Claud on 11-7-5.
//  Copyright 2011年 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pthread.h>

@interface ReadWriteLock : NSObject <NSLocking> {
    pthread_rwlock_t lock;
}

- (void) lockForWriting;
- (BOOL) tryLock;
- (BOOL) tryLockForWriting;


@end
