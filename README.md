# JSONAPIServiceLayer

### Request Executor / Protocols:
  - RequestExecutable: will be the top layer, this declare the function execute 
  that will receive a HttpRequestable and the object's expected type, in return 
  will give you an HttpResponsable, the exit point where you will 
  recieve your expected object
  
  - HttpRequestable: define the enpoint, http method, params and headers for 
  your request
  
  - HttpResponsable: define your return model when call an API service

### Response Parser / Protocols:
  - ResponseParseable: define methods to parse the response from the 
  HttpResponsable, using a decoder
  
### Integrations
  - [Alamofire](https://github.com/Alamofire/Alamofire): 
  we decided to integrate this pod to be our ResquestExecutable.
  It facilitate the generation of a HTTP request, a parsing it response to a
  JSON data type.  A clean way for HTTP request build on the top of 
  NSURLSession.
  
  - [PromiseKit](https://github.com/mxcl/PromiseKit): 
  this library will be our RequestResponsable. 
  Is a clean and elegant way to handle asynchronous task, much
  better than using callbacks.  In order to avoid callback hell, we 
  implemented this library.  You can easily separate what to execute if your
  previous task return an error or it was successful.  

  
  
  
