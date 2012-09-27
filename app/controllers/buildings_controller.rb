class BuildingsController < UIViewController
  def viewDidLoad
    super
    @buildings = []
    @table = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
    @table.dataSource = @table.delegate = self
    @table.backgroundView = nil
    @table.backgroundColor = "#EEEDE4".to_color
    @table.separatorColor = "#9C9C9C".to_color

    self.view.addSubview(@table)

    self.title = "Buildings nearby"

    load_buildings
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = @buildings[indexPath.row].name
    cell.textLabel.textColor = "#7F7F7F".to_color
    cell.textLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 14)
    cell.contentView.backgroundColor = "#F4F5F6".to_color
    cell.accessoryView = UIImageView.alloc.initWithImage(UIImage.imageNamed("arrow.png"))
    cell
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @buildings.size
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    open_building_details(@buildings[indexPath.row])
  end

  def open_building_details(building)
    alert = UIAlertView.alloc.init
    alert.message = "#{building.name} clicked"
    alert.addButtonWithTitle "OK"
    alert.show
  end


  private

  def load_buildings
    # Set an activity indicator while we load data from network
    show_activity_indicator
    Building.find_all do |buildings|
      @buildings.clear
      buildings.each do |building|
        @buildings << building
      end
      show_buildings_list
    end
  end

  def show_buildings_list
    # Reload table data
    @table.reloadData

    # Remove activity indicator
    @activityIndicator.removeFromSuperview
  end

  def show_activity_indicator
    @activityIndicator = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleGray)
    @activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0) # TODO: fix for Retina
    @activityIndicator.center = self.view.center
    self.view.addSubview(@activityIndicator)
  end
end