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

    it "makes a GET request to https://api.github.com/repos/USER/REPO/releases", ->
      # make the request
      api.version()

      # check the url
      request_url  = jasmine.Ajax.requests.mostRecent().url
      expected_url = "https://api.github.com/repos/#{user}/#{repo}/releases"

      expect(request_url).toBe(expected_url)

    it "returns the version name", (done)->
      # make the request
      api.version (attributes)->
        expect(attributes.tag_name).toEqual("1.0.0-alpha.3")
        done()

      # return a json payload with the version name
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '[{"tag_name": "1.0.0-alpha.3"}]'

    it "returns the published_at timestamp", (done)->
      # make the request
      api.version (attributes)->
        expect(attributes.published_at).toEqual("2016-01-09T05:31:01Z")
        done()

      # return a json payload with the published_at timestamp
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '[{"published_at": "2016-01-09T05:31:01Z"}]'

    it "returns the latest release", (done)->
      # make the request
      api.version (attributes)->
        expect(attributes.tag_name).toEqual("1.1.2")
        done()

      # return a json payload with multiple versions
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '[{"tag_name": "1.1.0"}, {"tag_name": "1.1.2"}, {"tag_name": "1.1.1"}]'

    it "returns the latest pre-release", (done)->
      # make the request
      api.version (attributes)->
        expect(attributes.tag_name).toEqual("1.0.0-alpha.3")
        done()

      # return a json payload with multiple versions
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '[{"tag_name": "1.0.0-alpha.1"}, {"tag_name": "1.0.0-alpha.3"}, {"tag_name": "1.0.0-alpha.2"}]'

    it "returns the latest release with a high minor version number", (done)->
      # make the request
      api.version (attributes)->
        expect(attributes.tag_name).toEqual("3.16")
        done()

      # return a json payload with multiple versions
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '[{"tag_name": "3.1"}, {"tag_name": "3.16"}, {"tag_name": ""}]'

    it "returns the latest release coming out of alpha", (done)->
      # make the request
      api.version (attributes)->
        expect(attributes.tag_name).toEqual("1.0.0")
        done()

      # return a json payload with multiple versions
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '[{"tag_name": "1.0.0"}, {"tag_name": "1.0.0-alpha.3"}]'

    it "returns the latest release jumping a major version", (done)->
      # make the request
      api.version (attributes)->
        expect(attributes.tag_name).toEqual("3.0.0")
        done()

      # return a json payload with multiple versions
      jasmine.Ajax.requests.mostRecent().respondWith
        "status":       200
        "contentType":  'application/json'
        "responseText": '[{"tag_name": "1.0.0"}, {"tag_name": "3.0.0"}, {"tag_name": "2.0.0"}]'



  xit "makes a requst for real", (done)->
    api = new GithubApi
      user: "alextaujenis"
      repo: "RobotsBigData"

    api.version (attributes)->
      console.log "#{api.repo} v#{attributes.tag_name}, last published: #{attributes.published_at}"
      done()
