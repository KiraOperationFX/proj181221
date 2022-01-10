//
//  RemoteConfigManager.swift
//  proj181221
//
//  Created by Kira on 01/01/2022.
//

import Foundation
import FirebaseRemoteConfig

enum RemoteConfigKey: String {
    case buildShowAds = "build_show_ads"
    case buildForceUpdate = "build_force_update"
    case buildForceUpdateUrl = "build_force_update_url"
}

struct RemoteConfigManager {
    
  // local default value
   // static let baseUrl = "api.local.url"
 
    static let shared = RemoteConfigManager()

    fileprivate var remoteConfig: RemoteConfig
    
    fileprivate init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
//        self.setDefaultValue()
    }

//     func setDefaultValue() {
//        let url = RemoteConfigManager.baseUrl as NSString
//        remoteConfig.setDefaults([RemoteConfigKey.serverUrl.rawValue: url])
//    }
    

    func getValue(fromKey key: RemoteConfigKey) -> String {
        if let value = self.remoteConfig.configValue(forKey: key.rawValue).stringValue {
            return value
        }
        return ""
    }
    
    func getBoolValue(fromKey key: RemoteConfigKey) -> Bool {
        return self.remoteConfig.configValue(forKey: key.rawValue).boolValue
    }
    
    func fetchRemoteConfig() {
        remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate { changed, error in }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
        }
    }
    
}
