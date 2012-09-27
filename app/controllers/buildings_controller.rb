class BuildingsController < UIViewController
  def viewDidLoad
    super

    # Set an activity indicator while we load data from network
    @activityIndicator = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    @activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0)
    @activityIndicator.center = self.view.center
    self.view.addSubview(@activityIndicator)
    load_buildings
  end
  
  def load_buildings
    @buildings = []
    Building.find_all do |building|
      @buildings << building
    end
  end
end