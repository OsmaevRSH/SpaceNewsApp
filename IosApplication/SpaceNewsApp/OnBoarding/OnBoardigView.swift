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
			PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                .frame(height: UIScreen.main.bounds.height / 2)
                .padding(.top, 16)
            Spacer()
			Group {
				Text(titles[currentPageIndex])
					.font(.title)
				Text(captions[currentPageIndex])
					.font(.subheadline)
					.foregroundColor(.gray)
					.frame(width: 300, height: 50, alignment: .leading)
					.lineLimit(nil)
			}
            .padding([.leading, .trailing], 32)
            .padding([.top, .bottom], 16)
            Spacer()
			HStack() {
                PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
                    .frame(width: 40)
                Spacer()
				Button(action: {
					if self.currentPageIndex + 1 != self.subviews.count {
                        self.currentPageIndex += 1
                    }
                    else {
                        UserDefaults.standard.set(true, forKey: "LaunchBefore")
                        withAnimation {
                            self.viewlaunch.currentPage = "ContentView"
                        }
                    }
				}) {
                    if self.currentPageIndex + 1 == self.subviews.count {
                        CompleteButtonContent()
                    } else {
                        NextButtonContent()
                    }
				}
			}
            .padding([.leading, .trailing], 32)
            .padding([.top, .bottom], 16)
		}
	}
}

struct NextButtonContent: View {
	var body: some View {
		Text(verbatim: "Next")
            .foregroundColor(.black)
			.frame(width: 50, height: 4)
			.padding()
			.background(Color.orange)
			.cornerRadius(30)
	}
}

struct CompleteButtonContent: View {
    var body: some View {
        Text(verbatim: "Complete")
            .foregroundColor(.black)
            .frame(width: 90, height: 4)
            .padding()
            .background(Color.orange)
            .cornerRadius(30)
    }
}
