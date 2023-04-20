//
//  RecognitionContent.swift
//  MAA
//
//  Created by hguandl on 19/4/2023.
//

import SwiftUI

struct RecognitionContent: View {
    @EnvironmentObject private var viewModel: MAAViewModel
    @Binding var selection: RecognitionEntry?

    var body: some View {
        List(RecognitionEntry.allCases, selection: $selection) { entry in
            entry.label
        }
        .toolbar(content: listToolbar)
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder private func listToolbar() -> some ToolbarContent {
        ToolbarItemGroup {
            switch viewModel.status {
            case .pending:
                Button(action: {}) {
                    ProgressView().controlSize(.small)
                }
                .disabled(true)
            case .busy:
                Button(action: stop) {
                    Label("停止", systemImage: "stop.fill")
                }
                .help("停止")
            case .idle:
                Button(action: start) {
                    Label("开始", systemImage: "play.fill")
                }
                .help("开始")
            }
        }
    }

    // MARK: - Actions

    private func stop() {
        Task {
            try await viewModel.stop()
        }
    }

    private func start() {
        Task {
            switch selection {
            case .recruit:
                try await viewModel.recognizeRecruit()
            case .depot:
                try await viewModel.recognizeDepot()
            default:
                break
            }
        }
    }
}

struct RecognitionContent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecognitionContent(selection: .constant(.recruit))
        }
    }
}

// MARK: - Recognition Entry

enum RecognitionEntry: Int, CaseIterable, Codable, Identifiable {
    var id: Self { self }
    case recruit
    case depot
}

extension RecognitionEntry: CustomStringConvertible {
    var description: String {
        switch self {
        case .recruit:
            return NSLocalizedString("公招词条", comment: "")
        case .depot:
            return NSLocalizedString("仓库材料", comment: "")
        }
    }

    var iconImage: String {
        switch self {
        case .recruit:
            return "person.text.rectangle"
        case .depot:
            return "house"
        }
    }

    var label: some View {
        Label(description, systemImage: iconImage)
    }
}
