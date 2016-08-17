# Github API.js

An in-browser, javascript based wrapper for the Github API to retrieve repository release data. This library has no external dependencies.

## Live demo

See a live demo with repo version and last updated timestamp - async from the Github API:
[http://robotsbigdata.com](http://robotsbigdata.com)

## Where to begin

Include the github\_api.js source file (or minified version) in your html page

```<script src="dist/github_api.min.js"></script>```

Create a new GithubApi object and pass in the user and repo names:

```var api = new GithubApi({user: "alextaujenis", repo: "RobotsBigData"});```

Then fetch the repo release data:

```api.version(function(attributes) {
  alert(api.repo + " v" + attributes.tag_name + " last published " + attributes.published_at);
});```

## Json attributes

Check out the Github docs to see the json response from this library:

[https://developer.github.com/v3/repos/releases/#list-releases-for-a-repository](https://developer.github.com/v3/repos/releases/#list-releases-for-a-repository)

# Development
## Get started

`npm install`

## Compile for dist

`npm start`

## Run all specs

`npm test`

#License
This code is available under the [MIT License](http://opensource.org/licenses/mit-license.php).