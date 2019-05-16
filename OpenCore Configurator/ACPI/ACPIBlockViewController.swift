import AppKit

final class ACPIBlockViewController: NSViewController, CategoryRepresenting {
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

        acpi?.blocks?.insert(.init(), at: index)
    }

    @IBAction func delete(_ sender: Any) {
        // Remove each row in reverse order so that we don't have to adjust the index as we mutate the array
        tableView.selectedRowIndexes.reversed().forEach { acpi?.blocks?.remove(at: $0) }
    }

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

extension ACPIBlockViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return acpi?.blocks?.count ?? 0
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return acpi?.blocks?[row]
    }
}

extension ACPIBlockViewController: NSTableViewDelegate {
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
        case NSUserInterfaceItemIdentifier.all:
            guard let cell = view as? BooleanEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Block)?.blockAll }
            cell.handleValueChange = { ($0 as? ACPI.Block)?.blockAll = $1 }

        case NSUserInterfaceItemIdentifier.comment:
            guard let cell = view as? TextEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Block)?.comment }
            cell.handleValueChange = { ($0 as? ACPI.Block)?.comment = $1 }

        case NSUserInterfaceItemIdentifier.enabled:
            guard let cell = view as? BooleanEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Block)?.isEnabled }
            cell.handleValueChange = { ($0 as? ACPI.Block)?.isEnabled = $1 }

        case NSUserInterfaceItemIdentifier.oemTableId:
            guard let cell = view as? DataEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Block)?.oemTableIdentifier }
            cell.handleValueChange = { ($0 as? ACPI.Block)?.oemTableIdentifier = $1 }

        case NSUserInterfaceItemIdentifier.tableLength:
            guard let cell = view as? NumberEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = {
                guard let number = ($0 as? ACPI.Block)?.tableLength else {
                    return nil
                }

                return NSNumber(value: number)
            }

            cell.handleValueChange = { ($0 as? ACPI.Block)?.tableLength = $1?.intValue }

        case NSUserInterfaceItemIdentifier.tableSignature:
            guard let cell = view as? DataEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Block)?.tableSignature }
            cell.handleValueChange = { ($0 as? ACPI.Block)?.tableSignature = $1 }

        default:
            break
        }
        return view
    }
}
