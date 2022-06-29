import Foundation

class RepositoriesListService {
    private let basePath = "https://api.github.com/search/repositories?"
    private let privateToken = "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"
    private let teste = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    private let per_page = 10
    private let session: URLSession
    init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": "\(privateToken)", "Accept": "application/json"]
        config.timeoutIntervalForRequest = 5
        session = URLSession(configuration: config)
    }
    func loadRepositories(page: Int, completion: @escaping (GitHead?) -> Void) {
        let query = basePath + "q=language:Java&sort=stars&page=\(page)&per_page=\(per_page)"
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
                }
            } else {
                print(error as Any)
            }
        }
        dataTask.resume()
    }
}
