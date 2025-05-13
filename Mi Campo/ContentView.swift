//
//  ContentView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI



import SwiftUI

struct ContentView: View {
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore = false
    @AppStorage("userRole") var userRole = ""
    
    var body: some View {
        RootFlowView()
    }
}
#Preview {
    ContentView()
}
