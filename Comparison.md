### Promise Kit

## Asynchronous operations chainable:  
PK provides you an elegant and clean way to chain operations by using the then closure. Also you can chain promises, with this you can execute multiple tasks and perform any operation when they all have finished in a simple way.
The cleanest way to do this is something that you can’t miss.  If you want to chain multiple task you have to define lot of callbacks or delegates, passing through functions, called Callback Hell. With PMK you get a very clean way to do it.
The error handling is so easy to manage. Using the catch closure you can define what the app should do in an error case, you avoid define a callback that has an error parameter.

## PromiseKit vs Bolts
Both are very good frameworks, I had used Bolts in other projects and it worked very well, but when you want to chain a few task the code turns a little nasty.  PromiseKit on the other hand gives you a very easy and clean way to chain those promise/task 


## Alamofire:
Make an easy way to implement the http service layer, in an small number of line, less than URLSession
Easy way to handle JSON response.
It also helps us to handle any type of response, JSON, data, etc.


## Alamofire vs Networking vs Moya

Alamofire and Networking are very similar http request library , the way they both prepare to do a request and how they handle the response are very similar.  By the other hand, Alamofire has a bigger community , more rated in gitlab and maintained regularly
Moya seems to be very good library, but it coupled the layer API service with the http request layer, if you need to change your http request layer for a new one, if you were using Moya you will need to build a new API Service layer.

