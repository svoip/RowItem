//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit

public protocol CellProtocol: class {
   static var reuseIdentifier: String { get }
}


extension UICollectionViewCell: CellProtocol {
   public static var reuseIdentifier: String {
      return String(describing: self)
   }
}

