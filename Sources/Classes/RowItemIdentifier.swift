//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation


public enum RowItemIdentifier {
   
   // Collection-view with 'horizontal' scroll
   case carousel
   
   // Collection-view with 'vertical' scroll
   // -'uuid' parameter: an identifier used for calculating collectionview height at runtime
   case grid(uuid: String)
   
   // Vertical padding applied between row items
   // Used internally by the library
   case padding
   
   // Custom item type (which can be anything as simple UIView, or UILabel)
   // the default type
   case custom
}
