//
//  ListsView.swift
//  AppGroup1
//
//  Created by Giammarco on 17/02/23.
//

import SwiftUI

struct Note: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var content: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ListsView: View {
    @State var notes = [Note]()
    @State var isAddingNote = false
    @State var selectedNote: Note?
    @State var isEditing = false
    @State var selectedNotes: Set<Note> = []

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color.white
                VStack {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                            ForEach(notes) { note in
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
                                }) {
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text(note.title)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                    .padding()
                                    .frame(width: 150, height: 150)
                                    .background(selectedNotes.contains(note) ? Color.blue : Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                Button(action: {
                    selectedNote = nil
                    isAddingNote.toggle()
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(.trailing)
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
                            }) {
                                Text("Delete")
                            }
                        }
                        Button(action: {
                            isEditing.toggle()
                            selectedNotes.removeAll()
                        }) {
                            Text(isEditing ? "Done" : "Edit")
                        }
                    }
            )
            .sheet(isPresented: $isAddingNote) {
                CreateNoteView(notes: $notes, isPresented: $isAddingNote, noteTitle: "", noteContent: "", selectedNote: $selectedNote)
            }
        }
    }
}





struct CreateNoteView: View {
    @Binding var notes: [Note]
    @Binding var isPresented: Bool
    @State var noteTitle: String
    @State var noteContent: String
    @Binding var selectedNote: Note?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $noteTitle)
                    .font(.headline)
                    .padding(.horizontal)
                Divider()
                TextEditor(text: $noteContent)
                    .padding()
                    .frame(minHeight: 300)
                    .onAppear {
                        if selectedNote != nil {
                            noteTitle = selectedNote!.title
                            noteContent = selectedNote!.content
                        }
                    }
            }
            .navigationBarTitle(selectedNote != nil ? "Edit Note" : "New Note", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    if selectedNote != nil {
                        let index = notes.firstIndex(where: { $0.id == selectedNote!.id })!
                        notes[index].title = noteTitle
                        notes[index].content = noteContent
                    } else {
                        notes.append(Note(title: noteTitle, content: noteContent))
                    }
                    isPresented = false
                }
            )
        }
        
    }
}



struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView()
    }
}
