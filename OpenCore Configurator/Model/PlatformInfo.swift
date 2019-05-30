import Foundation

final class PlatformInfo: Codable {
    var automatic: Bool
    var updateDataHub: Bool
    var updateNVRAM: Bool
    var updateSMBIOS: Bool
    var updateSMBIOSMode: SMBIOSMode

    var generic: Generic
    var dataHub: DataHub
    var platformNVRAM: PlatformNVRAM
    var smbios: SMBIOS

    enum SMBIOSMode: String, RawRepresentable, Codable {
        case tryOverwrite = "TryOverwrite"
        case create = "Create"
        case overwrite = "Overwrite"
        case custom = "Custom"
    }

    init() {
        // Ideally, this initializer implementation wouldn't be necessary and would could provide the values on the properties themselves and have the initializer be automatically inferred, but here we are.
        // Thanks, Swift, you idealistic jerk.
        automatic = false
        updateDataHub = false
        updateNVRAM = false
        updateSMBIOS = false
        updateSMBIOSMode = .create
        generic = .init()
        dataHub = .init()
        platformNVRAM = .init()
        smbios = .init()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // All of these decode calls do the same thing. They:
        //  - Use an optional `try?`, which means that if there's an error decoding the key from the incoming data, `nil` will be returned rather than throwing an error.
        //  - Use `decodeIfPresent(…)` so that if the key is missing, it's _not_ an error. This is arguably unnecessary given we swallow the decoding errors by using `try?`, but let's do it for consistency and clarity.
        //  - Use a nil coalescing (`??`) to provide a default value if there is none currently.
        //
        // The end result of this is that our final in-memory data (and what is saved back to disk) will fall back to default values for *everything* that is missing or malformed.
        // As I mentioned, the downside is that if someone has a key spelled "autometic" with the correct value, it will be ignored and subsequently *deleted* when the user saves the data model back to disk.
        automatic = (try? container.decodeIfPresent(Bool.self, forKey: .automatic)) ?? false
        updateDataHub = (try? container.decodeIfPresent(Bool.self, forKey: .updateDataHub)) ?? false
        updateNVRAM = (try? container.decodeIfPresent(Bool.self, forKey: .updateNVRAM)) ?? false
        updateSMBIOS = (try? container.decodeIfPresent(Bool.self, forKey: .updateSMBIOS)) ?? false
        updateSMBIOSMode = (try? container.decodeIfPresent(SMBIOSMode.self, forKey: .updateSMBIOSMode)) ?? .create
        generic = (try? container.decodeIfPresent(Generic.self, forKey: .generic)) ?? .init()
        dataHub = (try? container.decodeIfPresent(DataHub.self, forKey: .dataHub)) ?? .init()
        platformNVRAM = (try? container.decodeIfPresent(PlatformNVRAM.self, forKey: .platformNVRAM)) ?? .init()
        smbios = (try? container.decodeIfPresent(SMBIOS.self, forKey: .smbios)) ?? .init()
    }

    class Generic: Codable {
        var spoofVendor: Bool? = false
        var systemProductName: String?
        var systemSerialNumber: String?
        var systemUUID: String?
        var mlb: String?
        var rom: Data?

        private enum CodingKeys: String, CodingKey {
            case spoofVendor = "SpoofVendor"
            case systemProductName = "SystemProductName"
            case systemSerialNumber = "SystemSerialNumber"
            case systemUUID = "SystemUUID"
            case mlb = "MLB"
            case rom = "ROM"
        }
    }

    class DataHub: Codable {
        var platformName: String?
        var systemProductName: String?
        var systemSerialNumber: String?
        var systemUUID: String?
        var boardProduct: String?
        var boardRevision: Data?
        var startupPowerEvents: Int64?
        var initialTSC: Int64? = 0
        var fsbFrequency: Int64?
        var artFrequency: Int64?
        var devicePathsSupported: Data?
        var smcRevision: Data?
        var smcBranch: Data?
        var smcPlatform: Data?

        private enum CodingKeys: String, CodingKey {
            case platformName = "PlatformName"
            case systemProductName = "SystemProductName"
            case systemSerialNumber = "SystemSerialNumber"
            case systemUUID = "SystemUUID"
            case boardProduct = "BoardProduct"
            case boardRevision = "BoardRevision"
            case startupPowerEvents = "StartupPowerEvents"
            case initialTSC = "InitialTSC"
            case fsbFrequency = "FSBFrequency"
            case artFrequency = "ARTFrequency"
            case devicePathsSupported = "DevicePathsSupported"
            case smcRevision = "SmcRevision"
            case smcBranch = "SmcBranch"
            case smcPlatform = "SmcPlatform"
        }
    }

    class PlatformNVRAM: Codable {
        var bID: String?
        var rom: Data?
        var mlb: String?
        var firmwareFeatures: Data?
        var firmwareFeaturesMask: Data?

        private enum CodingKeys: String, CodingKey {
            case bID = "BID"
            case rom = "ROM"
            case mlb = "MLB"
            case firmwareFeatures = "FirmwareFeatures"
            case firmwareFeaturesMask = "FirmwareFeaturesMask"
        }
    }

    class SMBIOS: Codable {
        var biosVendor: String?
        var biosVersion: String?
        var biosReleaseDate: String?
        var systemManufacturer: String?
        var systemProductName: String?
        var systemSerialNumber: String?
        var systemUUID: String?
        var systemSKUNumber: String?
        var systemFamily: String?
        var boardManufacturer: String?
        var boardProduct: String?
        var boardVersion: String?
        var boardSerialNumber: String?
        var boardAssetTag: String?
        var boardType: Int?
        var boardLocationInChassis: String?
        var chassisManufacturer: String?
        var chassisType: Int?
        var chassisSerialNumber: String?
        var chassisAssetTag: String?
        var platformFeature: Int?
        var firmwareFeatures: Data?
        var firmwareFeaturesMask: Data?
        var processorType: Int16?
        var memoryFormFactor: Int8?

        private enum CodingKeys: String, CodingKey {
            case biosVendor = "BiosVendor"
            case biosVersion = "BiosVersion"
            case biosReleaseDate = "BiosReleaseDate"
            case systemManufacturer = "SystemManufacturer"
            case systemProductName = "SystemProductName"
            case systemSerialNumber = "SystemSerialNumber"
            case systemUUID = "SystemUUID"
            case systemSKUNumber = "SystemSKUNumber"
            case systemFamily = "SystemFamily"
            case boardManufacturer = "BoardManufacturer"
            case boardProduct = "BoardProduct"
            case boardVersion = "BoardVersion"
            case boardSerialNumber = "BoardSerialNumber"
            case boardAssetTag = "BoardAssetTag"
            case boardType = "BoardType"
            case boardLocationInChassis = "BoardLocationInChassis"
            case chassisManufacturer = "ChassisManufacturer"
            case chassisType = "ChassisType"
            case chassisSerialNumber = "ChassisSerialNumber"
            case chassisAssetTag = "ChassisAssetTag"
            case platformFeature = "PlatformFeature"
            case firmwareFeatures = "FirmwareFeatures"
            case firmwareFeaturesMask = "FirmwareFeaturesMask"
            case processorType = "ProcessorType"
            case memoryFormFactor = "MemoryFormFactor"
        }
    }

    private enum CodingKeys: String, CodingKey {
        case automatic = "Automatic"
        case updateDataHub = "UpdateDataHub"
        case updateNVRAM = "UpdateNVRAM"
        case updateSMBIOS = "UpdateSMBIOS"
        case updateSMBIOSMode = "UpdateSMBIOSMode"
        case generic = "Generic"
        case dataHub = "DataHub"
        case platformNVRAM = "PlatformNVRAM"
        case smbios = "SMBIOS"
    }
}
