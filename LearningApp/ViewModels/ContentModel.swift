//
//  ContentModel.swift
//  LearningApp
//
//  Created by Nick on 1/29/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    //List of modules
    @Published var modules = [Module]()
    
    //Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods
    func getLocalData() {
        //Get a url to the json file ***Different extension than earlier modules**
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            //methods that "throw" need to be put in a try:
            //Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            //Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            //if decoder throws it probably means the data and model are not matching
            
            //Assign parsed moduels to modules propoerty
            self.modules = modules
            
        }
        catch {
            //Todo log
            print("coulnt parse local data")
            print(error)
        }
        
        //Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            //Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
            
        }
        catch {
            //Todo log
            print("couldnt parse Style data")
            print(error)
        }
    }
    
    // MARK: - Module navigation methods
    func beginModule( moduleid: Int) {
        //Find the index of this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                currentModuleIndex = index
                break
            }
        }

        //Set the current module
        currentModule = modules[currentModuleIndex]
        
    }
}
