//
//  Environment.swift
//  DemoApp
//
//  Created by Anmol Suneja on 29/06/21.
//
import Foundation

enum EnvironmentType: String {
    case staging = "Staging" //Points to staging server
    case release = "Release" //Points to release server
    case development = "Development" //Points to development server
}

class Environment {
    static let shared:Environment = Environment()
    private init() {
    }
    var serverBaseUrl: String {
        guard let appEnvironment = Bundle.main.infoDictionary?["APP_ENVIRONMENT"] as? String else {
          fatalError("Server url not found")
        }
        let environmentType = EnvironmentType(rawValue: appEnvironment)
        switch environmentType {
        case .staging:
            //Configure staging server
            return "https://anmol.com/staging"
        case .development:
            //Configure development server
            return "https://anmol.com/development"
        case .release:
            //Configure release server
            return "https://anmol.com/release"
        default:
            //Configure server based on user selection
            let plistSavedAppEnvUserDefaultsKey = "demo_app_server_preference_settings"
            if let prefrence = UserDefaults.standard.value(forKey: plistSavedAppEnvUserDefaultsKey) as? String,
               let preferenceType = EnvironmentType(rawValue: prefrence) {
                // as per new preference type configure app
                // logout from current server
                // reintiliase services with new server
                switch preferenceType {
                case .staging:
                    //Configure staging server
                    return "https://anmol.com/staging"
                case .development:
                    //Configure development server
                    return "https://anmol.com/development"
                case .release:
                    //Configure release server
                    return "https://anmol.com/release"
                }
            }
            // let us set by default preference as staging server
            return "https://anmol.com/staging"
        }
    }
        
    func configureEnvironment() {
        print("The app base url is: \(serverBaseUrl)")
    }
}
