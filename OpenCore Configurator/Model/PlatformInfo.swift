import Foundation

final class PlatformInfo: Codable {
    var automatic = false
    var updateDataHub = false
    var updateNVRAM = false
    var updateSMBIOS = false
    var updateSMBIOSMode = SMBIOSMode.create

    var generic = Generic()
    var dataHub = DataHub()
    var platformNVRAM = PlatformNVRAM()
    var smbios = SMBIOS()

    enum SMBIOSMode: String, RawRepresentable, Codable {
        case tryOverwrite = "TryOverwrite"
        case create = "Create"
        case overwrite = "Overwrite"
        case custom = "Custom"
    }

    class Generic: Codable {
        var spoofVendor = false
        var systemProductName = "MacPro6,1"
        var systemSerialNumber = "OPENCORE_SN1"
        var systemUUID = ""
        var mlb = "OPENCORE_MLB_SN11"
        var rom = Data(repeating: 0, count: 6)

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
        var boardRevision = Data(repeating: 0, count: 1)
        var startupPowerEvents: Int64 = 0
        var initialTSC: Int64 = 0
        var fsbFrequency: Int64?
        var artFrequency: Int64?
        var devicePathsSupported: Int32?
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
        var platformFeature: UInt32 = 0xFFFF_FFFF
        var firmwareFeatures = Data(repeating: 0, count: 16)
        var firmwareFeaturesMask = Data(repeating: 0, count: 8)
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
