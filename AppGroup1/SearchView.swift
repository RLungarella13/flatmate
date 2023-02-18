import SwiftUI

struct SearchView: View {
    private var listOfCountry = ["ciao","prova","mac","apple"]
    @State var searchText = ""
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        NavigationView {
            List {
                ForEach(countries, id: \.self) { country in
                    HStack {
                        Text(country.capitalized)
                        Spacer()
                    }
                    .padding()
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Search Transaction")
            .navigationBarItems(leading: Button(action:{
                
                presentationMode.wrappedValue.dismiss()
                
            }){
                Text("Dismiss")
            })
        }
    }
    
    // Filter countries
    var countries: [String] {
        // Make countries lowercased
        let lcCountries = listOfCountry.map { $0.lowercased() }
        
        return searchText == "" ? lcCountries : lcCountries.filter { $0.contains(searchText.lowercased()) }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
