import Kingfisher
import UIKit

class PullrequestListTableViewCell: UITableViewCell {
    static var filename: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: filename, bundle: nil)
    }
    static var cell: String {
        return "mycellpull"
    }
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

}
