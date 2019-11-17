
import Foundation
import UIKit

struct Random {
   
   static func color()->UIColor{
      let red:CGFloat = CGFloat(drand48())
      let green:CGFloat = CGFloat(drand48())
      let blue:CGFloat = CGFloat(drand48())
      return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
   }
}
