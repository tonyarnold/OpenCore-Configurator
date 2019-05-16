import Foundation

extension Configuration {
    enum Category: CaseIterable, LocalizedDisplayable {
        case acpi
        case deviceProperties
        case kernel
        case miscellaneous
        case nvram
        case platformInformation
        case uefi

        var localizedDescription: String {
            switch self {
            case .acpi:
                return NSLocalizedString(
                    "Configuration.Category.acpi.localizedDescription",
                    value: "ACPI",
                    comment: "Localized description for Configuration.Category.acpi"
                )

            case .deviceProperties:
                return NSLocalizedString(
                    "Configuration.Category.deviceProperties.localizedDescription",
                    value: "Device Properties",
                    comment: "Localized description for Configuration.Category.deviceProperties"
                )

            case .kernel:
                return NSLocalizedString(
                    "Configuration.Category.kernel.localizedDescription",
                    value: "Kernel",
                    comment: "Localized description for Configuration.Category.kernel"
                )

            case .miscellaneous:
                return NSLocalizedString(
                    "Configuration.Category.miscellaneous.localizedDescription",
                    value: "Miscellaneous",
                    comment: "Localized description for Configuration.Category.miscellaneous"
                )

            case .nvram:
                return NSLocalizedString(
                    "Configuration.Category.nvram.localizedDescription",
                    value: "NVRAM",
                    comment: "Localized description for Configuration.Category.nvram"
                )

            case .platformInformation:
                return NSLocalizedString(
                    "Configuration.Category.platformInformation.localizedDescription",
                    value: "Platform Information",
                    comment: "Localized description for Configuration.Category.platformInformation"
                )

            case .uefi:
                return NSLocalizedString(
                    "Configuration.Category.uefi.localizedDescription",
                    value: "UEFI",
                    comment: "Localized description for Configuration.Category.uefi"
                )
            }
        }
    }
}
