class Miscellaneous: Codable {
    var boot = Boot()
    var debug = Debug()
    var security = Security()
    var tools = Tools()

    private enum CodingKeys: String, CodingKey {
        case boot = "Boot"
        case debug = "Debug"
        case security = "Security"
        case tools = "Tools"
    }

    class Boot: Codable {
        var consoleMode = ""
        var consoleBehaviourOS = ConsoleBehaviour.none
        var consoleBehaviourUI = ConsoleBehaviour.none
        var hibernateMode = HibernateMode.none
        var hideSelf = false
        var resolution = ""
        var showPicker = false
        var timeout: Int32 = 0
        var usePicker = false

        enum ConsoleBehaviour: String, RawRepresentable, Codable {
            case none = ""
            case text = "Text"
            case graphics = "Graphics"
            case forceText = "ForceText"
            case forceGraphics = "ForceGraphics"
        }

        enum HibernateMode: String, RawRepresentable, Codable {
            case none = ""
            case auto = "Auto"
            case rtc = "RTC"
            case nvram = "NVRAM"
        }

        private enum CodingKeys: String, CodingKey {
            case consoleMode = "ConsoleMode"
            case consoleBehaviourOS = "ConsoleBehaviourOS"
            case consoleBehaviourUI = "ConsoleBehaviourUI"
            case hibernateMode = "HibernateMode"
            case hideSelf = "HideSelf"
            case resolution = "Resolution"
            case showPicker = "ShowPicker"
            case timeout = "Timeout"
            case usePicker = "UsePicker"
        }
    }

    class Debug: Codable {
        var disableWatchDog = false
        var displayDelay: Int = 0
        var displayLevel: Int64 = 0
        var target: Int = 0

        private enum CodingKeys: String, CodingKey {
            case disableWatchDog = "DisableWatchDog"
            case displayDelay = "DisplayDelay"
            case displayLevel = "DisplayLevel"
            case target = "Target"
        }
    }

    class Security: Codable {
        var exposeSensitiveData: Int = 2
        var haltLevel: Int64 = 0x8000_0000
        var requireSignature = true
        var requireVault = true
        var scanPolicy: Int32 = 0xF0103

        private enum CodingKeys: String, CodingKey {
            case exposeSensitiveData = "ExposeSensitiveData"
            case haltLevel = "HaltLevel"
            case requireSignature = "RequireSignature"
            case requireVault = "RequireVault"
        }
    }

    class Tools: Codable {
        var comment = ""
        var isEnabled = false
        var name = ""
        var path = ""

        private enum CodingKeys: String, CodingKey {
            case comment = "Comment"
            case isEnabled = "Enabled"
            case name = "Name"
            case path = "Path"
        }
    }
}
