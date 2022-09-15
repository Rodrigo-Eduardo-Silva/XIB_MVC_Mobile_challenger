import Foundation
import UIKit
protocol RepositoriesListServiceDelegate: AnyObject {
    func showMessage(message: String)
}

class RepositoriesListService {
    weak var delegate: RepositoriesListServiceDelegate?
    private let basePath = "https://api.github.com/search/repositories?"
    private let privateToken = "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"
    private let teste = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    private let perPage = 10
    private let session: URLSession
    init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": "\(privateToken)", "Accept": "application/json"]
        config.timeoutIntervalForRequest = 5
        session = URLSession(configuration: config)
    }
    func loadRepositories(page: Int, language: String, completion: @escaping (GitHead?) -> Void) {
        let query = basePath + "q=language:\(language)&sort=stars&page=\(page)&per_page=\(perPage)"
        guard let url = URL(string: query) else {return}
        let dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do {
                        let repositories = try JSONDecoder().decode(GitHead.self, from: data)
                        completion(repositories)
                    } catch {
                        print(error.localizedDescription)
                        print("Json error")
                    }
                } else {
                    print("Problema no servidor")
                    print(query)
                }
            } else {
                print(error as Any)
                self.delegate?.showMessage(message: error?.localizedDescription ?? "Sem internet")
            }
        }
        dataTask.resume()
    }

}
