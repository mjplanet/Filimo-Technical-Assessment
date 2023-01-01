## Getting started

1. Clone the repo
1. Install packages via the Swift package manager
1. Run!


## Design Pattern
The design pattern that this application follows is ```MVP```. 

### Factory Methods
Factory Methods are also used to simplify creating UIScrollView, UILabel, UIStackView, and UIImageView.

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
private var session: URLSession

init(session: URLSession = .shared) {
    self.session = session
}

let dataTask = session.dataTask(with: request) { data, response, error in
}
dataTask.resume()

```
### URLPath
It's a data type that helps you to easily create your URL by composition. Your paths will be completely named and you can rename and maintain them in the future.
Example:
```swift
extension URLPath {
    static var baseURL: URLPath {
        return .init(rawValue: "https://api.themoviedb.org/3")
    }
    static let search: URLPath = .init(rawValue: "search")
    static let movie: URLPath = .init(rawValue: "movie")
}
```
Usage:
```swift
let url: URLPath = .baseURL / .search / .movie
```

### HTTP Request
```HTTPRequest``` is a data type that helps you to create an HTTP request and convert it to URLRequest.
```swift
public var urlRequest: URLRequest {
        var components = URLComponents(string: url.absoluteString)
        let cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
 
        var queryItems: [URLQueryItem] = []
        parameters?.forEach({ key, value in
            if let valueString = value as? String {
                let query = URLQueryItem(name: key, value: valueString)
                queryItems.append(query)
            }
        })
        
        components?.queryItems = queryItems
        
        var request = URLRequest(url: components!.url!, cachePolicy: cachePolicy)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body?.serializedData
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        return request
    }
```

### Server Request
Server Request is considered an enum to play as a namespace of the HTTP request layer. You have to define your HTTP requests here then you can call with ```Networking```.
Note: You have to return ```HTTPRequest```
```swift
enum ServerRequest {
    enum SearchMovie {
        static func searchMovies(apiKey: String, searchQuery: String, page: Int) -> HTTPRequest {
            let url: URLPath = .baseURL / .search / .movie
            let parameters = ["api_key": apiKey,
                              "query": searchQuery,
                              "page": "\(page)",
                              "language": Locale.current.language.languageCode?.identifier ?? "en"] as [String : Any]
            
            return .init(url: url, method: .get, parameters: parameters)
        }
    }
}
```

## Langauges

This app supports 5 different languages! To change the language, the user should change it from the iOS Setting app.

<img src="https://user-images.githubusercontent.com/12949603/210183208-794ac0b7-4614-4c56-bcff-eb5942b44f45.png" width="350">


https://user-images.githubusercontent.com/12949603/210183393-5c12c0d4-9e68-4cad-a172-ef5e6339f5df.mp4

## Appearance
The app optimizes for light and dark modes!

### Light
<img src="https://user-images.githubusercontent.com/12949603/210183502-5eb79054-8241-4b6a-b624-acfc224cf2e8.png" width="350">

### Dark
<img src="https://user-images.githubusercontent.com/12949603/210183522-4107c792-6f42-4e7b-8612-c8388c8271b3.png" width="350">

## Dynamic Type
Fonts are adapted to dynamic types.


https://user-images.githubusercontent.com/12949603/210183636-562d154e-4930-4215-a43f-9cf20406c40c.mp4


## Third-party packages

### Kingfisher
This app is using [King fisher](https://github.com/onevcat/Kingfisher) for loading images. Of course, it does not use it directly. And it can be changed in other ways without changing the main code.

```swift
extension UIImageView {
    func loadImage(url: URL?,
                   placeHolder: UIImage? = UIImage(named: "placeHolder"),
                   handler: ((Data?) -> Void)? = nil) {
        self.kf.setImage(with: url, placeholder: placeHolder, options: [.transition(.fade(0.3))]) { result in
            switch result {
            case .success(let image):
                handler?(image.data())
            case .failure(_):
                self.image = placeHolder
                handler?(nil)
            }
        }
    }
}
```
Usage:
```swift
imageView.loadImage(url: imageURL)
```

### Toast
For showing errors the app uses [Toast](https://github.com/BastiaanJansen/toast-swift.git). This one is also not using the library directly.

```swift
protocol ToastInterface {
    func showToast(text: String)
}

extension ToastInterface {
    func showToast(text: String) {
        let toast = Toast.text(text)
        toast.show()
    }
}
```
Usage:
```swift
showToast(text: "Error")
```
These libraries can be easily converted to custom in-house code if there were more time.
