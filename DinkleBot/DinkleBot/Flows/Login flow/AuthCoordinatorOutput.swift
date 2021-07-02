protocol AuthCoordinatorOutput: class {
  var finishFlow: (() -> Void)? { get set }
}
