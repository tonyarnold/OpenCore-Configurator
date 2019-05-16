import AppKit

final class ACPIQuirksViewController: NSViewController, CategoryRepresenting {
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
            self.updateState(with: acpi?.quirks)
        }
    }

    @IBOutlet var fadtEnableResetButton: NSButton!
    @IBOutlet var ignoreForWindowsButton: NSButton!
    @IBOutlet var normalizeHeadersButton: NSButton!
    @IBOutlet var rebaseRegionsButton: NSButton!
    @IBOutlet var resetLogoStatusButton: NSButton!

    @IBAction func handleCheckboxToggle(_ sender: NSButton) {
        switch sender {
        case fadtEnableResetButton:
            acpi?.quirks?.fadtEnableReset = sender.state == .on

        case ignoreForWindowsButton:
            acpi?.quirks?.ignoreForWindows = sender.state == .on

        case normalizeHeadersButton:
            acpi?.quirks?.normalizeHeaders = sender.state == .on

        case rebaseRegionsButton:
            acpi?.quirks?.rebaseRegions = sender.state == .on

        case resetLogoStatusButton:
            acpi?.quirks?.resetLogoStatus = sender.state == .on

        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateState(with: acpi?.quirks)
    }

    private func updateState(with quirks: ACPI.Quirks?) {
        guard isViewLoaded else {
            return
        }

        guard let quirks = acpi?.quirks else {
            return
        }

        fadtEnableResetButton.state = quirks.fadtEnableReset ?? false ? .on : .off
        ignoreForWindowsButton.state = quirks.ignoreForWindows ?? false ? .on : .off
        normalizeHeadersButton.state = quirks.normalizeHeaders ?? false ? .on : .off
        rebaseRegionsButton.state = quirks.rebaseRegions ?? false ? .on : .off
        resetLogoStatusButton.state = quirks.resetLogoStatus ?? false ? .on : .off
    }
}
