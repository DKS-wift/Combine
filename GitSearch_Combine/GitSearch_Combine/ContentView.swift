//
//  ContentView.swift
//  GitSearch_Combine
//
//  Created by 박의서 on 2023/06/30.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm:ViewModel = .init()
    
    var body: some View {
        VStack {
            TextField("검색 텍스트필드", text: $vm.text)
            List(vm.filteredSource) { model in
                
                Text(model.fullName)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
