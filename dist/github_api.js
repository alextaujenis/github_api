var GithubApi;

GithubApi = (function() {
  function GithubApi(opts) {
    if (opts == null) {
      opts = {};
    }
    this.user = opts.user;
    this.repo = opts.repo;
    this.version_url = "https://api.github.com/repos/" + this.user + "/" + this.repo + "/releases/latest";
    this;
  }

  GithubApi.prototype.version = function(callback) {
    var xhr;
    xhr = new XMLHttpRequest();
    xhr.open('GET', this.version_url, true);
    xhr.onreadystatechange = (function(_this) {
      return function() {
        return _this._processStateChange(xhr, callback);
      };
    })(this);
    xhr.send();
  };

  GithubApi.prototype._processStateChange = function(xhr, callback) {
    var json;
    if (xhr.readyState === 4 && xhr.status === 200) {
      json = JSON.parse(xhr.responseText);
      callback(json.name);
    }
  };

  return GithubApi;

})();
