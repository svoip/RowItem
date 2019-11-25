
# RowItem

A declarative framework for building vertically-stacked views.

  


### Functions that return views

This library has an abstraction layer over how to present "stacked views". 
You have a basic view, you return a `row item`.
You have a collection view, you return a `row item`.

 

  
### How it works with UICollectionViews
  We all know that `UICollectionView` layouts come in 2 flavors, "vertical" and "horizontal".
```swift   
.scrollDirection = .vertical
// or
.scrollDirection = .horizontal
```
 While "horizontal" option offers smooth orientation change, the vertical one is more complicated and the layout breaks easily. 
 RowItem offers a solution. You don't have to worry about orientation changes now. 
  

### Requirements

- iOS 10.0+
- Swift 5+


## Installation

The preferred installation method is with CocoaPods. Add to your `Podfile`:

```ruby

pod 'RowItem'

```

  

# How it works

Adopt `RowItemsProvider` and return from there a list of row items.

This is how a single row item looks like:

```

swift

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

  
This is how you return your list of row items:

```

swift

public var rowItems: [RowItem] {

   var items = [RowItem]()
   items.append(personsCarousel())
   items.append(citiesGrid())
   items.append(halfView())
   items.append(textView())
   return items
}

```

  

  

and present this view controller in your view controller:

  

```

swift

let rowItemsViewController = RowItemContainerController(items: ...)
self.show(rowItemsViewController, sender: nil)

  

```
