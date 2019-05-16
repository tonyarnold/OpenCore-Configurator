import AppKit
import OrderedDictionary

final class DocumentSplitViewController: NSSplitViewController {
    override var representedObject: Any? {
        didSet {
            children.setEach(\.representedObject, to: representedObject)
        }
    }

    var masterViewController: ConfigurationMasterViewController? {
        return splitViewItems
            .first { $0.viewController is ConfigurationMasterViewController }?
            .viewController as? ConfigurationMasterViewController
    }

    var detailViewController: ConfigurationDetailViewController? {
        return splitViewItems
            .first { $0.viewController is ConfigurationDetailViewController }?
            .viewController as? ConfigurationDetailViewController
    }

    var masterSelectionChangedToken: NotificationToken<AnyObject>?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard
            let masterViewController = masterViewController,
            let detailViewController = detailViewController
        else {
            preconditionFailure()
        }

        let sortedKeysAndValue = detailViewController.tabViewItems
            .compactMap(\.viewController)
            .compactMap { $0 as? CategoryRepresenting }
            .grouped(by: \.category)
            .compactMapValues { $0 as? [NSViewController] }

        var categorizedViewControllers = OrderedDictionary(sortedKeysAndValue)
        categorizedViewControllers.sort { $0.key.indexInAllCases < $1.key.indexInAllCases }
        masterViewController.categorizedViewControllers = categorizedViewControllers

        masterSelectionChangedToken = NotificationCenter.default.observe(name: NSOutlineView.selectionDidChangeNotification, object: masterViewController.outlineView) { notification in
            guard
                let outlineView = notification.object as? NSOutlineView,
                let selectedItem = outlineView.selectedItem as? NSViewController,
                let detailViewController = self.detailViewController,
                let selectionIndex = detailViewController.tabView.tabViewItems.firstIndex(where: { $0.viewController == selectedItem })
            else {
                return
            }

            detailViewController.tabView.selectTabViewItem(at: selectionIndex)
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        (segue.destinationController as? NSViewController)?.representedObject = representedObject
    }
}

extension Configuration.Category {
    var indexInAllCases: Int {
        return Configuration.Category.allCases.firstIndex(of: self)!
    }
}
