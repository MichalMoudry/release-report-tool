# release-report-tool
A command-line tool for generating reports about project's releases.
## Usage
```shell
rrt -c <config> -f [Console|HTML]
```

## Configuration file description

### Config file example
```json
{
    "url": "https://github.com/MichalMoudry/release-report-tool",
    "accessToken": "",
    "environment": "",
    "startDate": "",
    "numberOfMonths": 0,
    "additionalSources": []
}
```
