//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit

public class HorizontalFlowLayout:UICollectionViewFlowLayout {
   
   public init(cellSize:CGSize = CGSize(width: 100, height: 100)) {
      super.init()
      self.scrollDirection = .horizontal
      self.itemSize = cellSize
   }
   required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}
