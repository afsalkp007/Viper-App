//
//  ManagedListItem.swift
//  Core
//
//  Created by Afsal on 14/07/2024.
//

import Foundation
import CoreData

@objc(ManagedListItem)
class ManagedListItem: NSManagedObject {
  @NSManaged var id: UUID
  @NSManaged var name: String
  @NSManaged var country: String
  @NSManaged var code: String
  @NSManaged var state: String?
  @NSManaged var webpage: String?
}
 
extension ManagedListItem {
  static func images(from feed: [LocalListItem], in context: NSManagedObjectContext) -> NSOrderedSet {
    return NSOrderedSet(array: feed.map { local in
      let managed = ManagedListItem(context: context)
      managed.id = UUID()
      managed.name = local.name
      managed.country = local.country
      managed.code = local.code
      managed.state = local.state
      managed.webpage = local.webpage
      return managed
    })
  }
  
  var local: LocalListItem {
    return LocalListItem(name: name, country: country, code: code, state: state, webpage: webpage)
  }
}
