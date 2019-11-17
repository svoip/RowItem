//
//  LabelViewController.swift
//  ExampleApp
//

import UIKit

class LabelViewController: UIViewController {
   
   @IBOutlet weak var label: UILabel!
   var info:String?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      label.text = info 
   }
   
   static func newInstance()->LabelViewController {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      return storyboard.instantiateViewController(withIdentifier: "LabelViewController") as! LabelViewController
   }
}
