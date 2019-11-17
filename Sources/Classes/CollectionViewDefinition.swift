//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit

public struct CollectionViewDefinition {
   
   public let layout:UICollectionViewLayout
   public let dataSource:UICollectionViewDataSource
   public let delegate:UICollectionViewDelegate
   public let cellDefinition:CollectionViewCellDefinition
   
   public init(layout:UICollectionViewLayout,
               dataSource:UICollectionViewDataSource,
               delegate:UICollectionViewDelegate,
               cellDefinition:CollectionViewCellDefinition){
      self.layout = layout
      self.dataSource = dataSource
      self.delegate = delegate
      self.cellDefinition = cellDefinition
      
   }
}


public struct CollectionViewCellDefinition {
   
   // For dequeueing and registering the cell as class
   public let cellIdentifier: String
   
   // If such value is provided, library tries to register the nib file instead
   public let nibFilename: String?
   
   public let cellClass: AnyClass
   
   public init(cellIdentifier:String, nibFilename:String?, cellClass: AnyClass){
      self.cellIdentifier = cellIdentifier
      self.nibFilename = nibFilename
      self.cellClass = cellClass
   }
}

