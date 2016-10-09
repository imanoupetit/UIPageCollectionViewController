
import UIKit

private let identifier = "DataViewController"

class PageDataSource: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let model: [String]
    var updateCollectionView: ((IndexPath) -> Void)?
    
    // MARK: Initializer

    init(model: [String]) {
        self.model = model
    }
    
    // MARK: Custom methods
    
    func pagedViewController(at index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Early exit if pageData.count is 0 or if index is out of bounds
        if !model.indices.contains(index) { return nil }
        
        // Create a new view controller and pass suitable data
        let dataViewController = storyboard.instantiateViewController(withIdentifier: identifier) as! DataViewController
        dataViewController.dataObject = model[index]
        return dataViewController
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! DataViewController
        guard let index = model.index(of: vc.dataObject), let storyboard = viewController.storyboard else { return nil }
        return pagedViewController(at: index - 1, storyboard: storyboard)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! DataViewController
        guard let index = model.index(of: vc.dataObject), let storyboard = viewController.storyboard else { return nil }
        return pagedViewController(at: index + 1, storyboard: storyboard)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return model.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        // When we toggle a new page from collectionView, we need to make pageControl index match correct index
        if let vc = pageViewController.viewControllers?.last as? DataViewController, let index = model.index(of: vc.dataObject) {
            return index
        }
        return 0
    }
    
    // MARK: UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // completed property indicates when swipe is terminated (not aborted)
        if completed, let vc = pageViewController.viewControllers?.last as? DataViewController, let index = model.index(of: vc.dataObject) {
            // Update the collectionView with the new index
            updateCollectionView?(IndexPath(item: index, section: 0))
        }
    }
    
}
