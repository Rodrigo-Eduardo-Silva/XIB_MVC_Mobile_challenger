import UIKit
import SafariServices

class PullrequestListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var repository: GitRepository
    var model: PullRequestListModel?

    init(navigationController: UINavigationController, repository: GitRepository) {
        self.navigationController = navigationController
        self.repository = repository
    }

    func start() {
        let viewController = makePullrequest(repository: repository)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func makePullrequest(repository: GitRepository) -> PullrequestListViewController {
        let model = PullRequestListModel(gitRepository: repository, service: PullRequestListService())
        let viewController = PullrequestListViewController(model: model)
        viewController.pullmodel = model
        model.delegate = viewController
        viewController.delegate = self
        return viewController
    }
}
extension PullrequestListCoordinator: PullrequestListViewControllerDelegate {
    func showDetailPullrequest(url: URL) {
        let webviewController = SFSafariViewController(url: url)
        navigationController.pushViewController(webviewController, animated: true)
    }
}
