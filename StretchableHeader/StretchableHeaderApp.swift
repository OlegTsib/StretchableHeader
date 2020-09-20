//
//  StretchableHeaderApp.swift
//  StretchableHeader
//
//  Created by Oleg Tsibulevskiy on 20/09/2020.
//

import SwiftUI

@main
struct StretchableHeaderApp: App {

    var body: some Scene {
        WindowGroup {
            
            Menu(repository: MenuRepository())
        }
    }
}
