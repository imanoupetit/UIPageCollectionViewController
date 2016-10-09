
import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        dataLabel.text = dataObject
    }

}
