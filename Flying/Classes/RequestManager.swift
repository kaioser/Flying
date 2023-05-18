//
//  FlyRequest.swift
//  Flying
//
//  Created by 杨雄凯 on 2023/3/30.
//

import Foundation
import HandyJSON
import Moya

let provider = MoyaProvider<MultiTarget>(plugins: NetworkConfiguration.shared.plugins)

public typealias SuccessClosure = ((Response) -> Void)
public typealias SuccessDeserializeClosure<T: HandyJSON> = ((T, Response) -> Void)
public typealias FailureClosure = ((NetworkError) -> Void)

public class Flying {
    
    /// 网络请求（不解析数据）
    /// - Parameters:
    ///   - target: 接口信息
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 可取消的请求
    @discardableResult public static func request(_ target: TargetType,
                                                  success: @escaping SuccessClosure,
                                                  failure: @escaping FailureClosure) -> Cancellable {
        
        return provider.request(MultiTarget(target)) { result in
            
            switch result {
            case .success(let response):
                success(response)
                
            case .failure(let error):
                failure(.unknownError(error))
            }
        }
    }
    
    /// 网络请求（自动解析数据）
    /// - Parameters:
    ///   - target: 接口信息
    ///   - adapter: 适配器（数据解析的model的类型）
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: 可取消的请求
    @discardableResult public static func request<T: HandyJSON>(_ target: TargetType,
                                                                adapter: T.Type,
                                                                success: @escaping SuccessDeserializeClosure<T>,
                                                                failure: @escaping FailureClosure) -> Cancellable {
        
        return provider.request(MultiTarget(target)) { result in
            
            switch result {
            case .success(let response):
                
                guard let jsonString = try? response.mapString() else {
                    failure(.decodeError)
                    return
                }
                
                guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
                    failure(.decodeError)
                    return
                }
                
                success(model, response)
                
            case .failure(let error):
                failure(.unknownError(error))
            }
        }
    }
    
    // 传入定制接口的请求，待使用
    //    @discardableResult public static func requestAir<T: HandyJSON>(_ api: APIConfiguration,
    //                                                                   adapter: T.Type,
    //                                                                   success: @escaping SuccessDeserializeClosure<T>,
    //                                                                   failure: @escaping FailureClosure) -> Cancellable {
    //        return provider.request(MultiTarget(api)) { result in
    //
    //            switch result {
    //            case .success(let response):
    //
    //                guard let jsonString = try? response.mapString() else {
    //                    failure(.decodeError)
    //                    return
    //                }
    //
    //                guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
    //                    failure(.decodeError)
    //                    return
    //                }
    //
    //                success(model, response)
    //
    //            case .failure(let error):
    //                failure(.unknownError(error))
    //            }
    //        }
    //    }
}

// 定制api
public struct APIConfiguration: TargetType {
    
    private var rPath: String
    private var rMethod: Moya.Method
    private var rTask: Moya.Task
    public init(path: String, method: Moya.Method, task: Moya.Task) {
        self.rPath = path
        self.rMethod = method
        self.rTask = task
    }
    
    public var path: String { rPath }
    public var method: Moya.Method { rMethod }
    public var task: Moya.Task { rTask }
}

public enum NetworkError: Error {
    // 解码失败
    case decodeError
    // 不确定的error，有可能是服务端本身的错误，例如500；也有可能是客户端参数传错了导致的error，所以在此把Moya返回的error一并返回
    case unknownError(_ moyaError: MoyaError)
}
