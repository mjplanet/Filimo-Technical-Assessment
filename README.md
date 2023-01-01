## Installation

1. Clone the repo
1. Install packages via Swift package manager
1. Run!


## Design Pattern
Design patterns that this application follows is ```MVP```. 

### Factory Methods
Factory Methods are also used for simplfy of creating UIScrollView, UILabel, UIStackView, UIImageView.

```swift
extension UILabel {
    static func makeForTitle(textColor: UIColor? = nil, text: String? = nil) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = textColor
        return label
    }
}
```

Usage:

```swift
private lazy var titleLabel = UILabel.makeForTitle()
```


## Network
### Networking type
Networking of this application is considered as a reference semantic type whose name is "Networking" to execute HTTP requests and communicate with the server.
The networking welcomes URLSession injection and you can inject it via the constructor.
Example:
```swift
print("HI")
```
### URLPath
It's a data type that helps you to easily create your URL by composition. Your paths will be completely named and you can rename and maintain them in the future.
Example:
```swift
print("HI")
```
### HTTP Request
```HTTPRequest``` is a data type that helps you to create an HTTP request and convert it to URLRequest.
```swift
print("HI")
```

### Server Request
Server Request is considered an enum to play as a namespace of the HTTP request layer. You have to define your HTTP requests here then you can call with ```Networking```.
Note: You have to return ```HTTPRequest```
```swift
print("HI")
```

## Langauges

This app supports 5 different langauges! In order to change the langauges, user should change it from iOS Setting app.

<img src="https://user-images.githubusercontent.com/12949603/210183208-794ac0b7-4614-4c56-bcff-eb5942b44f45.png" width="350">


https://user-images.githubusercontent.com/12949603/210183393-5c12c0d4-9e68-4cad-a172-ef5e6339f5df.mp4

## Appearance
The app optimize for light and dark mode!

### Light
<img src="https://user-images.githubusercontent.com/12949603/210183502-5eb79054-8241-4b6a-b624-acfc224cf2e8.png" width="350">

### Dark
<img src="https://user-images.githubusercontent.com/12949603/210183522-4107c792-6f42-4e7b-8612-c8388c8271b3.png" width="350">

## Dynamic Type
Fonts are adopted to dynamc types.


https://user-images.githubusercontent.com/12949603/210183636-562d154e-4930-4215-a43f-9cf20406c40c.mp4


