//
//  ContentView.swift
//  AlwaysNote
//
//  Created by DaanSmit on 10/02/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.verticalSizeClass) private var vSizeClass
    @State private var noteContents: String = """
        Lief dagboek,

        Vandaag heb ik op Avans geleerd
        hoe ik een notitie app moet maken.
        """
    @AppStorage("fontSize") private var fontSize = 17.0
    private let fontName = "Noteworthy-bold"
    

    var body: some View {
        let isWide = (hSizeClass == .regular)
        let layout: AnyLayout = isWide ? AnyLayout(VStackLayout(spacing: 16)) : AnyLayout(VStackLayout(spacing: 12))

        layout {
            HeaderView(
                title: "AlwaysNote",
                onSave: { /* save */ },
                onDecreaseFont: { fontSize = max(fontSize - 1, 8) },
                onIncreaseFont: { fontSize = min(fontSize + 1, 60) }
            )
            .frame(maxWidth: isWide ? 500 : .infinity, alignment: .leading)

            EditorView(text: $noteContents, fontName: fontName, fontSize: fontSize)
        }
        .padding()
        .background(
            Color(.yellow)
                .opacity(0.3)
        )
    }
}

struct HeaderView: View {
    let title: String
    let onSave: () -> Void
    let onDecreaseFont: () -> Void
    let onIncreaseFont: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            TitleView(title: title)

            HStack {
                ButtonView(label: "Save", action: onSave)

                Spacer()

                ButtonView(label: "a", action: onDecreaseFont)
                ButtonView(label: "A", action: onIncreaseFont)
            }
        }
    }
}

struct TitleView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.custom("Hoefler Text", size: 60))
            .foregroundColor(.yellow)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ButtonView: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
        }
        .buttonStyle(.plain)
        .foregroundColor(.blue)
        .padding(.vertical, 4)
    }
}

struct EditorView: View {
    @Binding var text: String
    let fontName: String
    let fontSize: CGFloat

    var body: some View {
        TextEditor(text: $text)
            .font(.custom(fontName, size: fontSize))
            .padding(12)
            .background(Color.orange.opacity(0.35))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.orange.opacity(0.35))
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
