describe "GithubApi", ->
  user = "github-user-name"
  repo = "github-repo-name"

  it "can be created", ->
    expect(new GithubApi).toEqual(jasmine.any(Object))

  describe "#constructor", ->
    it "accepts a user", ->
      api = new GithubApi(user: user)
      expect(api.user).toEqual(user)

    it "accepts a repo", ->
      api = new GithubApi(repo: repo)
      expect(api.repo).toEqual(repo)

  describe "#version", ->
    beforeEach -> jasmine.Ajax.install()
    afterEach -> jasmine.Ajax.uninstall()

    api = new GithubApi
      user: user
      repo: repo

    it "makes a GET request to https://api.github.com/repos/USER/REPO/releases/latest", ->
      # make the request
      api.version()

      # check the url
      request_url  = jasmine.Ajax.requests.mostRecent().url
      expected_url = "https://api.github.com/repos/#{user}/#{repo}/releases/latest"

      expect(request_url).toBe(expected_url)

    it "returns the version name", (done)->
      # make the request
      api.version (name)->
        expect(name).toEqual("1.3.0")
        done()

      # return a json payload with the version
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '{"name": "1.3.0"}'
