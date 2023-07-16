//
//  ViewModel.swift
//  GitSearch_Combine
//
//  Created by 박의서 on 2023/06/30.
//

import Foundation
import Combine

class ViewModel:ObservableObject {
    
    var subscription = Set<AnyCancellable>()
    
    @Published var text:String = ""
    
    @Published var dataSource:[GitModel] = []
    @Published var filteredSource:[GitModel] = []
    
    var subject:PassthroughSubject<[GitModel],Never> = .init()
    
    
    init() {
        
        getRepos()
        
    
        subject
            .receive(on: DispatchQueue.main)
            .sink {[weak self]  model in
            
            guard let self else {return}
            
            self.dataSource = model
            self.filteredSource = model
        }
        .store(in: &subscription)
        
        
        
        
        
        Publishers.CombineLatest($text, $dataSource)
            .map({ text,dataSource in
                
                return text.isEmpty ? dataSource : dataSource.filter({$0.fullName.contains(text)})
                
            })
            .assign(to: &$filteredSource)
        
    }
    
    
    
    
    
    
}



extension ViewModel{
    
    func getRepos() {
    
        let dummy:[GitModel] = [GitModel(id: UUID().uuidString, fullName: "Hello", stars: 3),GitModel(id: UUID().uuidString, fullName: "Hello2", stars: 2),GitModel(id: UUID().uuidString, fullName: "Hello3", stars: 3)]
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3){[weak self]in
            
            guard let self else {return}
                
            self.subject.send(dummy)
            
        }
        
        
    }
    
    
}
