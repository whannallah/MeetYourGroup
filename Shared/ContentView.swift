//
//  ContentView.swift
//  Shared
//
//  Created by Whitney Hannallah on 1/13/22.
//

import SwiftUI

class Game: ObservableObject {
    @Published var names = [String]()
    @Published var cats = [String]()
    @Published var data = [["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""],["","", "","","","","","","","","","","","","","","","","",""]]
} //20 by 20

struct ContentView: View {
    
    @StateObject var nameList = Game()
    
    var body: some View {
        
        NavigationView{
            ZStack{
            LinearGradient(gradient: Gradient(colors: [.red, .white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            VStack{
            Text("Welcome to MeetYourGroup - The app that allows you to create a personalized quiz game with up to 20 players! All you need to do is enter the names of your group members and some creative 'get to know you' questions for each person to answer. Then once everyone puts in their answers, MeetYourGroup will generate a multiple choice game where group members will work together to guess each others' answers!")
                    .padding(50)
                    .background(.ultraThinMaterial)
        NavigationLink(destination: NameView()){
            Text("Click to Begin!")
            
        }}
    }
            .navigationBarTitle("MeetYourGroup", displayMode: .inline)
    }
        
    .environmentObject(nameList)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


 


struct NameView: View {
   
    @EnvironmentObject var nameList: Game
    
    //@State private var groupMembers = [String]()
    @State private var newName = ""
     
    @State private var categories = [String]()
    @State private var newCat = ""
     @State private var whichView = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingNameError = false
    @State private var toDisable = true
    
     
         var body: some View {
             ZStack{
                 Color(red: 0.7098, green: 0.9725, blue: 1)
                     .ignoresSafeArea()
                         
             VStack{
                
                 Text("Make sure you enter at least 3 people")
                     .padding(10)
                     .background(.ultraThinMaterial)
                 VStack{
                 List{
                 Section{
                     TextField("Enter Player's name", text: $newName)
                 }
                 Section{
                     ForEach(nameList.names, id: \.self) { word in Text(word)}
                 }
             }
                 }
         .onSubmit(addNewName)
         .alert(errorTitle, isPresented: $showingNameError) {
             Button("OK", role: .cancel) { }
         } message: {
             Text(errorMessage)
         }
         .navigationBarTitle("Enter everyone's name", displayMode: .inline)
         .padding(10)
         .background(.ultraThinMaterial)
         
                
                 NavigationLink(destination: CatView()){
                     Text("Next")
                 }
                 .disabled(toDisable == true)
             }
             }
             
                 
         .environmentObject(nameList)
        
         }
        
    
     
     func addNewName() {
         let name = newName.trimmingCharacters(in: .whitespacesAndNewlines)
         guard name.count > 0 else {
             return
         }
         
         guard isOriginal(word: name) else {
             nameError(title: "Name already used", message: "Please use a different name.")
             return
         }
         
         //extra code that checks for duplicate names
         
         nameList.names.insert(name, at: 0)
         newName = ""
         if nameList.names.count>2 {
             toDisable = false
         }
     }
    
    func isOriginal(word: String) -> Bool {
        !nameList.names.contains(word)
    }
    
    
    func nameError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingNameError = true
    }
    

}


struct CatView: View {
   
    @EnvironmentObject var catList: Game
    
    //@Binding var isNavigationBarHidden2: Bool
     
    @State private var categories = [String]()
    @State private var newCat = ""
     
    @State private var toDisable = true
     
    
     
         var body: some View {
             ZStack{
                 Color(red: 0.9882, green: 0.7765, blue: 1)
                     .ignoresSafeArea()
             VStack{
                 Text("Make sure you enter at least 1 question \n      The more creative, the more fun!")
                     .padding(10)
                     .background(.ultraThinMaterial)
                 
             VStack{
             List{
                 Section{
                     
                     TextField("Enter Question", text: $newCat)
                 }
                 Section{
                     ForEach(catList.cats, id: \.self) { word in Text(word)}
                 }
             }
         }
         .onSubmit(addNewCat)
         .navigationTitle("Enter your questions")
         .padding(10)
         .background(.ultraThinMaterial)
                 NavigationLink(destination: DataView()){
                 Text("Next")
             }
                 .disabled(toDisable == true)
                
     }
             }
         
         .environmentObject(catList)
         
         }
     
     func addNewCat() {
         let cat = newCat.trimmingCharacters(in: .whitespacesAndNewlines)
         guard cat.count > 0 else { return }
         
         //extra code that checks for duplicate names
         
         catList.cats.insert(cat, at: 0)
         newCat = ""
         if catList.cats.count>0 {
             toDisable = false
         }
     }
         }



struct DataView: View {
   
    @EnvironmentObject var nameList2: Game
    
    //@State private var groupMembers = [String]()
    @State private var newName = ""
     
    @State private var categories = [String]()
    @State private var newCat = ""
     @State private var whichView = 0
    
   // let ind1 = 0
  //  let ind2 = 0
     
         var body: some View{
             
             ZStack{
                 Color(red: 0.8157, green: 1, blue: 0.7765)
                     .ignoresSafeArea()
            
                VStack{
                    VStack(alignment: .leading){
                    Text("Pass the phone around so each person can enter their answers. \n\nOnly enter your answers and don't cheat by peeking!")
    
                                .padding(10)
                                .background(.ultraThinMaterial)
                    }
                 
                    NavigationView{
                     ScrollView{
                 
                     ForEach(nameList2.names.indices) { ind1 in
                         
                         ForEach(nameList2.cats.indices) { ind2 in
                         
                             TextField("\(nameList2.names[ind1]): \(nameList2.cats[ind2])", text: $nameList2.data[ind1][ind2])
                 }
                         Text("")
                         Text("")
                         Text("")
                         Text("")
                         Text("")
                         Text("")
                         Text("")
                     }
                     .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                     }
                    }
            // }
                 NavigationLink(destination: PlayView()){
                 Text("Next")
         
                }
                 
         }
         }
         }
             
       
     
    
    func fillDataBlank(rows: Int, cols: Int){
        //@State var tempBlank = [String]()
        for i in 0...rows-1 {
            nameList2.data.append([String]())
            for _ in 0...cols-1 {
                nameList2.data[i].append("w")
            }
            
        }
    }
}



struct PlayView: View {
    
    @EnvironmentObject var gameSettings: Game
    
    @State private var showingScore = false
    @State private var numCorrect = 0
    @State private var numGuessed = 0
    @State private var scoreTitle = ""
    @State private var showButton = true
    @State private var showQuestions = false
    
    //use a double array of answers randomly pick an index that is the correct answer and work backwards to figure out the person and category from single arrays
    //have to single arrays that alighn with the indexes (names and categories) this is used to ask the question
    
    //use the double array to populate false answers, ensuring that the true answer is manually put in
    //never shuffle the arrays
    
    @State private var correctAnswerName = 0
    @State private var correctAnswerCat = 0
    
    @State private var optionsArray = [" ", " ", " "]
    
    @State private var correctOptionInArray = 0
    

    
    var body: some View {
        
        
        ZStack{
                    
        LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 60) {
              
               
                    
                if showButton == true {
                    
                    Button("Click to play", action: askQuestion)
                    .buttonStyle(.bordered)
                    .foregroundColor(.white)
                   
                    
                        
                        
            }
                    
                
                
                if showQuestions == true {
                VStack {
                    
                    
                    Text("What is \(gameSettings.names[correctAnswerName])'s answer to:").font(.system(size: 25))
                    Text("\(gameSettings.cats[correctAnswerCat])").font(.system(size: 25))
                        
                    
                    
                }
                
               
                ForEach(0..<3) { number in
                    Button(String(optionsArray[number]))
                        {
                        answerTapped(number)
                    }
                        .buttonStyle(.borderedProminent)
                        .font(.largeTitle)
                        .tint(.yellow)
                        .foregroundColor(.black)
                
                }
                }
            }
        }
        .ignoresSafeArea()
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
            Button("Exit", action: quit)
        }
    message: {
        Text("Your score is \(numCorrect) out of \(numGuessed)")
    }
       
    }
    
    
    func answerTapped(_ number: Int) {
        if number == correctOptionInArray {
            scoreTitle = "Correct"
            numCorrect+=1
        }
        else {
            scoreTitle = "Incorrect"
        }
        
        showingScore = true
        numGuessed+=1
    }
    
    func askQuestion() {
        
        correctAnswerName = Int.random(in: 0...gameSettings.names.count-1)
        correctAnswerCat = Int.random(in: 0...gameSettings.cats.count-1)
        showQuestions = true
        fillOptionsArray()
        
    }
    
    func fillOptionsArray() {
        optionsArray[0] = gameSettings.data[correctAnswerName][correctAnswerCat]
        var wrongAnswer1 = Int.random(in: 0...gameSettings.names.count-1) //other people
                    while wrongAnswer1 ==  correctAnswerName {
                        wrongAnswer1 = Int.random(in: 0...gameSettings.names.count-1)
                        }
                        
        var wrongAnswer2 = Int.random(in: 0...gameSettings.names.count-1) //other people
            while wrongAnswer2 == correctAnswerName || wrongAnswer2 == wrongAnswer1 {
                wrongAnswer2 = Int.random(in: 0...gameSettings.names.count-1)
                                        }
        optionsArray[1] = gameSettings.data[wrongAnswer1][correctAnswerCat]
        optionsArray[2] = gameSettings.data[wrongAnswer2][correctAnswerCat]
        optionsArray.shuffle()
                        
        if optionsArray[0] == gameSettings.data[correctAnswerName][correctAnswerCat] {
                            correctOptionInArray = 0
                        }
        if optionsArray[1] == gameSettings.data[correctAnswerName][correctAnswerCat] {
                            correctOptionInArray = 1
                        }
        if optionsArray[2] == gameSettings.data[correctAnswerName][correctAnswerCat] {
                            correctOptionInArray = 2
                        }
        
        showButton = false
    }
    
    func quit() {
        showButton = true
        showQuestions = false
        numCorrect = 0
        numGuessed = 0
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
            ContentView()
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}


