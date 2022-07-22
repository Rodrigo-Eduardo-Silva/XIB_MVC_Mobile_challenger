import UIKit
import Kingfisher

class RepositoriesListTableViewCell: UITableViewCell {
    static var filename: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: filename, bundle: nil)
    }
    static var cell: String {
        return "mycell"
    }

    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepareRepositoryCell(with repository: GitRepository) {
        repositoryNameLabel.text = repository.name
        descriptionLabel.text = repository.description
        forksLabel.text = String(repository.forks)
        starsLabel.text = String(repository.stargazers_count)
        userNameLabel.text = repository.full_name
        if let url = URL(string: repository.owner.avatar_url) {
            avatarImage.kf.setImage(with: url, placeholder: UIImage(named: "person.wave.2.fill"), options: nil, completionHandler: nil)
            avatarImage.layer.cornerRadius = avatarImage.frame.size.height/2
        }
    }
}
