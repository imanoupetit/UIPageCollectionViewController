
import UIKit

class MasterViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    let monthsArray = DateFormatter().monthSymbols!
    lazy var collectionDataSource = {
        return CollectionDataSource(withModel: self.monthsArray)
    }()
    lazy var pageDataSource = {
        return PageDataSource(model: self.monthsArray)
    }()
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = collectionDataSource
        collectionView.delegate = collectionDataSource
        
        // Pass closure to collection view data source: when we tap a cell, update the pageViewController
        let resetPageViewController = { [unowned self] (index: Int, direction: UIPageViewControllerNavigationDirection) -> Void in
            guard let pagedViewController = self.pageDataSource.pagedViewController(at: index, storyboard: self.storyboard!) else { return }
            let pageViewController = self.childViewControllers.first as? PageViewController
            pageViewController?.setViewControllers([pagedViewController], direction: direction, animated: true, completion: nil)
        }
        collectionDataSource.resetPageViewController = resetPageViewController

        
        // Select first cell to kick things off
        let indexPath = IndexPath(item: 0, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pageViewController = segue.destination as! PageViewController
        pageViewController.pageDataSource = pageDataSource
        
        // Pass a closure to pageDataSource: when swipe is finished on a page, update the collectionView
        let updateCollectionView = { [unowned self] (indexPath: IndexPath) -> Void in
            self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
        pageViewController.pageDataSource.updateCollectionView = updateCollectionView
    }
    
}
