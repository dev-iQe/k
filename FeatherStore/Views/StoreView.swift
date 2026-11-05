import SwiftUI

struct StoreView: View {
    @StateObject private var viewModel = StoreViewModel()
    @State private var newSourceURL = ""
    @State private var showingAddSource = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("السورسات المضافة")) {
                    ForEach(viewModel.sources, id: \.identifier) { source in
                        VStack(alignment: .leading) {
                            Text(source.name).font(.headline)
                            Text("\(source.apps.count) تطبيق").font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }
                
                Section(header: Text("التطبيقات المتاحة")) {
                    ForEach(viewModel.allApps) { app in
                        HStack {
                            AsyncImage(url: URL(string: app.iconURL)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text(app.name).font(.headline)
                                Text(app.version).font(.caption).foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button("توقيع وتثبيت") {
                                viewModel.signAndInstall(app: app)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
            }
            .navigationTitle("Feather Store")
            .toolbar {
                Button(action: { showingAddSource.toggle() }) {
                    Image(systemName: "plus")
                }
            }
            .alert("إضافة سورس جديد", isPresented: $showingAddSource) {
                TextField("رابط الـ JSON", text: $newSourceURL)
                Button("إضافة", action: { viewModel.addSource(url: newSourceURL) })
                Button("إلغاء", role: .cancel) {}
            }
        }
    }
}
