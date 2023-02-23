//
//  ListsView.swift
//  AppGroup1
//
//  Created by Giammarco on 17/02/23.
//

import SwiftUI
import Firebase
//struct Note: Identifiable, Hashable {
//    let id : String
//    var title: String
//    var content: String
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//
//    static func ==(lhs: Note, rhs: Note) -> Bool {
//        return lhs.id == rhs.id
//    }
//}

struct PinBoardView: View {
    @State var notes = [SNote]()
    @State var isAddingNote = false
    @State var selectedNote: SNote?
    @State var isEditing = false
    @State var selectedNotes: Set<SNote> = []
    @StateObject var dataManagerNote = DataManagerNote()
    var creationDate = Date()
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color("BackGround").ignoresSafeArea()
                VStack {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: -10)], spacing: 30) {
                            ForEach(dataManagerNote.notes, id: \.id) { note in
                                VStack{
                                    Button(action: { 
                                        if isEditing {
                                            if selectedNotes.contains(note) {
                                                selectedNotes.remove(note)
                                            } else {
                                                selectedNotes.insert(note)
                                            }
                                        } else {
                                            selectedNote = note
                                            isAddingNote.toggle()
                                        }
                                    }){
                                        VStack{
                                            Text(note.content)
                                                .padding()
                                                .font(.system(size: 10))
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(.primary)
                                            Spacer()
                                        }
                                        .frame(width: 150, height: 150)
                                        .background(selectedNotes.contains(note) ? Color.orange : Color("ForeGround"))
                                        .cornerRadius(10)
                                    }
                                    Text(note.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text("\(creationDate.formatted(.dateTime.day().month().year()))")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                }
                            }
                        }
                    }
                    
                    
                }
                .padding(30)
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            selectedNote = nil
                            isAddingNote.toggle()
                        }) {
                            Image(systemName: "plus")
                                .buttonStyle(.bordered)
                                .tint(.pink)
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.accentColor)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }
                    .padding(40)}
                
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(
                trailing:
                    HStack {
                        if isEditing {
                            Button(action: {
                                notes.removeAll { note in
                                    selectedNotes.contains(note)
                                }
                                selectedNotes.removeAll()
                                isEditing = false
                            }) {
                                Text("Delete")
                            }
                        }
                        Button(action: {
                            isEditing.toggle()
                            selectedNotes.removeAll()
                        }) {
                            Text(isEditing ? "Done" : "Edit")
                        }.disabled(notes.isEmpty)
                    }
            )
            .fullScreenCover(isPresented: $isAddingNote) {
                CreateNoteView(notes: $notes, isPresented: $isAddingNote, noteTitle: "", noteContent: "", selectedNote: $selectedNote)
            }
        }
    }
}





struct CreateNoteView: View {
    @Binding var notes: [SNote]
    @Binding var isPresented: Bool
    @State var noteTitle: String
    @State var noteContent: String
    @Binding var selectedNote: SNote?
    @StateObject var dataManagerNote = DataManagerNote()
    @State var hasBulletPoint = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $noteTitle)
                    .font(.title)
                    .padding(.horizontal)
                    .bold()
                TextEditor(text: $noteContent)
                    .font(.system(size: 20))
                    .padding(.horizontal)
                    .onChange(of: noteContent) { [noteContent] newText in
                        if newText.suffix(1) == "\n" && newText > noteContent && hasBulletPoint{
                            self.noteContent.append("\u{2022} ")
                            
                        }
                    }
                
                    .onAppear {
                        if selectedNote != nil {
                            noteTitle = selectedNote!.title
                            noteContent = selectedNote!.content
                        }
                    }
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Button(action: {
                            hasBulletPoint.toggle()
                        }) {
                            Image(systemName: "checklist.unchecked")
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    
                }
            }
            .navigationBarTitle(selectedNote != nil ? "Edit Note" : "New Note", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Done") {
                    
                    if selectedNote != nil {
                        let index = notes.firstIndex(where: { $0.id == selectedNote!.id })!
                        notes[index].title = noteTitle
                        notes[index].content = noteContent
                        let db = Firestore.firestore()
                        
                        db.collection("Note").document(notes[index].id).getDocument { (document, error) in
                            if let document = document, document.exists {
                                db.collection("Note").document(notes[index].id).setData([
                                    "id": notes[index].id,
                                    "title": noteTitle,
                                    "content": noteContent,
                                    
                                ])
                            }
                            else{
                                print("ERRORE \(notes[index].id) \(db.collection("Note").document(notes[index].id).documentID)")
                            }
                            
                        }
                    } else {
                        let id = generateUniqueString()
                        dataManagerNote.addNote(id: id, title: noteTitle, content: noteContent)
                        notes.append(SNote(id: id,title: noteTitle, content: noteContent))
                    }
                    isPresented = false
                }.disabled(noteTitle == "")
            )
        }
        
    }
    func generateUniqueString() -> String {
        let uuid = UUID()
        return uuid.uuidString
    }
}



struct PinBoardView_Previews: PreviewProvider {
    static var previews: some View {
        PinBoardView()
    }
}
