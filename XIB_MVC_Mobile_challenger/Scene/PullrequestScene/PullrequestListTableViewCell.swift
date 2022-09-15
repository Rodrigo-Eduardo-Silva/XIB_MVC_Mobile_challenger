import Kingfisher
import UIKit
// swiftlint:disable line_length
protocol PullrequestListTableViewCellDelegate: AnyObject {
    func save(index: Int)
}

class PullrequestListTableViewCell: UITableViewCell {
    static let identifier = String(describing: PullrequestListTableViewCell.self)
    let saveModel = SaveModel()
    weak var delegate: PullrequestListTableViewCellDelegate?
    private var index: Int = -1
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var avatarPullimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func preparePullrequest(with pullrequest: PullRequest, at index: Int) {
        self.index = index
        titleLabel.text = pullrequest.title
        if let bodyPullrequest = pullrequest.user.body {
            bodyLabel.text = bodyPullrequest
        } else {
            bodyLabel.text = " Just a PullRequest Body"
        }

        if let url = URL(string: pullrequest.user.avatar_url) {
            avatarPullimage.kf.setImage(with: url, placeholder: UIImage(named: "person.wave.2.fill"), options: nil, completionHandler: nil)
            avatarPullimage.layer.cornerRadius = avatarPullimage.frame.size.height/2
        }
    }

    @IBAction func save(_ sender: Any) {
        delegate?.save(index: index)
        saveButton.isEnabled = false
    }
}
