//
//  ListsView.swift
//  AppGroup1
//
//  Created by Giammarco on 17/02/23.
//

import SwiftUI
import Firebase
struct SNote: Identifiable, Hashable {
    let id : String
    var title: String
    var content: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: SNote, rhs: SNote) -> Bool {
        return lhs.id == rhs.id
    }
}

struct PinBoardView: View {
    @State var isAddingNote = false
    @State var selectedNote: SNote?
    @State var isEditing = false
    //@State var selectedNotes: Set<SNote> = []
    @State var selectedNotes =  [SNote]()
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
                                                var index = selectedNotes.firstIndex(of: note)
                                                selectedNotes.remove(at: index!)
                                                
                                            } else {
                                                selectedNotes.insert(note, at: selectedNotes.count)
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
                                removeNotes(selectedNotes: selectedNotes)
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
                        }.disabled(dataManagerNote.notes.isEmpty)
                    }
            )
            .fullScreenCover(isPresented: $isAddingNote) {
                CreateNoteView(notes: $dataManagerNote.notes, isPresented: $isAddingNote, noteTitle: "", noteContent: "", selectedNote: $selectedNote)
            }
        }
    }
    func removeNotes(selectedNotes: [SNote]){
        let db = Firestore.firestore()
        selectedNotes.forEach{ note in
            db.collection("Note").document(note.id).getDocument { (document, error) in
                if let document = document, document.exists {
                    db.collection("Note").document(note.id).delete()
                }
                else{
                    print("ERRORE \(note.id) \(db.collection("Note").document(note.id).documentID)")
                }
                
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
                        let index = notes.firstIndex(where: {$0.id == selectedNote!.id})!
                        notes[index].title = selectedNote!.title
                        notes[index].content = selectedNote!.content
                        let db = Firestore.firestore()
                        
                        db.collection("Note").document(notes[index].id).getDocument { (document, error) in
                            if let document = document, document.exists {
                                db.collection("Note").document(notes[index].id).setData([
                                    "id": notes[index].id,
                                    "title": notes[index].title,
                                    "content": notes[index].content,
                                    
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
