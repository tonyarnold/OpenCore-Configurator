class UEFI: Codable {
    var connectDrivers = false
    var drivers = [String]()
    var protocols = Protocols()
    var quirks = Quirks()

    class Protocols: Codable {
        var appleBootPolicy = false
        var consoleControl = false
        var dataHub = false
        var deviceProperties = false

        private enum CodingKeys: String, CodingKey {
            case appleBootPolicy = "AppleBootPolicy"
            case consoleControl = "ConsoleControl"
            case dataHub = "DataHub"
            case deviceProperties = "DeviceProperties"
        }
    }

    class Quirks: Codable {
        var avoidHighAlloc = false
        var exitBootServicesDelay: Int = 0
        var ignoreInvalidFlexRatio = false
        var ignoreTextInGraphics = false
        var provideConsoleGOP = false
        var releaseUSBOwnership = false
        var requestBootVariableRouting = false
        var sanitiseClearScreen = false

        private enum CodingKeys: String, CodingKey {
            case exitBootServicesDelay = "ExitBootServicesDelay"
            case ignoreInvalidFlexRatio = "IgnoreInvalidFlexRatio"
            case ignoreTextInGraphics = "IgnoreTextInGraphics"
            case provideConsoleGOP = "ProvideConsoleGOP"
            case releaseUSBOwnership = "ReleaseUSBOwnership"
            case requestBootVariableRouting = "RequestBootVariableRouting"
            case sanitiseClearScreen = "SanitiseClearScreen"
        }
    }

    private enum CodingKeys: String, CodingKey {
        case connectDrivers = "ConnectDrivers"
        case drivers = "Drivers"
        case protocols = "Protocols"
        case quirks = "Quirks"
    }
}
