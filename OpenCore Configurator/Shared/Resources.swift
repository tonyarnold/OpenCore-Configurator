import AppKit

extension NSImage {
    static let oCC31024 = NSImage(named: "OCC3-1024")!
    static let oCC3128 = NSImage(named: "OCC3-128")!
    static let oCC316 = NSImage(named: "OCC3-16")!
    static let oCC3256 = NSImage(named: "OCC3-256")!
    static let oCC3257 = NSImage(named: "OCC3-257")!
    static let oCC332 = NSImage(named: "OCC3-32")!
    static let oCC333 = NSImage(named: "OCC3-33")!
    static let oCC3512 = NSImage(named: "OCC3-512")!
    static let oCC3513 = NSImage(named: "OCC3-513")!
    static let oCC364 = NSImage(named: "OCC3-64")!
}

extension NSStoryboard {
    static let aCPIAddViewController = NSStoryboard(name: "ACPIAddViewController", bundle: .main)
    static let aCPIBlockViewController = NSStoryboard(name: "ACPIBlockViewController", bundle: .main)
    static let aCPIPatchViewController = NSStoryboard(name: "ACPIPatchViewController", bundle: .main)
    static let aCPIQuirksViewController = NSStoryboard(name: "ACPIQuirksViewController", bundle: .main)
    static let main = NSStoryboard(name: "Main", bundle: .main)
}

extension NSStoryboard.SceneIdentifier {
    static let aCPIAddViewController = "ACPIAddViewController"
    static let aCPIBlockViewController = "ACPIBlockViewController"
    static let aCPIPatchViewController = "ACPIPatchViewController"
    static let aCPIQuirksViewController = "ACPIQuirksViewController"
    static let acpiPopoverController = "AcpiPopoverController"
    static let configurationDetailViewController = "ConfigurationDetailViewController"
    static let configurationMasterViewController = "ConfigurationMasterViewController"
    static let documentSplitViewController = "DocumentSplitViewController"
    static let documentWindowController = "DocumentWindowController"
    static let kernelPopoverController = "KernelPopoverController"
}

extension NSUserInterfaceItemIdentifier {
    static let all = NSUserInterfaceItemIdentifier(rawValue: "All")
    static let base = NSUserInterfaceItemIdentifier(rawValue: "Base")
    static let categoryDataCell = NSUserInterfaceItemIdentifier(rawValue: "CategoryDataCell")
    static let categoryHeaderCell = NSUserInterfaceItemIdentifier(rawValue: "CategoryHeaderCell")
    static let comment = NSUserInterfaceItemIdentifier(rawValue: "Comment")
    static let count = NSUserInterfaceItemIdentifier(rawValue: "Count")
    static let enabled = NSUserInterfaceItemIdentifier(rawValue: "Enabled")
    static let find = NSUserInterfaceItemIdentifier(rawValue: "Find")
    static let identifier = NSUserInterfaceItemIdentifier(rawValue: "Identifier")
    static let limit = NSUserInterfaceItemIdentifier(rawValue: "Limit")
    static let mask = NSUserInterfaceItemIdentifier(rawValue: "Mask")
    static let oemTableId = NSUserInterfaceItemIdentifier(rawValue: "OemTableId")
    static let path = NSUserInterfaceItemIdentifier(rawValue: "Path")
    static let replace = NSUserInterfaceItemIdentifier(rawValue: "Replace")
    static let replaceMask = NSUserInterfaceItemIdentifier(rawValue: "ReplaceMask")
    static let skip = NSUserInterfaceItemIdentifier(rawValue: "Skip")
    static let tableLength = NSUserInterfaceItemIdentifier(rawValue: "TableLength")
    static let tableSignature = NSUserInterfaceItemIdentifier(rawValue: "TableSignature")
    static let advanced = NSUserInterfaceItemIdentifier(rawValue: "advanced")
    static let hex = NSUserInterfaceItemIdentifier(rawValue: "hex")
}

extension NSWindow.FrameAutosaveName {
    static let configurationDocumentWindow = "ConfigurationDocumentWindow"
}

