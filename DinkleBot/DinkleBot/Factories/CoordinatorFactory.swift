protocol CoordinatorFactory {
	func makeTabbarCoordinator() -> (configurator: Coordinator, toPresent: Presentable?)
  func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput
	func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput
	func makeSettingsCoordinator() -> Coordinator
	func makeSettingsCoordinator(navController: UINavigationController?) -> Coordinator
	func makeHomeCoordinator() -> Coordinator
	func makeHomeCoordinator(navController: UINavigationController?) -> Coordinator
}
