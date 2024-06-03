////
////  CardEditView.swift
////  CardKeeper
////
////  Created by Tim Coder on 6/2/24.
////
//
//import SwiftUI
//import SwiftData
//
//
//struct CardEditView: View {
//    @Bindable var card: Card
//    @Environment(\.dismiss) var dismiss
//    @State private var transactionText = ""
//    @Environment(\.modelContext) var modelContext
//    
//    @State private var sourceType : SourceType?
//    
//    var body: some View {
//        List {
//            cardInfoView
//            transactionsView
//            
//            GroupBox("Note") {
//                TextEditor(text: $card.note)
//            }
//            GroupBox("Expiration Date") {
//                DatePicker("Exp Date", selection: $card.expirationDate, displayedComponents: .date)
//            }
//            GroupBox("Image") {
//                if let imageData = card.imageData, let uiImage = UIImage(data: imageData) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity)
//                    
//                } else {
//                    
//                    Text("Take a photo or choose from photo library")
//                        .font(.callout)
//                }
//                HStack {
//                    
//                    Button(action: {
//                        sourceType = .camera
//                    }, label: {
//                        Image(systemName: "camera").font(.title2)
//                    }).buttonStyle(BorderedButtonStyle())
//                        .frame(maxWidth: .infinity)
//                    Button(action: {
//                        sourceType = .photoLibrary
//                    }, label: {
//                        Image(systemName: "photo.stack").font(.title2)
//                    }).buttonStyle(BorderedButtonStyle())
//                        .frame(maxWidth: .infinity)
//                    
//                }.buttonStyle(PlainButtonStyle())
//            }
//        }
//        .toolbar {
//            Button(role: .none) {
//                dismiss()
//            } label: {
//                Text("Done")
//            }.buttonStyle(BorderedButtonStyle())
//        }
//        .listStyle(.plain)
//        .navigationTitle("Card Details")
//        .sheet(item: $sourceType) { sourceType in
//            CameraView(sourceType: sourceType, imageData: $card.imageData)
//        }
//    }
//}
//
//extension CardEditView {
//    var cardInfoView: some View {
//        GroupBox("Card Info"){
//            TextField("Card Name", text: $card.name)
//                .textFieldStyle(.roundedBorder)
//            Picker("Card Type", selection: $card.type) {
//                ForEach(CardType.allCases) { cardType in
//                    Text(cardType.text).tag(cardType)
//                }
//            }.pickerStyle(.segmented)
//        }
//
//    }
//    
//    var transactionsView: some View {
//        GroupBox {
//            HStack {
//                Text("Transactions").font(.headline)
//                Spacer()
//                Button(action: {
//                    let transaction = Transaction(name: transactionText, card: card)
//                    modelContext.insert(transaction)
//                    transactionText = ""
//                }, label: {
//                    Text("Add")
//                }).buttonStyle(BorderedButtonStyle())
//            }
//            TextField("Add Transaction", text: $transactionText)
//                .textFieldStyle(.roundedBorder)
//            if let transactions = card.transactions, !transactions.isEmpty {
//                GroupBox {
//                    VStack(alignment: .leading) {
//                        ForEach(transactions) { transaction in
//                            Text(transaction.name)
//                            Divider()
//                        }
//                    }
//                }
//            } else {
//                Text("No Transactions")
//            }
//            
//        }
//    }
//}
//
//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Card.self, configurations: config)
//    
//    container.mainContext.insert(Card.examples[0])
//    
//    return NavigationStack {
//        CardEditView(card: Card.examples[0])
//            .modelContainer(container)
//    }
//}
