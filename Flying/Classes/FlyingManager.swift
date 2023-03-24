//
//  FlyingManager.swift
//  Flying
//
//  Created by 杨雄凯 on 2023/3/24.
//

import Foundation

/**
 
 Moya是一个优秀的网络请求框架，它可以大大简化我们的网络请求代码。但是，如果我们在项目中经常使用Moya，可能会发现每次都需要编写相似的代码，这样会让我们的代码显得冗长。因此，我们可以对Moya进行二次封装，使得我们的代码更加简洁。 下面是一个简单的Moya二次封装例子：
 swift
 import Moya

 enum NetworkError: Error {
     case serverError
     case decodeError
     case unknownError
 }

 class NetworkProvider<Target: TargetType>: MoyaProvider<Target> {
     typealias Completion<T> = (Result<T, NetworkError>) -> Void
     
     func request<T: Decodable>(_ target: Target, completion: @escaping Completion<T>) {
         provider.request(target) { result in
             switch result {
             case .success(let response):
                 do {
                     let result = try response.map(T.self)
                     completion(.success(result))
                 } catch {
                     completion(.failure(.decodeError))
                 }
             case .failure(let error):
                 if error.response?.statusCode == 500 {
                     completion(.failure(.serverError))
                 } else {
                     completion(.failure(.unknownError))
                 }
             }
         }
     }
 }
 这段代码中，我们定义了一个`NetworkError`的枚举类型，表示网络请求可能遇到的错误类型。然后，我们定义了一个`NetworkProvider`类，继承自`MoyaProvider`，并定义了一个`Completion`类型别名，表示网络请求的回调闭包。接着，我们定义了一个`request`方法，该方法接受一个泛型`Target`类型的参数和一个泛型`T`类型的回调闭包。在方法内部，我们调用了`provider.request`方法进行网络请求，并通过`switch`语句处理返回结果。如果请求成功，则尝试将响应数据解码成泛型`T`类型，并将结果传递给回调闭包；如果请求失败，则根据响应状态码判断错误类型，并将错误类型传递给回调闭包。 使用这个封装好的网络请求类，我们可以通过以下方式进行请求：
 swift
 let provider = NetworkProvider<GitHubAPI>()

 provider.request(.repositories) { (result: Result<[Repository], NetworkError>) in
     switch result {
     case .success(let repositories):
         print(repositories)
     case .failure(let error):
         print(error)
     }
 }
 以上就是一个简单的Moya二次封装实现。通过这种方式，我们可以将重复的网络请求代码封装起来，使得我们的代码更加简洁和易于维护。当然，具体封装细节还需要根据实际项目需求进行调整和完善。

 
 */
