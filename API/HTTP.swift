//
//  HTTP.swift
//  Mieruka
//
//  Created by れい on 2023/11/08.
//

import Foundation

class API: NSObject, URLSessionDelegate  {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        }
    }
    
    private func performRequest<T: Codable>(_ url: URL, method: String, body: Data? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = body {
            request.httpBody = body
        }

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
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "Server Error", code: response.statusCode, userInfo: nil)))
            }
        }
        task.resume()
    }
    
    private func makeURL(path: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "localhost"
        components.port = 7263
        components.path = path
        components.queryItems = queryItems

        return components.url
    }

    
    func GET(completion: @escaping (Result<[TodoListHeader], Error>) -> Void) {
        guard let url = makeURL(path: "/api/TodoApp/list") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        performRequest(url, method: "GET", completion: completion)
    }


    func GETTasks(listId: String, completion: @escaping (Result<[TodoTask], Error>) -> Void) {
        guard let url = makeURL(path: "/api/TodoApp/task", queryItems: [URLQueryItem(name: "listId", value: listId)]) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        performRequest(url, method: "GET", completion: completion)
    }

    func POST(todoList: TodoList, completion: @escaping (Result<TodoListHeader, Error>) -> Void)
    {
        guard let url = makeURL(path: "/api/TodoApp/InsertList") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let listData = try encoder.encode(todoList)
            performRequest(url, method: "POST", body: listData, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }

    func POSTTodoTask(todoTask: TodoTask, completion: @escaping (Result<TodoTaskHeader, Error>) -> Void) {
        guard let url = makeURL(path: "/api/TodoApp/InsertTask") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let taskData = try encoder.encode(todoTask)
            performRequest(url, method: "POST", body: taskData, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }

    func updateListName(list: TodoList, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = makeURL(path: "/api/TodoApp/listUpdate", queryItems: [URLQueryItem(name: "id", value: list.id)]) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let listData = try encoder.encode(list)
            performRequest(url, method: "PUT", body: listData) { (result: Result<TodoListHeader, Error>) in
                switch result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }


    func updateTask(task: TodoTask, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = makeURL(path: "/api/TodoApp/taskUpdate", queryItems: [URLQueryItem(name: "id", value: task.id)]) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let taskData = try encoder.encode(task)
            performRequest(url, method: "PUT", body: taskData) { (result: Result<TodoTaskHeader, Error>) in
                switch result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

    func updateTaskCompleted<T: Codable>(taskID: String, completed: Bool, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = makeURL(path: "/api/TodoApp/taskUpdateCompleted/\(taskID)", queryItems: [URLQueryItem(name: "completed", value: "\(completed)")]) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        performRequest(url, method: "PUT") { (result: Result<T, Error>) in
            completion(result)
        }
    }


    
    func deleteTask(taskID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = makeURL(path: "/api/TodoApp/task/\(taskID)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        performRequest(url, method: "DELETE") { (result: Result<Data, Error>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteList(listID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = makeURL(path: "/api/TodoApp/list/\(listID)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        performRequest(url, method: "DELETE") { (result: Result<Data, Error>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
