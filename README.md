Write Your Own API Manager for iOS
We are going to write API manager for iOS which uses URLSession. URLSession is suitable for handing HTTP/HTTPS requests. I used to depend on third-party libraries like "Alamofire" or "AFNetworking". We are going to create the API Manager class using NSURLSession. Which is fairly simple and easy to implement.
URLSessionTask
URLSessionTask: This method determines the type of task. There are mainly 3 types of tasks.
datatask: Data task requests a resource and server returns objects as NSData.
downloadtask: Download task, download a resource directly to file in the disk.
uploadtask: Use this task to upload a file from disk to a web service with HTTP POST or PUT method.


URLSessionConfiguration
A configuration object that defines behavior and policies for a URL session.
There are 3 types of session configurations are available.
default: Creates a default configuration object that uses the disk-persisted global cache, credential, and cookie storage objects.
ephemeral: Similar to the default configuration, except that all session-related data is stored in memory. Think of this as a "private" session.
background: Lets the session perform upload or download tasks in the background. Transfers continue even when the app itself is suspended or terminated by the system.

URLRequest
URLRequest represents information about the request.
URLRequest consists of an HTTP method (GET, POST, etc) and the HTTP headers.
