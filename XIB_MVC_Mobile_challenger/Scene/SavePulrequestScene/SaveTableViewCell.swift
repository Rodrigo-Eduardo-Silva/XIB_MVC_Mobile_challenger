import UIKit
import Kingfisher
class SaveTableViewCell: UITableViewCell {
    static let identifier = String(describing: SaveTableViewCell.self)

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

    func preparePullrequestSaved(with pullrequest: PullrequestSaved) {
        titleLabel.text = pullrequest.title
        bodyLabel.text = pullrequest.body == "" ? bodyLabel.text : "Just Pullrequest body"
        if let url = URL(string: pullrequest.avatar_url ?? "None") {
            avatarPullimage.kf.setImage(with: url,
                                        placeholder: UIImage(named: "person.wave.2.fill"),
                                        options: nil,
                                        completionHandler: nil)
            avatarPullimage.layer.cornerRadius = avatarPullimage.frame.size.height/2
        }

    }
}
