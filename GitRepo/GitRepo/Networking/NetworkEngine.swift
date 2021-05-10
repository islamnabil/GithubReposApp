////
////  NetworkEngine.swift
////  GitRepo
////
////  Created by Islam Elgaafary on 09/05/2021.
////


import Foundation

class NetworkEngine<M:TargetType> {
    
     func request<T:Codable>(target:M, completion: @escaping (Result<T,Error>) -> ()){
        var urlComponent = URLComponents(string: "\(target.baseURL)\(target.path)")
        
        target.params.forEach({ (key: String, value: Any) in
            urlComponent?.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
        })
        
        var urlRequest = URLRequest(url: (urlComponent?.url)!)
        urlRequest.httpMethod = target.method.rawValue
        
        let session = URLSession(configuration: .default)
        
            let dataTask = session.dataTask(with: urlRequest) {  data, response, error in
                let httpResponse = response as? HTTPURLResponse
                
                guard error == nil else {
                    completion(.failure(error!))
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                DispatchQueue.main.async {
                    //MARK:- Check Response status code
                    switch httpResponse!.statusCode {
                    case 200...299: // Success
                        guard let responseObj = try? JSONDecoder().decode(T.self, from: data!) else {
                            // ADD Custom Error
                            completion(.failure(error!))
                            
                            return
                        }
                        completion(.success(responseObj))
                    default:
                        completion(.failure(response as! Error))
                    }
                }
                
            }
            
            dataTask.resume()
      
        
    }
 
    
}

//MARK:- NetworkEngine Methods
extension NetworkEngine {
    
    class func handleErrorRespose(errorCode:Int) -> String {
        switch errorCode {
        case 400:
            return "Bad Request"
        case 401:
            return "Unauthorized"
        case 403:
            return "Forbidden"
        case 404:
            return "NotFound"
        case 413:
            return "Payload Too large"
        case 500:
            return "Internal Server Error"
        default:
            return "Unknown error"
        }
    }
    
}
