var GithubApi;

GithubApi = (function() {
  function GithubApi(opts) {
    if (opts == null) {
      opts = {};
    }
    this.user = opts.user;
    this.repo = opts.repo;
    this.version_url = "https://api.github.com/repos/" + this.user + "/" + this.repo + "/releases";
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
      json = this._sort(json)[0];
      callback(json);
    }
  };

  GithubApi.prototype._sort = function(json) {
    return json.sort((function(_this) {
      return function(a, b) {
        var a_alpha, a_major, a_minor, a_patch, a_prerelease, b_alpha, b_major, b_minor, b_patch, b_prerelease;
        a = a.tag_name.split(".");
        b = b.tag_name.split(".");
        a_major = _this._parse(a[0]);
        a_minor = _this._parse(a[1]);
        a_patch = _this._parse(a[2]);
        a_alpha = _this._parse(a[3]);
        b_major = _this._parse(b[0]);
        b_minor = _this._parse(b[1]);
        b_patch = _this._parse(b[2]);
        b_alpha = _this._parse(b[3]);
        if ((a[2] != null) && (b[2] != null)) {
          a_prerelease = a[2].match(/alpha/);
          b_prerelease = b[2].match(/alpha/);
          a_prerelease = (a_prerelease != null) && (a_prerelease[0] != null);
          b_prerelease = (b_prerelease != null) && (b_prerelease[0] != null);
          if (!a_prerelease && b_prerelease) {
            return -1;
          }
        }
        if (a_major > b_major) {
          return -1;
        }
        if (a_major === b_major && a_minor > b_minor) {
          return -1;
        }
        if (a_major === b_major && a_minor === b_minor && a_patch > b_patch) {
          return -1;
        }
        if (a_major === b_major && a_minor === b_minor && a_patch === b_patch && a_alpha > b_alpha) {
          return -1;
        }
        return 1;
      };
    })(this));
  };

  GithubApi.prototype._parse = function(number) {
    if ((number != null) && number !== "") {
      return parseInt(number);
    } else {
      return 0;
    }
  };

  return GithubApi;

})();
