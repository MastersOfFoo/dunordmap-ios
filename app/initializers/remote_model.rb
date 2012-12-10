module RemoteModule
  class RemoteModel
    # The default URL for our requests.
    # Overrideable per model subclass
    # self.root_url = "http://localhost:3000/"
    # self.root_url = "http://localhost:3000/api/v1/"
    self.root_url = "http://dunordmap-server.herokuapp.com/api/v1/"

    # Options attached to every request
    # Appendable per model subclass
    # See BubbleWrap docs on what can be passed in BubbleWrap::HTTP.<method>(url, options)
    self.default_url_options = {
        :headers => {
          "Accept" => "application/json"
        }
      }
  end
end
