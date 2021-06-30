final class ModuleFactoryImp:
  AuthModuleFactory,
  OnboardingModuleFactory,
	SettingsModuleFactory,
	HomeModuleFactory {
    
  func makeLoginOutput() -> LoginView {
    return LoginController.controllerFromStoryboard(.auth)
  }
  
  func makeSignUpHandler() -> SignUpView {
    return SignUpController.controllerFromStoryboard(.auth)
  }
    
  func makeTermsOutput() -> TermsView {
    return TermsController.controllerFromStoryboard(.auth)
  }
	
	func makeOnboardingModule() -> OnboardingView {
		return OnboardingController.controllerFromStoryboard(.onboarding)
	}
	
	func makeSettingsOutput() -> SettingsView {
		return SettingsController.controllerFromStoryboard(.settings)
	}
	
	func makeHomeOutput() -> HomeView {
		return HomeController.controllerFromStoryboard(.home)
	}
}
