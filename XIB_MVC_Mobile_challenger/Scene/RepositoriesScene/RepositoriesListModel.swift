import Foundation
import SwiftUI

protocol RepositoriesListModelDelegate: AnyObject {
    func updateRepositoriesModel()
}

class RepositoriesListModel {
    private(set) var repositories: [GitRepository] = []
    weak var delegate: RepositoriesListModelDelegate?
    let service: RepositoriesListService
    var currentPage: Int
    var totalrepository: Int
    var rechargeList: Bool

    init(service: RepositoriesListService = RepositoriesListService()) {
        self.service = service
        self.currentPage = 1
        totalrepository = 1
        rechargeList = false
    }
    func loadRepositories() {
        rechargeList = true
        RepositoriesListService().loadRepositories(page: currentPage) { [weak self] repository in
            if let repository = repository {
                self?.repositories += repository.items
                self?.totalrepository = repository.total_count
           }
             self?.delegate?.updateRepositoriesModel()
        }
    }
}
