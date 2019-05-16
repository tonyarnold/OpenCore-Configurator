import AppKit

final class ACPIPatchViewController: NSViewController, CategoryRepresenting {
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

        acpi?.patches?.insert(.init(), at: index)
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

extension ACPIPatchViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return acpi?.patches?.count ?? 0
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return acpi?.patches?[row]
    }
}

extension ACPIPatchViewController: NSTableViewDelegate {
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

            cell.provideValue = { ($0 as? ACPI.Patch)?.comment }
            cell.handleValueChange = { ($0 as? ACPI.Patch)?.comment = $1 }

        case NSUserInterfaceItemIdentifier.count:
            guard let cell = view as? NumberEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = {
                guard let number = ($0 as? ACPI.Patch)?.count else {
                    return nil
                }

                return NSNumber(value: number)
            }

            cell.handleValueChange = { ($0 as? ACPI.Patch)?.count = $1?.intValue }

        case NSUserInterfaceItemIdentifier.enabled:
            guard let cell = view as? BooleanEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Patch)?.isEnabled }
            cell.handleValueChange = { ($0 as? ACPI.Patch)?.isEnabled = $1 }

        case NSUserInterfaceItemIdentifier.limit:
            guard let cell = view as? NumberEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = {
                guard let number = ($0 as? ACPI.Patch)?.limit else {
                    return nil
                }

                return NSNumber(value: number)
            }

            cell.handleValueChange = { ($0 as? ACPI.Patch)?.limit = $1?.intValue }

        case NSUserInterfaceItemIdentifier.oemTableId:
            guard let cell = view as? DataEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Patch)?.oemTableIdentifier }
            cell.handleValueChange = { ($0 as? ACPI.Patch)?.oemTableIdentifier = $1 }

        case NSUserInterfaceItemIdentifier.mask:
            guard let cell = view as? DataEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Patch)?.mask }
            cell.handleValueChange = { ($0 as? ACPI.Patch)?.mask = $1 }

        case NSUserInterfaceItemIdentifier.replace:
            guard let cell = view as? DataEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Patch)?.replace }
            cell.handleValueChange = { ($0 as? ACPI.Patch)?.replace = $1 }

        case NSUserInterfaceItemIdentifier.replaceMask:
            guard let cell = view as? DataEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Patch)?.replaceMask }
            cell.handleValueChange = { ($0 as? ACPI.Patch)?.replaceMask = $1 }

        case NSUserInterfaceItemIdentifier.skip:
            guard let cell = view as? NumberEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = {
                guard let number = ($0 as? ACPI.Patch)?.skip else {
                    return nil
                }

                return NSNumber(value: number)
            }

            cell.handleValueChange = { ($0 as? ACPI.Patch)?.skip = $1?.intValue }

        case NSUserInterfaceItemIdentifier.tableLength:
            guard let cell = view as? NumberEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = {
                guard let number = ($0 as? ACPI.Patch)?.tableLength else {
                    return nil
                }

                return NSNumber(value: number)
            }

            cell.handleValueChange = { ($0 as? ACPI.Patch)?.tableLength = $1?.intValue }

        case NSUserInterfaceItemIdentifier.tableSignature:
            guard let cell = view as? DataEditingTableCellView else {
                preconditionFailure()
            }

            cell.provideValue = { ($0 as? ACPI.Patch)?.tableSignature }
            cell.handleValueChange = { ($0 as? ACPI.Patch)?.tableSignature = $1 }

        default:
            break
        }

        return view
    }
}
