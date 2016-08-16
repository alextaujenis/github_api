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
      api.version (attributes)->
        expect(attributes.name).toEqual("1.0.0-alpha.3")
        done()

      # return a json payload with the version name
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '{"name": "1.0.0-alpha.3"}'

    it "returns the last published_at timestamp", (done)->
      # make the request
      api.version (attributes)->
        expect(attributes.published_at).toEqual("2016-01-09T05:31:01Z")
        done()

      # return a json payload with the published_at timestamp
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '{"published_at": "2016-01-09T05:31:01Z"}'

 xit "makes a requst for real", (done)->
   api = new GithubApi
     user: "alextaujenis"
     repo: "RBD_Timer"

   api.version (attributes)->
     console.log "#{api.repo} v#{attributes.name}, last updated: #{attributes.published_at}"
     done()
