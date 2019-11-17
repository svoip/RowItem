//
//  RowItem
//  A declarative framework for building vertically-stacked views
//

//  Copyright © 2019 Sardorbek Ruzmatov
//

import Foundation
import UIKit

public func embeddedInNavigationController(_ v:UIViewController)->UINavigationController{
   let navVc = UINavigationController(rootViewController: v)
   let clickAction = {
      navVc.dismiss(animated: true)
   }
   let actionButton = ClosureButton(type: .custom)
   actionButton.setTitle("X", for: .normal)
   actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
   actionButton.titleLabel?.textColor = .black
   actionButton.tintColor = .black
   actionButton.backgroundColor = .orange
   actionButton.frame = CGRect(x: 5, y: 20, width: 50, height: 35)
   actionButton.actionHandle(controlEvents: .touchUpInside, forAction: clickAction)
   let bi = UIBarButtonItem(customView: actionButton)
   v.navigationItem.leftBarButtonItem = bi
   return navVc
}


public func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
   if let nav = viewController as? UINavigationController {
      return topViewController(nav.visibleViewController)
   }
   if let tab = viewController as? UITabBarController {
      if let selected = tab.selectedViewController {
         return topViewController(selected)
      }
   }
   if let presented = viewController?.presentedViewController {
      return topViewController(presented)
   }
   return viewController
}


fileprivate typealias ButtonClick = () -> Void

fileprivate class ClosureButton: UIButton {
   var action: ButtonClick?
   private func actionHandleBlock(action:ButtonClick? = nil) {
      if action != nil {
         self.action = action
      } else {
         self.action?()
      }
   }
   
   @objc private func triggerActionHandleBlock() {
      self.actionHandleBlock()
   }
   
   func actionHandle(controlEvents control:UIControl.Event, forAction action:@escaping () -> Void) {
      self.actionHandleBlock(action: action)
      self.addTarget(self, action: #selector(self.triggerActionHandleBlock), for: control)
   }
   
}
