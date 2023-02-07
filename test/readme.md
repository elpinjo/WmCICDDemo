# webMethods Unit Test Framework Test Executor


For continuous integration you can invoke headless tests through Test Suite Executor build script. The ant script can be driven by specifying necessary property details through properties file or through any supported jvm-arguments. 

WmTestSuite Code coverage tests can be invoked in headless mode through ant target "composite-runner-all-tests". This target is recommended for regular test execution as well.

### Getting Started


#### Creating a Test Suite Executor


Software AG Designer allows you to create Test Suite executor projects and execute tests in headless mode.
Perform the following steps to create a sample test suite executor using the default files.
1. Select File>New> Test Suite Executor.
2. On the Test Suite Executor Project screen, enter the project name, folder path that contains the test suite setup files, and the file system. You can choose to use the default values.
3. Click Finish.
  
Project contains default Ant build targets and properties to drive the tests.




#### Prerequisites


#### Setting up Properties for Target Server Definition and Project locations
For Continuous Integration or headless executions, specify the following property values as Ant properties or jvm arguments to drive your tests from specified project locations in any target server location and with user defined preferences.



Example: Sample Test Suite Executor Properties file:


### Integration Server definition

##### Specifies the Integration Server host name. For example: localhost, 27.0.0.1
	webMethods.integrationServer.name=localhost

##### Specifies the Integration Server port. For example: 5555
	webMethods.integrationServer.port=5555

##### Specifies the Integration Server user name. For example: Administrator, Developer
	webMethods.integrationServer.userid=Administrator

##### Specifies the Integration Server user password. For example: manage
	webMethods.integrationServer.password=manage

##### Specifies the Integration Server port uses SSL connection or normal. For example: false or true
	webMethods.integrationServer.ssl=false



### Network Proxy configurations

A proxy server allows indirect connection to network services and is used mainly for security (to get through firewalls) and performance reasons (proxies often do provide caching mechanisms). The following properties allow for configuration of the various type of proxies.

### HTTP proxy to use for communications with the Integration Server.

##### Specify the host name or the IP address of a proxy server.If you do not specify any value, connection with the proxy server is not established.
	watt.net.proxyHost=webcache.example.com
##### Specify the port number of a proxy server. When watt.net.proxyHost is appropriately specified, port number 80 of the host specified in watt.net.proxyHost is accessed if you do not specify any value in watt.net.proxyPort. When you do not specify any value in watt.net.proxyHost, connection with the proxy server is not established even if watt.net.proxyPort is specified.
	watt.net.proxyPort=8080

##### User and Password are optional and can be null.	
	watt.net.proxyUser=
	watt.net.proxyPass=

### HTTPs proxy to use for communications with the Integration Server.

##### Specify the host name or the IP address of a proxy server to be used in connections by the SSL protocol. You must specify the host name or the IP address to use a proxy server in connections by the SSL protocol. Note that if you do not specify the host name or the IP address, connection with the proxy server is not established.
	watt.net.secureProxyHost=webcache.example.com
##### Specify the port number of a proxy server to be used in connections by the SSL protocol#. Note that when watt.net.secureProxyHost is appropriately specified, the port number 443 of the host specified in watt.net.secureProxyHost is accessed, if you do not specify any value in watt.net.secureProxyPort. If you do not specify any value in watt.net.secureProxyHost, connection with the proxy server is not established even if watt.net.secureProxyPort is specified.
	watt.net.secureProxyPort=443

##### User and Password are optional and can be null.	
	watt.net.secureProxyUser=
	watt.net.secureProxyPass=


##### Indicates the hosts that should be accessed without going through the proxy. Typically this defines internal hosts. The value of this property is a list of hosts, separated by the '|' character. In addition the wildcard character '*' can be used for pattern matching. For example http.nonProxyHosts=”*.foo.com|localhost” will indicate that every hosts in the foo.com domain and the localhost should be accessed directly even if a proxy server is specified.
	http.nonProxyHosts=localhost|127.*|[::1]



### Installation Location

##### Specifies the product installation location. For example: C\:\\SoftwareAG
	webMethods.home=C\:\\SoftwareAG


### Absolute paths of Project locations

##### Specifies multiple project locations (absolute directory path) in $AbsoluteProjectLocation1,$AbsoluteProjectLocation2,$AbsoluteProjectLocation3 format. In this case, Test Suite Executor searches for all available and valid WmTestSuite files in these directories.
	webMethods.test.setup.location=\
	C:/SoftwareAG/IntegrationServer/instances/default/packages/SampleTestSuite,\
	C:/_gitRepo/packages/SampleTestSuite1.

##### It executes specific and multiple WmTestSuite files by specifying it in the following format:$AbsoluteProjectLocation1;$RelativeTestSuitePath1,$AbsoluteProjectLocation2;$RelativeTestSuitePath2.
	webMethods.test.setup.location=\
	C:/SoftwareAG/IntegrationServer/instances/default/packages/SampleTestSuite;resources/test/setup/wmTestSuite.xml,\
	C:/_gitRepo/packages/SampleTestSuite1;resources/test/setup/wmTestSuite.xml

##### Specifies the relative paths within the projects where required classes or jar files are expected to be in Test Executor build-classpath. For example, when third-party libraries or Mockfactory classes are referred from the Tests, specify the locations where these are stored at, so that executor can load these dependencies during headless tests. Append the default comma separated list if required.
	webMethods.test.setup.external.classpath.layout=resources/test/classes,resources/java/classes,resources/test/jars,resources/java/jars,resources/jars

##### The absolute path where the reports are stored.
	webMethods.test.profile.result.location=C\:/git_sources/GitRepo3/WmTestSuiteExecutor/test/reports/



##### Set to Coverage to generate coverage report. Set to None for regular test execution.
	webMethods.test.setup.profile.mode=COVERAGE

##### Set to 'true' to generate Service level coverage report. Set to 'false' for regular Code Coverage Report. Default is 'false'.
	webMethods.test.profile.result.includeServiceLevelReport=false

##### Set to 'true' to generate Execution Model. Set to 'false' for regular Code Coverage Report. Default is 'false'.
	webMethods.test.profile.result.includeExecutionModelReport=false


##### Specifies the list of comma separated target Integration Server package names. This Defines the full scope for the coverage analysis and percentage calculation.
	webMethods.test.scope.packages=\
	SampleTestSuite,\
	SampleTestSuite1






### License

Copyright &copy;  2017-2021 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG.