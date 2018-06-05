# JSONAPIServiceLayer

### Layer components

## HttpRequestable
  Here we define a set of blueprints properties for everything a request needs to be executed.
  - Endpoint: We defined that an Endpoint should have 2 parts. 
    First the **base** part that is a little self explanatory, but here is where the base URL should be stored. As it should be declared just once, we created a protocol extension and declared the computed property value. 
    And the **path** should represent the URI identifier, and should be declared at every Endpoint concrete implementation. Take in consideration that it would be better to create enums and make them to implement the Endpoint protocol.


    ```
    protocol Endpoint {

      var baseUrl: String { get }

      var path: String { get }

      func buildURL() -> String
    }    
    ```

  - HttpMethod: this will respond to every HTTP action. 
  - Parameters: Self explanatory.
  - Header: The header necessary to be send on a HTTP request.
  - Encoding: The encoding may not change, but just in case we need another one, we define an encoding variable.

## ResponseParseable
  Here we define a blueprint init, in order to initialize its concrete implementation with the needed dependency, and a blueprint method to handle the server response.

  ```
  protocol ResponseParseable {

    init(decoder: JSONDecoder)

    func handleResponse<T: Decodable>(response: JsonResponse, expectedType: T.Type) throws -> T
  }
  ```

  We are implicity declaring that the concrete implementation of this protocol must have a JSON decoder.

  Then the method handleResponse is composed by two parameters:
  - Response: which should be an instance of JsonResponse.
  - ExpectedType: a generic param that we impose it to conform Decodable.

## RequestCommandable
  Here we define a protocol to connect the RequestHandeable and RequestExecutable.

## RequestExecutable
  Here we define a blueprint init, in order to initialize its concrete implementation with the needed dependency, and a blueprint method that will send a request to the server and communicate with the ResponseParseable whenever the server responds to the executed request.

  This protocol 
    
## RequestHandeable
  Here we define a protocol with a blueprint init to indicate us we need to inject a RequestCommandable, and a blueprint method with two generics parameters: Output that will be our return type and that should be a concrete implementation of HttpResponsable; and Model that should be a concrete implementation of Decodable protocol.

### Request Executor / Protocols:
  - RequestExecutable: will be the top layer, this declare the function execute
  that will receive a HttpRequestable and the object's expected type, in return
  will give you an HttpResponsable, the exit point where you will
  recieve your expected object

  - HttpRequestable: define the endpoint, http method, params and headers for
  your request

  - HttpResponsable: define your return model when call an API service

### Response Parser / Protocols:
  - ResponseParseable: define methods to parse the response from the
  HttpResponsable, using a decoder (in our case JSONDecoder) will generate
  the expected model.

### 3rd Party Integrations
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

  - [Swinject](https://github.com/Swinject/Swinject)
  This library will help us to achieve IoC(Inversion of Control) due to we develop our networking layer with Dependency Injection instead of a fat singleton with multiple responsabilities.
  In order to inject a property, we must instantiate a Container, and register the base protocol with the associated concrete implementation.
