# iCalendar Power BI Connector

[![Build status](https://ci.appveyor.com/api/projects/status/x8lcteimwrvsianj/branch/master?svg=true)](https://ci.appveyor.com/project/lijunle/icalendarconnector/branch/master)

iCalendar Power BI connector enable the iCalendar data source.

## How to use it?

Currently, there are two options to use this custom connector.

1. Open the [iCalendarConnector.pq](iCalendarConnector/iCalendarConnector.pq) file and copy the code to your advanced query editor.
2. Download the latest extension file (`.mez`) from [GitHub release page](https://github.com/lijunle/iCalendarConnector/releases), then install it to your custom connector folder following [this guideline](https://github.com/Microsoft/DataConnectors#quickstart).

In the future, I hope to work with connector team to involve [the *Connector Certification* program](https://docs.microsoft.com/en-us/power-query/connectorcertification).

## How to contribute this project?

1. Git clone this repository.
2. Open solution with Visual Studio.
3. Press `F5` to see the testing result. (On the first time, you need to [set the credential](https://docs.microsoft.com/en-us/power-query/samples/trippin/1-odata/readme#creating-a-basic-odata-connector).)
4. Hack the code and run with `F5` in Visual Studio.
5. Copy the `.mez` file in build folder to custom connector folder and test it in Power BI. (You need to [enable the custom connectors](https://docs.microsoft.com/en-us/power-query/samples/trippin/1-odata/readme#loading-your-extension-in-power-bi-desktop) in Power BI.)

Please note:

- The CI build does ***not*** really test the Power BI connector functionality. It only packages the `.mez` file for manually testing in Power BI.
- Power BI does not provide a way to test the data connection from CLI. If there is updates, please open an issue to let me know.

## License

MIT License.
