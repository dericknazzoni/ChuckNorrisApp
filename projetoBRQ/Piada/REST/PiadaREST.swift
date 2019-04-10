//
//  REST.swift
//  projetoBRQ
//
//  Created by Derick Nazzoni on 08/04/19.
//  Copyright © 2019 Derick Nazzoni. All rights reserved.
//
import Foundation

enum JokeError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class PiadaREST {

    private static let basePath = "https://api.chucknorris.io/jokes/random?category=\(Global.name)"
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()

    private static let session = URLSession(configuration: configuration)


    class func loadJokes(onComplete: @escaping (Piada) -> Void, onError: @escaping (JokeError) -> Void){
        guard let url = URL(string: basePath) else {
            return onError(.url)
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?,error: Error?) in
            if error == nil{
                guard let response = response as? HTTPURLResponse else{
                    return onError(.noResponse)

                }
                if response.statusCode == 200{
                    guard let data = data else {
                        return onError(.noData)
                    }
                    do{
                        
                        let piadas = try JSONDecoder().decode(Piada.self, from: data)
                        onComplete(piadas)
                        
                    } catch{
                        print(error)
                        onError(.invalidJSON)
                    }

                }else{
                    onError(.responseStatusCode(code: response.statusCode))
                }

            }
            else{
                return onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }

}
