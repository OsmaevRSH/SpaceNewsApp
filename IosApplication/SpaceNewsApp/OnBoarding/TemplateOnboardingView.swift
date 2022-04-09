import SwiftUI

struct TemplateOnboardingView: View {
	
	var imageString: String
	
	var body: some View {
        Color.orange.opacity(0.1).overlay(
            Image(imageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
        )
	}
}
