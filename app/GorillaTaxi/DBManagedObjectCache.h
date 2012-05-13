//
//  DBManagedObjectCache.h
//  DiscussionBoard
//
//  Created by Nelson Melo on 1/10/11.
//  Copyright 2011 CodeModLabs LLC. All rights reserved.
//

#import <RestKit/CoreData/RKManagedObjectCache.h>

#import "DBProduct.h"
/**
 * An implementation of the RestKit object cache. The object cache is
 * used to return locally cached objects that live in a known resource path.
 * This can be used to avoid trips to the network.
 */
@interface DBManagedObjectCache : NSObject <RKManagedObjectCache> {
    
}

@end
