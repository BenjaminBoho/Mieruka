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
    
    func GET(completion: @escaping (Result<[TodoList], Error>) -> Void) {
        let apiURL = "https://localhost:7263/api/TodoApp/list"
        guard let url = URL(string: apiURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        session.configuration.shouldUseExtendedBackgroundIdleMode = true
        session.configuration.timeoutIntervalForRequest = 30
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "No data or no response", code: 0, userInfo: nil)))
                return
            }
            
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let items = try decoder.decode([TodoListHeader].self, from: data)
                    completion(.success(items.map{ TodoList(header: $0)}))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "Server Error", code: response.statusCode, userInfo: nil)))
            }
        }
        task.resume()
    }
    
    func POST(todoList: TodoList, completion: @escaping (Result<Void, Error>) -> Void) {
        let apiURL = "https://localhost:7263/api/TodoApp/InsertList"
        guard let url = URL(string: apiURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(todoList)
            
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
            session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            session.configuration.shouldUseExtendedBackgroundIdleMode = true
            session.configuration.timeoutIntervalForRequest = 30
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "No response", code: 0, userInfo: nil)))
                    return
                }
                
                if response.statusCode == 200 {
                    completion(.success(()))
                } else {
                    completion(.failure(NSError(domain: "Server Error", code: response.statusCode, userInfo: nil)))
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func GETTasks(completion: @escaping (Result<[TodoTask], Error>) -> Void) {
        let apiURL = "https://localhost:7263/api/TodoApp/task"
        guard let url = URL(string: apiURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        session.configuration.shouldUseExtendedBackgroundIdleMode = true
        session.configuration.timeoutIntervalForRequest = 30

        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "No data or no response", code: 0, userInfo: nil)))
                return
            }

            if response.statusCode == 200 {
                // Print the JSON response data before decoding
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: \(jsonString)")
                }

                do {
                    let decoder = JSONDecoder()
                    let taskHeaders = try decoder.decode([TodoTaskHeader].self, from: data)
                    let tasks = taskHeaders.map { header in
                        return TodoTask(id: header.id, tasks: header.tasks, completed: header.completed)
                    }
                    
                    completion(.success(tasks))
                } catch {
                    completion(.failure(error))
                }

            } else {
                completion(.failure(NSError(domain: "Server Error", code: response.statusCode, userInfo: nil)))
            }
        }
        task.resume()
    }

    
    func POSTTodoTask(todoTask: TodoTaskHeader, completion: @escaping (Result<Void, Error>) -> Void) {
        let apiURL = "https://localhost:7263/api/TodoApp/InsertTask"
        guard let url = URL(string: apiURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(todoTask)
            
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
            session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            session.configuration.shouldUseExtendedBackgroundIdleMode = true
            session.configuration.timeoutIntervalForRequest = 30
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "No response", code: 0, userInfo: nil)))
                    return
                }
                
                if response.statusCode == 200 {
                    completion(.success(()))
                } else {
                    completion(.failure(NSError(domain: "Server Error", code: response.statusCode, userInfo: nil)))
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }

}
