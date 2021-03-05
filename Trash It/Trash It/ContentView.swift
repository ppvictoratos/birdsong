//
//  ContentView.swift
//  Trash It
//
//  Created by Peter Victoratos on 2/18/21.
//

import SwiftUI
import CoreData

//core data stuff

var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Affirmations")
    
    container.loadPersistentStores { _, error in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    return container
}()

func saveContext() {
    let context = persistentContainer.viewContext
    
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

//splash screen says text below with 5 second delay into a gaussian opacity shift
    //"Use this app whenever you are thinking bad thoughts, find yourself mindlessly scrolling social media or just to chat with yourself :)"

//hitting the logo will switch the background and foreground color and bring user to their saved documents relating to each tab

struct ExampleView: View {
    @State private var affirmation1: String = "Your proudest trait"
    @State private var affirmation2: String = "What you did well at recently"
    @State private var affirmation3: String = "Rate your fit today"
    
    @State private var trash1: String = "Something you hate doing"
    @State private var trash2: String = "What do you want to say to them?"
    @State private var trash3: String = "A crazy thought you had"
    
    @State private var credit1: String = "Name something nice you did for someone"
    @State private var credit2: String = "Did you make your bed?"
    @State private var credit3: String = "Go above and beyond at work?"
    
    @State private var invalid: Bool = false
    
    
    
    var body: some View {
        TabView {
            
            //affirmations list of text fields, save button
            VStack {
                Text("brag about yourself! but don't write anything too shallow, put some thought into identifying positive characteristics you display regularly")
                    .padding()
                
                    Form {
                        TextField("1",
                                  text: $affirmation1,
                                  onEditingChanged: { changing in
                                    if !changing {
                                        self.affirmation1 = self.affirmation1.trimmingCharacters(in: .whitespacesAndNewlines)
                                    } else {
                                        self.invalid = false
                                        self.affirmation1 = ""
                                    }},
                                  onCommit: validate)
                            .font(.subheadline)
                            .opacity(0.2)
                            
                        
                        TextField("2",
                                  text: $affirmation2,
                                  onEditingChanged: { changing in
                                    if !changing {
                                        self.affirmation2 = self.affirmation2.trimmingCharacters(in: .whitespacesAndNewlines)
                                    } else {
                                        self.invalid = false
                                        self.affirmation2 = ""
                                    }},
                                  onCommit: validate)
                            .font(.subheadline)
                            .opacity(0.2)
                        
                        TextField("3",
                                  text: $affirmation3,
                                  onEditingChanged: { changing in
                                    if !changing {
                                        self.affirmation3 = self.affirmation3.trimmingCharacters(in: .whitespacesAndNewlines)
                                    } else {
                                        self.invalid = false
                                        self.affirmation3 = ""
                                    }},
                                  onCommit: validate)
                            .font(.subheadline)
                            .opacity(0.2)

                        
                        if self.invalid {
                            Text("Required field(s) are empty")
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                        }
                    }.textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save") {
                    saveContext()
                }
                .padding()
            }
            .tabItem({ TabLabel(imageName: "star.lefthalf.fill", label: "Affirmations") })

            //throw aways list of text fields that disappear, trash button
            VStack {
                Text("while we dont encourage users to abuse this future, it is good to write down negative thoughts, angry texts you want to send and other irational thoughts")
                    .padding()
                
                Form {
                    TextField("1",
                              text: $trash1,
                              onEditingChanged: { changing in
                                if !changing {
                                    self.trash1 = self.trash1.trimmingCharacters(in: .whitespacesAndNewlines)
                                } else {
                                    self.invalid = false
                                }},
                              onCommit: validate)
                        .font(.subheadline)
                        .opacity(0.2)
                    
                    TextField("2",
                              text: $trash2,
                              onEditingChanged: { changing in
                                if !changing {
                                    self.trash2 = self.trash2.trimmingCharacters(in: .whitespacesAndNewlines)
                                } else {
                                    self.invalid = false
                                }},
                              onCommit: validate)
                        .font(.subheadline)
                        .opacity(0.2)
                    
                    TextField("3",
                              text: $trash3,
                              onEditingChanged: { changing in
                                if !changing {
                                    self.trash3 = self.trash3.trimmingCharacters(in: .whitespacesAndNewlines)
                                } else {
                                    self.invalid = false
                                }},
                              onCommit: validate)
                        .font(.subheadline)
                        .opacity(0.2)

                    
                    if self.invalid {
                        Text("Required field(s) are empty")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                    }
                }.textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Trash 'Em") {
                print()
            }
            .padding()
            }
            .tabItem({ TabLabel(imageName: "trash.fill", label: "Throw Aways") })

            
            VStack {
                Text("The credit list is simply a daily list that you make of positive things you deserves credit for.").padding()
                
                Form {
                    TextField("1",
                              text: $credit1,
                              onEditingChanged: { changing in
                                if !changing {
                                    self.credit1 = self.credit1.trimmingCharacters(in: .whitespacesAndNewlines)
                                } else {
                                    self.invalid = false
                                }},
                              onCommit: validate)
                        .font(.subheadline)
                        .opacity(0.2)
                    
                    TextField("2",
                              text: $credit2,
                              onEditingChanged: { changing in
                                if !changing {
                                    self.credit2 = self.credit2.trimmingCharacters(in: .whitespacesAndNewlines)
                                } else {
                                    self.invalid = false
                                }},
                              onCommit: validate)
                        .font(.subheadline)
                        .opacity(0.2)
                    
                    TextField("3",
                              text: $credit3,
                              onEditingChanged: { changing in
                                if !changing {
                                    self.credit3 = self.credit3.trimmingCharacters(in: .whitespacesAndNewlines)
                                } else {
                                    self.invalid = false
                                }},
                              onCommit: validate)
                        .font(.subheadline)
                        .opacity(0.2)

                    
                    if self.invalid {
                        Text("Required field(s) are empty")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                    }
                }.textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
                print()
            }
            .padding()
            }
            .tabItem({ TabLabel(imageName: "text.badge.star", label: "Credit List") })

        }
    }
    
    struct TabLabel: View {
        let imageName: String
        let label: String
        
        var body: some View {
            HStack {
                Image(systemName: imageName)
                Text(label)
            }
        }
    }
    
    func validate() {
        if self.affirmation1 == "" || self.affirmation2 == "" || self.affirmation3 == "" || self.trash1 == "" || self.trash2 == "" || self.trash3 == "" || self.credit1 == "" || self.credit2 == "" || self.credit3 == "" {
            self.invalid = true
        }
    }
}

struct ContentView: View {
    var body: some View {
        ExampleView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
