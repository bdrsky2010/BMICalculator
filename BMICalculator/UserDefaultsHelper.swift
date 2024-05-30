//
//  UserDefaultsHelper.swift
//  BMICalculator
//
//  Created by Minjae Kim on 5/30/24.
//

import Foundation

struct UserDefaultsHelper {
    
    var nickname: String? {
        
        get {
            return UserDefaults.standard.string(forKey: ViewController.nicknameKey)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: ViewController.nicknameKey)
        }
    }
    
    var height: String? {
        
        get {
            return UserDefaults.standard.string(forKey: ViewController.heightKey)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: ViewController.heightKey)
        }
    }
    
    var weight: String? {
        
        get {
            return UserDefaults.standard.string(forKey: ViewController.weightKey)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: ViewController.weightKey)
        }
    }
}
