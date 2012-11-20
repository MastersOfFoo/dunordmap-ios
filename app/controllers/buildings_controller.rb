class BuildingsController < UIViewController
  attr_accessor :table_view, :buildings

  def viewDidLoad
    super
    self.buildings = []
    self.view.addSubview(table_view)
    self.title = "Buildings nearby"
    load_buildings
  end
  
  def table_view
    @table_view ||= begin
      table_view = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
      table_view.dataSource = table_view.delegate = self
      table_view.backgroundView = nil
      table_view.backgroundColor = "#EEEDE4".to_color
      table_view.separatorColor = "#9C9C9C".to_color
      table_view
    end
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    end

    cell.textLabel.text = @buildings[indexPath.row].name
    cell.textLabel.textColor = "#7F7F7F".to_color
    cell.textLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 14)
    cell.contentView.backgroundColor = "#F4F5F6".to_color
    cell.accessoryView = UIImageView.alloc.initWithImage(UIImage.imageNamed("arrow.png"))
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    self.buildings.size
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    open_building_details(self.buildings[indexPath.row])
  end

  private

  def open_building_details(building)
    details_controller = BuildingDetailsController.alloc.initWithNibName(nil, bundle: nil)
    details_controller.building = building
    self.navigationController.pushViewController(details_controller, animated: true)
  end

  def load_buildings
    latitude, longitude = App::Persistence['coordinates']
    self.buildings.clear
    Building.search(latitude, longitude) do |buildings|
      buildings.each do |building|
        self.buildings << building
      end
      table_view.reloadData
    end
  end
end