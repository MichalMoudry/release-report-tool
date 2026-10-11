# release-report-tool
A command-line tool for generating reports about project's releases.
## Usage
```shell
rrt -c <config> -f [Console|HTML]
```
### Examle
```shell
rrt -c ./config.json -f HTML
```

## Configuration file description
This section contains details fields used within the configuration file.
| Field          | Description                                                                               | Is optional |
|----------------|-------------------------------------------------------------------------------------------|-------------|
| url            | A link to a repository that the release report should be generated for.                   | No          |
| accessToken    | A token used for accessing an API that provides release information about the repository. | Yes         |
| environment    | A name of an environment that the release report should be for.                           | Yes         |
| startDate      | A date that the report should start with (= releases from that date will be considered).  | Yes         |
| numberOfMonths | A number of months that the release report should be generated for.                       | No          |
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
