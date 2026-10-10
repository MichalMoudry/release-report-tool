# release-report-tool
A command-line tool for generating reports about project's releases.
## Usage
```shell
rrt -c <config> -f [Console|HTML]
```

## Configuration file description
This section contains details fields used within the configuration file.
| Field          | Description                                                                               | Is optional |
|----------------|-------------------------------------------------------------------------------------------|-------------|
| url            | A link to a repository that the release report should be generated for.                   | No          |
| accessToken    | A token used for accessing an API that provides release information about the repository. |  |
| environment    |  |  |
| startDate      |  |  |
| numberOfMonths |  |  |
### Config file example
```json
{
    "url": "https://github.com/MichalMoudry/release-report-tool",
    "accessToken": "",
    "environment": "",
    "startDate": "",
    "numberOfMonths": 0
}
```
