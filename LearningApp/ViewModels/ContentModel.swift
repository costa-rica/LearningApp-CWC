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
    
    //Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    //Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    //Current lesson explaination (lesson7 in CWC)
    @Published var codeText = NSAttributedString()
    
    var styleData: Data?// <-create with getLocalData
    
    //Current selected content and test <-tags
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    init() {
        
        //Parse local included json data
        getLocalData()
        //Download remote json file and parse data
        getRemoteData()
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
    
    
    func getRemoteData() {
        
        //MARK: getting data from remote location on the internet
        
        //String path
        let urlString = "https://costa-rica.github.io/learningapp-data/data2.json"
        
        //Create a url object
        let url = URL(string:urlString)
        
        guard url != nil else {
            //Couldn't create url
            return
        }
        
        //Create a URLRequest object
        let request = URLRequest(url:url!)//This is forced unwrapped becuase we checked its not nil wil gaurd above
        
        //Get the session and kick off the task
        let session = URLSession.shared
        
        
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in //data, response, error all names i've assigned now. json data from remote source will be in "data"
            
        //MARK: This portion is basically same as getLocalData
            
            //check if there's an error
            guard error == nil else {
                //There was an error
                return
            }
            do {
                //Create json decoder
                let decoder = JSONDecoder()
                
                //Decode
                let modules = try decoder.decode([Module].self, from: data!)
                
                //Append parsed modules into module property
                self.modules += modules
            }
            catch {
                //Couldn't parse json
            }

            
        }
        //Kick off data task
        dataTask.resume()
    }
    
    // MARK: - Module navigation methods
    func beginModule(_ moduleId: Int) {
        //Find the index of this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                currentModuleIndex = index
                break
            }
        }
        //Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson (_ lessonIndex:Int) {
        //check the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        
        //Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        //advance lesson index
        currentLessonIndex += 1
        
        //Check that it is wihtin range
        if currentLessonIndex < currentModule!.content.lessons.count {
            //Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)//<-added Mod5lesson 7
        }
        else {
            // Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
            
        }
    }
    
    func hasNextLesson() -> Bool {
//        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
//            return true
//        }
//        else {
//            return false
//        }
//        OR
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)//this is a bool statement
    }
    
    func beginTest(_ moduleId:Int) {
        //Set the current module
        beginModule(moduleId)
        
        //Set the current question
        currentQuestionIndex = 0
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        
    }
    
    func nextQuestion() {
        
        //Advance the question index
        currentQuestionIndex += 1
        
        //Check that it's within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            
            //Set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        else {
            //If not, then reset the properties
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    // MARK: - Code Styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        //Add the styling data
        if styleData != nil {
            data.append(self.styleData!)
        }
        
        //add the html data
        data.append(Data(htmlString.utf8))
        
        //Convert to attributed string
        
        //Technique 1
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        //If technique 1 fails it will just skip and proceed, soemthing to do with '?'.
        
//        //Technique 2
//        do {
//            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
//
//            resultString = attributedString
//        }
//        catch {
//            print("couldn't turn html into attributed string", error)
//        }
        
        return resultString
    }
    
}
