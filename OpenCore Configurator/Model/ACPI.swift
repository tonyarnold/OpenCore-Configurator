import Foundation

class ACPI: Codable {
    var additions = [Addition]()
    var blocks = [Block]()
    var patches = [Patch]()
    var quirks = Quirks()

    private enum CodingKeys: String, CodingKey {
        case additions = "Add"
        case blocks = "Block"
        case patches = "Patch"
        case quirks = "Quirk"
    }

    class Addition: Codable, Enableable {
        var comment = ""
        var isEnabled = false
        var path = ""

        private enum CodingKeys: String, CodingKey {
            case comment = "Comment"
            case isEnabled = "Enabled"
            case path = "Path"
        }
    }

    class Block: Codable, Enableable {
        var blockAll = false
        var comment = ""
        var isEnabled = false
        var oemTableIdentifier = Data(repeating: 0, count: 8)
        var tableLength: Int = 0
        var tableSignature = Data(repeating: 0, count: 4)

        private enum CodingKeys: String, CodingKey {
            case blockAll = "All"
            case comment = "Comment"
            case isEnabled = "Enabled"
            case oemTableIdentifier = "OemTableId"
            case tableLength = "TableLength"
            case tableSignature = "TableSignature"
        }
    }

    class Patch: Codable, Enableable {
        var comment = ""
        var count: Int = 0
        var isEnabled = false
        var find = Data()
        var limit: Int = 0
        var mask = Data()
        var oemTableIdentifier = Data(repeating: 0, count: 8)
        var replace = Data()
        var replaceMask = Data()
        var skip: Int = 0
        var tableLength: Int = 0
        var tableSignature = Data(repeating: 0, count: 4)

        private enum CodingKeys: String, CodingKey {
            case comment = "Comment"
            case count = "Count"
            case isEnabled = "Enabled"
            case find = "Find"
            case limit = "Limit"
            case mask = "Mask"
            case oemTableIdentifier = "OemTableId"
            case replace = "Replace"
            case replaceMask = "ReplaceMask"
            case skip = "Skip"
            case tableLength = "TableLength"
            case tableSignature = "TableSignature"
        }
    }

    class Quirks: Codable {
        var fadtEnableReset = false
        var normalizeHeaders = false
        var rebaseRegions = false
        var resetHardwareSignature = false
        var resetLogoStatus = false

        private enum CodingKeys: String, CodingKey {
            case fadtEnableReset = "FadtEnableReset"
            case normalizeHeaders = "NormalizeHeaders"
            case rebaseRegions = "RebaseRegions"
            case resetHardwareSignature = "ResetHwSig"
            case resetLogoStatus = "ResetLogoStatus"
        }
    }
}
