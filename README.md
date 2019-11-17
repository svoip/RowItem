# RowItem
A declarative framework for building vertically-stacked views


Have you ever heard of "functions that return views"?
This library is basically it.
You have a simple view, you return a row item.
You have a collection view, you return a row item.
Speaking of collection view, this library supports both "vertical" and "horizontal" collection views.


A simple abstraction over how to create "stacked views" that are also resizable in orientation changes.



## Requirements

- iOS 10.0+
- Swift 5+


## Installation

The preferred installation method is with CocoaPods. Add to your `Podfile`:

```ruby
pod 'RowItem'
```

# How it works
Simple.
Adopt RowItemsProvider and return from there a list of row items.

This is how a single row item looks like: 
```swift
// view that takes up half the height of its superview
func halfView()->RowItem{
  
  let itemHeightBlock:HeightBlock = { containerSize in
     return containerSize.height / 2
  }
  
  let view = UIView()
  return RowItem(
     view: view,
     heightBlock: itemHeightBlock,
     collectionViewDefinition: nil
  )
}
```

This is how you define your list of row items:
```swift
public var rowItems: [RowItem] {
      var items = [RowItem]()
      items.append(personsCarousel())
      items.append(citiesGrid())
      items.append(halfView())
      items.append(textView())
      return items
   }
```

then the library returns to you a view controller which you can present in your view controller:
```swift
let rowItemsViewController = RowItemContainerController(items: ...)
self.show(rowItemsViewController, sender: nil)
```
