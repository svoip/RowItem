//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit

class RowItemCell:UITableViewCell {
   
   private var model:RowItem?
   
   override func awakeFromNib() {
      super.awakeFromNib()
      self.backgroundColor = .clear
   }
   
   func adapt(to model:RowItem, width: CGFloat){
      self.model = model
      
      self.contentView.addSubview(model.view)
      
      // inflate model view
      model.view.frame = CGRect(x: 0, y: 0, width: width, height: model.height)
      
   }
   
   override func prepareForReuse() {
      super.prepareForReuse()
      
      if let parentView = self.model?.view.superview {
         let parent = self.contentView
         if parentView == parent {
            self.model?.view.removeFromSuperview()
         }
      }
   }
}
