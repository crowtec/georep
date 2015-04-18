module WelcomeHelper

  def queryCtOS(method, params)
    server = XMLRPC::Client.new2("http://178.62.1.193/api")
    resp = server.call(method, params)
  end
end
