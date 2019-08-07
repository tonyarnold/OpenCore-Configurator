import Foundation

class NVRAM: Codable {
    var additions: [UUID: [Configuration.Value]] = [:]
    var blocks: [UUID: [Configuration.Value]] = [:]
    var legacyEnable = false
    var legacySchema: [UUID: [Configuration.Value]] = [:]

    private enum CodingKeys: String, CodingKey {
        case additions = "Add"
        case blocks = "Block"
        case legacyEnable = "LegacyEnable"
        case legacySchema = "LegacySchema"
    }
}
