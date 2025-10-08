//
//  AppStorageManager.swift
//  GrocerStop
//
//  Created by BitDegree on 08/10/25.
//

import Foundation
import SwiftUI

struct AppStorageManager {
    @AppStorage("hasCompletedOnboarding") static var hasCompletedOnboarding: Bool = false
}
