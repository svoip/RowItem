//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit

class ContentSizeCalculator {
   
   private let itemHeight:CGFloat
   private let itemWidth:CGFloat
   private let containerWidth: CGFloat
   private let spacing:CGFloat
   private let itemCount:Int
   private let identifier:String
   private var cachedSizes = [Int: CGRect]()
   
   init(itemWidth: CGFloat, itemHeight: CGFloat, spacing:CGFloat, containerWidth: CGFloat, itemCount: Int, identifier: String) {
      self.itemWidth = itemWidth
      self.itemHeight = itemHeight
      self.spacing = spacing
      self.containerWidth = containerWidth
      self.itemCount = itemCount
      self.identifier = identifier
   }
   
   var contentHeight:CGFloat {
      
      // starting position for the calculation variables
      var offsetY = spacing
      var offsetX = spacing
      var maxY:CGFloat = 0
      
      self.cachedSizes = [Int: CGRect]() // reset the bag
      
      let _ = (0..<itemCount).map({ index in
         
         let nextRect = CGRect(x: offsetX, y: offsetY, width: itemWidth, height: itemHeight)
         self.cachedSizes[index] = nextRect
         
         let currentOffsetX = offsetX + itemWidth + spacing
         
         // a new row must be started
         if currentOffsetX > (containerWidth - itemWidth - spacing) {
            offsetX = spacing
            offsetY = offsetY + itemHeight + spacing
         }
         else {
            offsetX = currentOffsetX // continue
         }
         
         maxY = offsetY
         
         // if they are different, a new row has been started already
         if offsetX > spacing {
            maxY = maxY + itemHeight + spacing
         }
         
      })
      
      // notify parties that calculations are complete
      let payload = ["id": identifier, "size": maxY] as [String : Any]
      NotificationCenter.default.post(name: .RenderRowItemNotification, object:payload)
      return maxY
   }
   
   func rectFor(_ index: Int)->CGRect? {
      return cachedSizes[index]
   }
   
}
