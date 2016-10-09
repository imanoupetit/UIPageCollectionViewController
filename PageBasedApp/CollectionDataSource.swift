
import UIKit

private let reuseIdentifier = "Cell"

class CollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let model: [String]
    var resetPageViewController: ((Int, UIPageViewControllerNavigationDirection) -> Void)?
    
    // MARK: Initializer
    
    init(withModel model: [String]) {
        self.model = model
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        // Set display for cell
        cell.label.text = model[indexPath.row]
        cell.toggleBorderWidth()
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // Center the corresponding cell
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        // When cell is tapped, force pageViewController to present the correct associated page with correct animation
        if let previousIndex = collectionView.indexPathsForSelectedItems?.last {
            switch previousIndex.compare(indexPath) {
            case .orderedAscending:     resetPageViewController?(indexPath.row, .forward)
            case .orderedDescending:    resetPageViewController?(indexPath.row, .reverse)
            default:                    break
            }
        }
        
        return true
    }
    
}
