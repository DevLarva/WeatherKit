import SwiftUI

struct WellMatched: View {
    @EnvironmentObject var aiWellMatchViewModel: AiWellMatchViewModel
    let koreanbeer = [
        "하이네켄",
        "카스"
    ]
    @MainActor
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Well Matched")
                //                .font(.semibold18)
                
                Text(aiWellMatchViewModel.respond)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .onAppear {
            Task {
                do {
                    aiWellMatchViewModel.respond = try await aiWellMatchViewModel.request(prompt: "Please recommend three well-matched food items. with below list ---dish List: \(koreanbeer)")
                    print("\(aiWellMatchViewModel.respond)")
                } catch {
                    print("Error fetching recommendations: \(error)")
                }
            }
            print("onappear call")
        }
    }
}

struct WellMatched_Previews: PreviewProvider {
    static var previews: some View {
        WellMatched()
            .environmentObject(AiWellMatchViewModel())
    }
}
