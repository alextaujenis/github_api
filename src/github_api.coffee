class GithubApi
  constructor: (opts = {})->
    @user = opts.user
    @repo = opts.repo
    @version_url = "https://api.github.com/repos/#{@user}/#{@repo}/releases/latest"
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
      json    = JSON.parse(xhr.responseText)
      payload =
        name:         json.name
        published_at: json.published_at

      callback(payload)
      return