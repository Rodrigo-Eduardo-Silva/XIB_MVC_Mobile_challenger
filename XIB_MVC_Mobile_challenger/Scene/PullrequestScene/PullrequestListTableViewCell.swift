import Kingfisher
import UIKit

class PullrequestListTableViewCell: UITableViewCell {
    static let identifier = String(describing: PullrequestListTableViewCell.self)
    let saveModel = SaveModel()

    @IBOutlet weak var SaveButton: UIButton!
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
    func preparePullrequest(with pullrequest: PullRequest) {
        titleLabel.text = pullrequest.title
        if let bodyPullrequest = pullrequest.user.body {
            bodyLabel.text = bodyPullrequest
        } else {
            bodyLabel.text = " Just a PullRequest Body"
        }
        if let url = URL(string: pullrequest.user.avatar_url) {
            avatarPullimage.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
        }
    }

    @IBAction func Save(_ sender: Any) {

    }
}
