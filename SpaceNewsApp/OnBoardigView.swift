import SwiftUI

struct OnBoardigView: View {
	
	@EnvironmentObject var viewlaunch: ViewLaunch
	
	var subviews = [
		UIHostingController(rootView: TemplateOnboardingView(imageString: "meditating")),
		UIHostingController(rootView: TemplateOnboardingView(imageString: "skydiving")),
		UIHostingController(rootView: TemplateOnboardingView(imageString: "sitting"))
	]
	
	@State var currentPageIndex = 0
	var titles = [
		"Take some time out",
		"Conquer personal hindrances",
		"Create a peaceful mind"
	]
	var captions =  [
		"Take your time out and bring awareness into your everyday life",
		"Meditating helps you dealing with anxiety and other psychic problems",
		"Regular medidation sessions creates a peaceful inner mind"
	]
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				if self.currentPageIndex != 2 {
					Spacer()
					Button(action: {
					}) {
						ExitButtonContent()
					}
					.padding(16)
					.hidden()
				}
				else {
					Spacer()
					Button(action: {
						UserDefaults.standard.set(true, forKey: "LaunchBefore")
						withAnimation {
							self.viewlaunch.currentPage = "ContentView"
						}
					}) {
						ExitButtonContent()
					}
					.padding(16)
				}
			}
			PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
				.frame(height: 500)
			Group {
				Text(titles[currentPageIndex])
					.font(.title)
				Text(captions[currentPageIndex])
					.font(.subheadline)
					.foregroundColor(.gray)
					.frame(width: 300, height: 50, alignment: .leading)
					.lineLimit(nil)
			}
			.padding()
			HStack() {
				PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
					.frame(width: 60, height: 20)
				Spacer()
				Button(action: {
					if self.currentPageIndex+1 == self.subviews.count {
						self.currentPageIndex = 0
					} else {
						self.currentPageIndex += 1
					}
				}) {
					NextButtonContent()
				}
			}
			.padding()
		}
	}
}

struct NextButtonContent: View {
	var body: some View {
		Image(systemName: "arrow.right")
			.resizable()
			.foregroundColor(.white)
			.frame(width: 30, height: 30)
			.padding()
			.background(Color.orange)
			.cornerRadius(30)
	}
}

struct ExitButtonContent: View {
	var body: some View {
		Image(systemName: "stopwatch")
			.foregroundColor(.white)
			.frame(width: 5, height: 5)
			.padding()
			.background(Color.orange)
			.cornerRadius(3)
	}
}
