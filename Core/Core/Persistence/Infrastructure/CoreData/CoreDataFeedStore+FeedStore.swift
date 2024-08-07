//
//  CoreDataListStore+ListStore.swift
//  Core
//
//  Created by Afsal on 14/07/2024.
//

import Foundation

extension CoreDataListStore: ListStore {
  public func retrieve(completion: @escaping RetrievalCompletion) {
    perform { context in
      completion(Result {
        try ManagedCache.find(in: context).map {
          CachedFeed(feed: $0.localFeed)
        }
      })
    }
  }
  
  public func insert(_ feed: [LocalListItem], completion: @escaping InsertionCompletion) {
    perform { context in
      completion(Result {
        let managedCache = try ManagedCache.newUniqueInstance(in: context)
        managedCache.feed = ManagedListItem.images(from: feed, in: context)
        
        try context.save()
      })
    }
  }

  public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
    perform { context in
      completion(Result {
        try ManagedCache.find(in: context).map(context.delete).map(context.save)
      })
    }
  }
}
