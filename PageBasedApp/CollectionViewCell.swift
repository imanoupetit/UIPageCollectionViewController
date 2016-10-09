
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override var isSelected: Bool {
        didSet {
            toggleBorderWidth()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .lightGray : .clear
        }
    }
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderColor = UIColor.orange.cgColor
    }
    
    // MARK: - Custom method
    
    func toggleBorderWidth() {
        contentView.layer.borderWidth = isSelected ? 5 : 0
    }

}
