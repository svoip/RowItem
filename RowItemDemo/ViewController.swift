//
//  ViewController.swift
//  ExampleApp


import UIKit
import RowItem

class ViewController: UIViewController {
   
   let demoItemsProvider = DemoItemsProvider()
   
   @IBAction func presentView(_ sender: Any) {
      let rowItemContainer = RowItemContainerController(items: demoItemsProvider.rowItems)
      let navigationController = embeddedInNavigationController( rowItemContainer )
      self.show(navigationController, sender: nil)
   }
}

