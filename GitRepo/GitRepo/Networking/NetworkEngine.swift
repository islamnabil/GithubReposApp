////
////  NetworkEngine.swift
////  GitRepo
////
////  Created by Islam Elgaafary on 09/05/2021.
////


import Foundation


/// Network Engine class to call HTTP requests
///
/// - M: the enum implements `TargetType` protocol to pass HTTP request data
class NetworkEngine<M:TargetType> {
    
    /// Access the singleton instance
    let spinner = PrivateSwiftSpinner.shared
    
    /// Access the singleton instance
    let notificationBanner = PrivateNotificationBannerSwift.shared
    
    
    /// Call HTTP request
    ///
    /// - Parameters:
    ///   - target: the enum's case implements `TargetType` protocol to pass HTTP request data
    ///   - completion: return the `Result` of HTTP request to be :
    ///     if `success`, return `T` which class or struct confirms `Codable`
    ///     if `failure`, return `E` which class or struct confirms `Error`
    func request<T:Codable, E:Error>(target:M, completion: @escaping (Result<T,E>) -> ()){
        spinner.show()
        /// Instance of `URLComponents`
        var urlComponent = URLComponents(string: "\(target.baseURL)\(target.path)")
        
        /// Add HTTP request parameters by append `URLQueryItem` instance from
        /// current `target`'s `params`
        target.params.forEach({ (key: String, value: Any) in
            urlComponent?.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
        })
        
        ///Instance of `URLRequest` and set `httpMethod` from `target`'s method
        var request = URLRequest(url: (urlComponent?.url)!)
        request.httpMethod = target.method.rawValue
        
        
        let session = URLSession(configuration: .default)
        
            let dataTask = session.dataTask(with: request) {  data, response, error in
                let httpResponse = response as? HTTPURLResponse
                
                guard error == nil else {
                    let customError = ErrorResponse(code: httpResponse!.statusCode)
                    self.spinner.hide()
                    self.notificationBanner.show(title: "Error", subtitle: customError.message, style: .danger)
                    completion(.failure(customError as! E))
                    return
                }
                
                DispatchQueue.main.async {
                    /// Check Response status code
                    self.spinner.hide()
                    switch httpResponse!.statusCode {
                    case 200...299: // Success
                        guard let responseObj = try? JSONDecoder().decode(T.self, from: data!) else {
                            let customError = ErrorResponse(code: httpResponse!.statusCode)
                            self.notificationBanner.show(title: "Error", subtitle: customError.message, style: .danger)
                            completion(.failure(customError as! E))
                            return
                        }
                        completion(.success(responseObj))
                    default:
                        let customError = ErrorResponse(code: httpResponse!.statusCode)
                        self.notificationBanner.show(title: "Error", subtitle: customError.message, style: .danger)
                        completion(.failure(customError as! E))
                    }
                }
            }
            
            dataTask.resume()

    }
 
    
}



//MARK:- Custom Error
struct ErrorResponse:Error {
    let code:Int
    var message:String {
        return handleErrorRespose(errorCode: code)
    }
    
    init(code:Int) {
        self.code = code
    }
    
    
    /// Handle Error response domain from HTTP reposnse's status code
    ///
    /// - Parameters:
    ///   - errorCode: HTTP reposnse's status code
    /// - Returns: The domain of error code
     private func handleErrorRespose(errorCode:Int) -> String {
        switch errorCode {
        case 400:
            return "Bad Request"
        case 401:
            return "Unauthorized Request"
        case 403:
            return "Forbidden Request"
        case 404:
            return "Request NotFound"
        case 413:
            return "Payload Too large"
        case 500:
            return "Internal Server Error"
        default:
            return "Unknown error"
        }
    }
    
}
