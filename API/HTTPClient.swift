//
//  Connect.swift
//  Mieruka
//
//  Created by れい on 2023/10/02.
//

import Foundation

class API: NSObject, URLSessionDelegate  {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            }
        }
    
    func GET(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let apiURL = "https://localhost:7263/api/TodoApp/list"
        guard let url = URL(string: apiURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
                session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
                session.configuration.shouldUseExtendedBackgroundIdleMode = true
                session.configuration.timeoutIntervalForRequest = 30

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("No data or no response")
                return
            }

            if response.statusCode == 200 {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                    print("Failed to parse JSON response")
                    return
                }
                print(json)
            } else {
                print("Server Error status code: \(response.statusCode)")
            }
        }
        task.resume()
    }
}

func fetchTodoList() {
    API().GET { result in
        switch result {
        case .success(let json):
            print("JSON Response: \(json)")
        case .failure(let error):
            print("Failed to fetch todo items: \(error.localizedDescription)")
        }
    }
}
