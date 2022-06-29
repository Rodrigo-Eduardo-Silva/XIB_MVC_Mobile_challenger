import Foundation
class PullRequestListService {
    private let basePath = "https://api.github.com/search/repositories?"
    private let privateToken = "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"
    private let teste = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
    private let per_page = 25
    private let session: URLSession
    init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Authorization": "\(privateToken)", "Accept": "application/json"]
        config.timeoutIntervalForRequest = 5
        session = URLSession(configuration: config)
    }
    func loadPullRequest(page: Int, owner: String, repository: String, completion: @escaping ([PullRequest]?) -> Void) {
        let query = "https://api.github.com/repos/\(owner)/\(repository)/pulls?page=\(page)&per_page=\(per_page)"
        print(query)
        guard let url = URL(string: query) else {return}
        let dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do {
                        let pullrequest = try JSONDecoder().decode([PullRequest].self, from: data)
                        completion(pullrequest)
                     } catch {
                        print(error.localizedDescription)
                        print("Json error")
                    }
                } else {
                    print("Problema no servidor Pull")
                    print(query)
                }
            } else {
                print(error as Any)
            }
        }
        dataTask.resume()
    }
}
