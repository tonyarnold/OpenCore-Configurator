import AppKit
import OrderedDictionary

final class ConfigurationMasterViewController: NSViewController {
    var categorizedViewControllers: OrderedDictionary<Configuration.Category, [NSViewController]> = [:] {
        didSet {
            guard isViewLoaded else { return }
            outlineView.reloadData()
            outlineView.expandItem(nil, expandChildren: true)
            outlineView.selectRowIndexes(IndexSet(integer: 1), byExtendingSelection: false)
        }
    }

    @IBOutlet var outlineView: NSOutlineView!
}

extension ConfigurationMasterViewController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        switch item {
        case let category as Configuration.Category:
            return categorizedViewControllers[category]?.count ?? 0

        case nil:
            return categorizedViewControllers.count

        default:
            return 0
        }
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        switch item {
        case let category as Configuration.Category:
            return categorizedViewControllers[category]![index]

        case nil:
            return categorizedViewControllers[index].key

        default:
            preconditionFailure()
        }
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return item is Configuration.Category
    }

    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        switch item {
        case is Configuration.Category:
            return outlineView.makeView(withIdentifier: .categoryHeaderCell, owner: self)

        case is NSViewController:
            return outlineView.makeView(withIdentifier: .categoryDataCell, owner: self)

        default:
            preconditionFailure()
        }
    }

    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        return item
    }
}

extension ConfigurationMasterViewController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        return item is Configuration.Category
    }

    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        return item is NSViewController
    }
}
