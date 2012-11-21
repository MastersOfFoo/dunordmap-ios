class BuildingDetailsController < UIViewController
  attr_accessor :building, :image, :image_view

  def viewDidLoad
    super
    @image_view = UIImageView.alloc.init
    @image_view.frame = CGRectMake(10, 25, 300, 200)
    @image_view.backgroundColor = "#EEEDE4".to_color
    load_image

    #self.view.addSubview(@image_view)
    self.view.backgroundColor = "#EEEDE4".to_color
    self.title = @building.name
  end
  
  def load_image
    unless self.image
      self.image_view.image = nil
      image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(self.building.image))
      if image_data
        self.image = UIImage.alloc.initWithData(image_data)
        self.image_view.image = self.image
        self.view.addSubview(self.image_view)
      else
        # failure
        alert_box = UIAlertView.alloc.initWithTitle("Error", message:"Error loading image",
          delegate: nil, cancelButtonTitle: "ok", otherButtonTitles: nil)

        # Show it to the user
        alert_box.show
      end
    else
      self.image_view.image = self.image
    end
  end
end