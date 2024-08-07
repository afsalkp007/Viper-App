//
//  ManagedCache.swift
//  Core
//
//  Created by Afsal on 14/07/2024.
//

import Foundation
import CoreData

@objc(ManagedCache)
class ManagedCache: NSManagedObject {
  @NSManaged var feed: NSOrderedSet
}
 
extension ManagedCache {
  static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
    let request = NSFetchRequest<ManagedCache>(entityName: ManagedCache.entity().name!)
    request.returnsObjectsAsFaults = false
    return try context.fetch(request).first
  }

  static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedCache {
    try find(in: context).map(context.delete)
    return ManagedCache(context: context)
  }
  
  var localFeed: [LocalListItem] {
    return feed.compactMap { ($0 as? ManagedListItem)?.local }
  }
}
