//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit

// Building block that defines the library
// Every view stacked vertically is defined by this object

// Query at runtime the configuration object for its height
public typealias HeightBlock = (CGSize)->CGFloat

public struct RowItem {
   
   public let view:UIView
   
   public let heightBlock:HeightBlock
   
   // unlike other properties, this is modifiable along the way
   public var height:CGFloat = 0
   
   public let collectionViewDefinition: CollectionViewDefinition?
   
   public let identifier:RowItemIdentifier
   
   public init(
      view:UIView,
      heightBlock:@escaping HeightBlock,
      collectionViewDefinition:CollectionViewDefinition?,
      identifier:RowItemIdentifier = .custom 
      ){
      self.view = view
      self.heightBlock = heightBlock
      self.collectionViewDefinition = collectionViewDefinition
      self.identifier = identifier
   }
   
}
