import SwiftUI

struct OnBoardigView: View {
	
	@EnvironmentObject var viewlaunch: ViewLaunch
	
	var subviews = [
		UIHostingController(rootView: TemplateOnboardingView(imageString: "1")),
		UIHostingController(rootView: TemplateOnboardingView(imageString: "2")),
		UIHostingController(rootView: TemplateOnboardingView(imageString: "3")),
        UIHostingController(rootView: TemplateOnboardingView(imageString: "4"))
	]
	
	@State var currentPageIndex = 0
	var titles = [
        "News page",
        "Video page",
        "Map page",
        "Augmented Reality page"
	]
    
	var captions =  [
        "Here you can find all the latest space-related news, read them, and save them for offline access",
        "On this page you can watch videos and streams about space. It is also possible to send a video to someone",
        "On this page, you can use the search to find a place or city, find out the number of residents in this area or city, as well as the nearest districts or cities within a radius of 100 km",
        "On this page you can see our planet in augmented reality, see Starlink satellites, and also get information on each separate satellite"
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
        .background(Color.orange.opacity(0.1).edgesIgnoringSafeArea(.all))
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
