//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit


//
// This class:
// -adopts "UICollectionViewDelegateFlowLayout", thus adopting "UICollectionViewDelegate" indirectly
// - interacts with the underlying collection view in defining:
// a) sizes of the cells
// b) event handling (the tap of a cell)

public typealias CollectionViewDidSelectItemCallback = (UICollectionView, IndexPath) -> Void

public class DelegateFlowLayout:NSObject, UICollectionViewDelegateFlowLayout {
   
   private let paddingFromParent:CGFloat
   private let paddingFromSibling:CGFloat
   private let cellSize:CGSize
   private let cellCallback:CollectionViewDidSelectItemCallback
   
   public init(cellSize:CGSize, cellCallback: @escaping CollectionViewDidSelectItemCallback) {
      self.cellSize = cellSize
      self.cellCallback = cellCallback
      self.paddingFromParent = 10
      self.paddingFromSibling = self.paddingFromParent/2
      
      super.init()
   }
   
   // MARK:- Event handling
   
   public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      cellCallback(collectionView, indexPath)
   }
   
}
