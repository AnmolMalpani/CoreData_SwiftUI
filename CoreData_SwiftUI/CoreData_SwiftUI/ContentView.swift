//
//  ContentView.swift
//  CoreData_SwiftUI
//
//  Created by Anmol Maheshwari on 10/05/20.
//  Copyright © 2020 Anmol Maheshwari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: UserInfo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserInfo.firstName, ascending: true)]) var users: FetchedResults<UserInfo>
    @State private var showingAddUser = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { userInfo in
                    NavigationLink(destination: Text(userInfo.lastName)) {
                        VStack(alignment: .leading) {
                            Text("\(userInfo.firstName) \(userInfo.lastName)")
                            Text(userInfo.gender)
                        }
                        Spacer()
                    }
                }
                .onDelete(perform: deleteUser(at:))
                .edgesIgnoringSafeArea(.all)
                if users.count == 0 {
                    Text("No user found")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Users")
            .navigationBarItems(leading: EditButton(),
                                trailing: Button("Add") {
                                    self.showingAddUser.toggle()
            })
                .sheet(isPresented: $showingAddUser) {
                    AddView().environment(\.managedObjectContext,
                                          self.moc)
            }
        }
    }
    
    func deleteUser(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]
            moc.delete(user)
        }
        try? moc.save()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
