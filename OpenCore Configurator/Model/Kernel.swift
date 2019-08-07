import Foundation

class Kernel: Codable {
    var additions = [Addition]()
    var blocks = [Block]()
    var emulate = Emulate()
    var patches = [Patch]()
    var quirks = Quirks()

    private enum CodingKeys: String, CodingKey {
        case additions = "Add"
        case blocks = "Block"
        case emulate = "Emulate"
        case patches = "Patch"
        case quirks = "Quirk"
    }

    class Addition: Codable {
        var bundlePath = ""
        var comment = ""
        var isEnabled: Bool = false
        var executablePath = ""
        var matchKernel = ""
        var plistPath = ""

        private enum CodingKeys: String, CodingKey {
            case bundlePath = "BundlePath"
            case comment = "Comment"
            case isEnabled = "Enabled"
            case executablePath = "ExecutablePath"
            case matchKernel = "MatchKernel"
            case plistPath = "PlistPath"
        }
    }

    class Block: Codable {
        var comment = ""
        var isEnabled = false
        var identifier = ""
        var matchKernel = ""

        private enum CodingKeys: String, CodingKey {
            case comment = "Comment"
            case isEnabled = "Enabled"
            case identifier = "Identifier"
            case matchKernel = "MatchKernel"
        }
    }

    class Emulate: Codable {
        var cpuID1Data = Data(repeating: 0, count: 16)
        var cpuID1Mask = Data(repeating: 0, count: 16)

        private enum CodingKeys: String, CodingKey {
            case cpuID1Data = "Cpuid1Data"
            case cpuID1Mask = "Cpuid1Mask"
        }
    }

    class Patch: Codable {
        var base = ""
        var comment = ""
        var count = 0
        var isEnabled = false
        var find = Data()
        var identifier = ""
        var limit = 0
        var mask = Data()
        var matchKernel = ""
        var replace = Data()
        var replaceMask = Data()
        var skip = 0

        private enum CodingKeys: String, CodingKey {
            case base = "Base"
            case comment = "Comment"
            case count = "Count"
            case isEnabled = "Enabled"
            case find = "Find"
            case identifier = "Identifier"
            case limit = "Limit"
            case mask = "Mask"
            case matchKernel = "MatchKernel"
            case replace = "Replace"
            case replaceMask = "ReplaceMask"
            case skip = "Skip"
        }
    }

    class Quirks: Codable {
        var appleCpuPmCfgLock = false
        var appleXcpmCfgLock = false
        var appleXcpmExtraMsrs = false
        var customSMBIOSGuid = false
        var disableIoMapper = false
        var externalDiskIcons = false
        var lapicKernelPanic = false
        var panicNoKextDump = false
        var thirdPartyTrim = false
        var xhciPortLimit = false

        private enum CodingKeys: String, CodingKey {
            case appleCpuPmCfgLock = "AppleCpuPmCfgLock"
            case appleXcpmCfgLock = "AppleXcpmCfgLock"
            case appleXcpmExtraMsrs = "AppleXcpmExtraMsrs"
            case customSMBIOSGuid = "CustomSMBIOSGuid"
            case disableIoMapper = "DisableIoMapper"
            case externalDiskIcons = "ExternalDiskIcons"
            case lapicKernelPanic = "LapicKernelPanic"
            case panicNoKextDump = "PanicNoKextDump"
            case thirdPartyTrim = "ThirdPartyTrim"
            case xhciPortLimit = "XhciPortLimit"
        }
    }
}
