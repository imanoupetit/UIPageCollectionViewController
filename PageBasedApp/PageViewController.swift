
import UIKit

class PageViewController: UIPageViewController {
    
    var pageDataSource: PageDataSource!

    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey: 5])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        dataSource = pageDataSource
        delegate = pageDataSource

        // Push first page to kick things off
        if let startingViewController = pageDataSource.pagedViewController(at: 0, storyboard: storyboard!) {
            setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    
}
