### Write Your Own API Manager for iOS

We are going to write API manager for iOS which uses URLSession. URLSession is suitable for handing HTTP/HTTPS requests. I used to depend on third-party libraries like “[Alamofire](https://github.com/Alamofire/Alamofire)” or “[AFNetworking](https://github.com/AFNetworking/AFNetworking)”. We are going to create the API Manager class using NSURLSession. Which is fairly simple and easy to implement.

> **URLSessionTask**

> URLSessionTask: This method determines the type of task. There are mainly 3 types of tasks.

**_datatask:_** Data task requests a resource and server returns objects as NSData.

**_downloadtask:_** Download task, download a resource directly to file in the disk.

**_uploadtask:_** Use this task to upload a file from disk to a web service with HTTP POST or PUT method.

![](https://cdn-images-1.medium.com/max/800/0*dHf1S5I_IV0QbfRw.png)

  

> **URLSessionConfiguration**

> A configuration object that defines behavior and policies for a URL session.

There are 3 types of session configurations are available.

-   **_default:_** Creates a default configuration object that uses the disk-persisted global cache, credential, and cookie storage objects.
-   **_ephemeral:_** Similar to the default configuration, except that all session-related data is stored in memory. Think of this as a “private” session.
-   **_background:_** Lets the session perform upload or download tasks in the background. Transfers continue even when the app itself is suspended or terminated by the system.

> **URLRequest**

> URLRequest represents information about the request.

URLRequest consists of an HTTP method (GET, POST, etc) and the HTTP headers.

Below you can see network manager class which can handle HTTP requests

```swift
    import Foundation
    
    enum HttpMethod:String{
        case get = "get"
        case post = "post"
    }
    
    let BaseURL : String = "http://dummy.restapiexample.com/api/v1/"
    
    class NetworkManager {
        
        static let shared = NetworkManager()
        
        func dataTask(serviceURL:String,httpMethod:HttpMethod,parameters:[String:String]?,completion:@escaping (AnyObject?, Error?) -> Void) -> Void {
           
            requestResource(serviceURL: serviceURL, httpMethod: httpMethod, parameters: parameters, completion: completion)
        }
        
        private func requestResource(serviceURL:String,httpMethod:HttpMethod,parameters:[String:String]?,completion:@escaping (AnyObject?, Error?) -> Void) -> Void {
            
            var request = URLRequest(url: URL(string:"\(BaseURL)\(serviceURL)")!)
           
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = httpMethod.rawValue
            
            if (parameters != nil) {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
            }
            
            let sessionTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
                
                if (data != nil){
                    let result = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    completion (result as AnyObject, nil)
                }
                    
                if (error != nil) {
                    completion (nil,error!)
                }
            }
            sessionTask.resume()
        }
    }
```
Invoke HTTP Get

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.dataTask(serviceURL: "employees", httpMethod: .get, parameters: nil) { (response, error) in
            if response != nil {
                print(response)
            }
            if error != nil {
                print("Error Occoured")
            }
        } 
    }
}
```

HTTP POST

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.dataTask(serviceURL: "create", httpMethod: .post, parameters: ["name":"rinto","salary":"456","age":"30"]) { (response, error) in
            if response != nil {
                print(response)
            }
            if error != nil {
                print("Error Occoured")
            }
        }
    }
}
```
