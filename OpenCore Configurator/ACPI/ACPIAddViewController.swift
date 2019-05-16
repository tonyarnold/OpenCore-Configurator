import AppKit

final class ACPIAddViewController: NSViewController, CategoryRepresenting {
    let category: Configuration.Category = .acpi

    override var representedObject: Any? {
        didSet {
            guard let configuration = representedObject as? Configuration else {
                return
            }

            acpi = configuration.acpi
        }
    }

    var acpi: ACPI? {
        didSet {
            guard isViewLoaded else {
                return
            }

            tableView.reloadData()
        }
    }

    @IBOutlet var tableView: NSTableView!
    @IBOutlet var addRemoveButton: NSSegmentedControl!

    @IBAction func handleSegmentedControlAction(_ sender: NSSegmentedControl) {
        switch sender.selectedSegment {
        case 0:
            insert(sender)
        case 1:
            delete(sender)
        default:
            break
        }
    }

    @IBAction func insert(_ sender: Any) {
        let index: NSInteger

        // Ensure that we insert new pages after the user's current selection
        if let selectedIndex = tableView.selectedRowIndexes.last, selectedIndex >= 0 {
            index = selectedIndex + 1
        } else {
            index = 0
        }

        acpi?.additions?.insert(.init(), at: index)
        tableView.animator().insertRows(at: IndexSet(integer: index), withAnimation: [.effectFade, .effectGap])
    }

    @IBAction func delete(_ sender: Any) {
        // Remove each row in reverse order so that we don't have to adjust the index as we mutate the array
        tableView.selectedRowIndexes.reversed().forEach {
            acpi?.additions?.remove(at: $0)
            tableView.animator().removeRows(at: IndexSet(integer: $0), withAnimation: [.effectFade, .effectGap])
        }
    }

    @IBAction func scanAvailableFiles(_ sender: Any) {}

    override func viewDidLoad() {
        super.viewDidLoad()

        addRemoveButton.setEnabled(tableView.selectedRowIndexes.isEmpty == false, forSegment: 1)
    }

    func validateUserInterfaceItem(_ item: NSValidatedUserInterfaceItem) -> Bool {
        switch item.action {
        case #selector(delete(_:)):
            // Disable the delete button when there is nothing selected
            return tableView.selectedRowIndexes.isEmpty == false

        default:
            return true
        }
    }
}

extension ACPIAddViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return acpi?.additions?.count ?? 0
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return acpi?.additions?[row]
    }
}

extension ACPIAddViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        // Disable the delete button when there is nothing selected
        addRemoveButton.setEnabled(tableView.selectedRowIndexes.isEmpty == false, forSegment: 1)
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let columnIdentifier = tableColumn?.identifier else {
            return nil
        }

        let view = tableView.makeView(withIdentifier: columnIdentifier, owner: self)

        switch columnIdentifier {
        case NSUserInterfaceItemIdentifier.comment:
            guard let cell = view as? TextEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Addition)?.comment }
            cell.handleValueChange = { ($0 as? ACPI.Addition)?.comment = $1 }

        case NSUserInterfaceItemIdentifier.enabled:
            guard let cell = view as? BooleanEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Addition)?.isEnabled }
            cell.handleValueChange = { ($0 as? ACPI.Addition)?.isEnabled = $1 }

        case NSUserInterfaceItemIdentifier.path:
            guard let cell = view as? TextEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Addition)?.path }
            cell.handleValueChange = { ($0 as? ACPI.Addition)?.path = $1 }

        default:
            break
        }
        return view
    }
}
