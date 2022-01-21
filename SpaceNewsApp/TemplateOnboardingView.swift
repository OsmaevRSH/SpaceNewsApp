import SwiftUI

struct TemplateOnboardingView: View {
	
	var imageString: String
	
	var body: some View {
		Image(imageString)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.clipped()
	}
}

#if DEBUG
struct TeamplateOnboardingView_Previews: PreviewProvider {
	static var previews: some View {
		TemplateOnboardingView(imageString: "meditating")
	}
}
#endif
