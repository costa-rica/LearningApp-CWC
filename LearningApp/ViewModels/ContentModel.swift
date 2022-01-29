//
//  ContentModel.swift
//  LearningApp
//
//  Created by Nick on 1/29/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
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
}
