import Foundation
protocol PullRequestListModelDelegate: AnyObject {
    func updatePullRequest()
}

class PullRequestListModel {
    var pullrequest: [PullRequest] = []
    weak var delegate: PullRequestListModelDelegate?
    let service: PullRequestListService
    var currentPage: Int
    var totalpullrequest: Int
    var rechargeList: Bool
    var gitRepository: GitRepository
    init(gitRepository: GitRepository, service: PullRequestListService) {
        self.gitRepository = gitRepository
        self.service = service
        self.currentPage = 1
        totalpullrequest = 1
        rechargeList = false
    }
    func loadPullRequest() {
        rechargeList = true
        service.loadPullRequest(page: currentPage,
                                owner: gitRepository.owner.login,
                                repository: gitRepository.name) { pull in
                if let pull = pull {
                    self.pullrequest += pull
                    self.totalpullrequest = pull.count
                }
                self.delegate?.updatePullRequest()
        }
    }
}
