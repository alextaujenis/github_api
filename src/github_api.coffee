class GithubApi
  constructor: (opts = {})->
    @user = opts.user
    @repo = opts.repo
    @version_url = "https://api.github.com/repos/#{@user}/#{@repo}/releases"
    @

  version: (callback)->
    xhr = new XMLHttpRequest()
    xhr.open('GET', @version_url, true)
    xhr.onreadystatechange = => @_processStateChange(xhr, callback)
    xhr.send()
    return


  # private

  _processStateChange: (xhr, callback)->
    if xhr.readyState == 4 && xhr.status == 200
      json = JSON.parse(xhr.responseText)
      json = @_sortJson(json)[0]
      callback(json)
    return

  _sortJson: (json)->
    json.sort (a, b)->
      if a.name < b.name then return 1
      if a.name > b.name then return -1
      return 0
