import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                NumberView(tabName: "A", number: 0, close: nil)
            }
            .tabItem {
                Image(systemName: "a.square.fill")
                Text("A")
            }
            
            NavigationView {
                NumberView(tabName: "B", number: 0, close: nil)
            }
            .tabItem {
                Image(systemName: "b.square.fill")
                Text("B")
            }
            
            NavigationView {
                NumberView(tabName: "C", number: 0, close: nil)
            }
            .tabItem {
                Image(systemName: "c.square.fill")
                Text("C")
            }
        }
    }
}

struct NumberView: View {
    let tabName: String
    let number: Int
    var title: String { "\(tabName)\(number)" }
    let close: (() -> Void)?
    @State private var presentsSheet: Bool = false
    @State private var presentsFullScreenCover: Bool = false
    var body: some View {
        ZStack {
            if let close = self.close {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            close()
                        } label: {
                            Image(systemName: "xmark")
                                .padding()
                        }
                    }
                    Spacer()
                }
            }
            VStack {
                Text(title)
                NavigationLink {
                    NumberView(tabName: tabName, number: number + 1, close: nil)
                } label: {
                    Text("Push (New)")
                }
                NavigationLink(destination: NumberView(tabName: tabName, number: number + 1, close: nil)) {
                    Text("Push (Old)")
                }
                Button("Sheet") {
                    presentsSheet = true
                }
                Button("Full Screen Cover") {
                    presentsFullScreenCover = true
                }
            }
        }
        .sheet(isPresented: $presentsSheet, onDismiss: {
            print("\(tabName)\(number + 1) onDismiss")
        }, content: {
            NumberView(tabName: tabName, number: number + 1, close: { presentsSheet = false })
        })
        .fullScreenCover(isPresented: $presentsFullScreenCover, onDismiss: {
            print("\(tabName)\(number + 1) onDismiss")
        }, content: {
            NumberView(tabName: tabName, number: number + 1, close: { presentsFullScreenCover = false })
        })
        .onAppear { print("\(title) onAppear") }
        .onDisappear { print("\(title) onDisappear") }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
