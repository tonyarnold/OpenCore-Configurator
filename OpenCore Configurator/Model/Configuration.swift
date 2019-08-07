import Foundation

class Configuration: Codable {
    var acpi = ACPI()
    var deviceProperties = DeviceProperties()
    var kernel = Kernel()
    var miscellaneous = Miscellaneous()
    var nvram = NVRAM()
    var platformInfo = PlatformInfo()
    var uefi = UEFI()

    private enum CodingKeys: String, CodingKey {
        case acpi = "ACPI"
        case deviceProperties = "DeviceProperties"
        case kernel = "Kernel"
        case miscellaneous = "Misc"
        case nvram = "NVRAM"
        case platformInfo = "PlatformInfo"
        case uefi = "UEFI"
    }

    enum Value: Codable {
        case string(String)
        case int(Int)
        case data(Data)
        case empty

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()

            if let value = try? container.decode(Data.self) {
                self = .data(value)
            } else if let value = try? container.decode(Int.self) {
                self = .int(value)
            } else if let value = try? container.decode(String.self) {
                self = .string(value)
            } else {
                throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .int(int):
                try container.encode(int)
            case let .string(string):
                try container.encode(string)
            case let .data(data):
                try container.encode(data)
            case .empty:
                try container.encodeNil()
            }
        }
    }
}
