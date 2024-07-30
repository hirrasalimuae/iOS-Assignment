#Employee Directory App

###This is an iOS application that displays a directory of employees. The app fetches employee data from a remote JSON endpoint and displays the employees' full name, image, phone number, biography, and email in a table view. The app handles error states and displays appropriate messages when the data is not found or fails to load.

#Features

##Fetches and displays employee data from a remote endpoint.
###Shows employee full name, image, phone number, biography, and email.
###Handles and displays error states for empty data and network failures.
###Supports localization for English and French.

###Includes unit tests for network manager and view controller.
#Project Structure

###Employee Directory App: The main application.
###NetworkManagerFramework: A separate framework for handling network operations.
###Constants: A file containing constant values such as URLs.
###Localizable.strings: Files for supporting localization.

#Approach

##Main View
###The main view displays a list of employees.
###If the employee list is empty or an error occurs, a placeholder message is displayed.

##NetworkManagerFramework

###Handles all network requests.
###Provides methods for fetching data from the given URLs.
###Constants
###A dedicated Constants file is used to manage URLs centrally.
###Localization
###The app supports English and French.
###Localizable strings are stored in Localizable.strings files for each supported language.
###To add more languages, update the Localizable.strings files.


##Error Handling

###The app displays a placeholder message when no employees are found.
###If a network error occurs, an alert is shown with a retry option.
##Unit Tests
###Unit tests are included for the NetworkManager and EmployeeListViewController.
###Tests for successful and failed network requests are included.
###Tests for proper UI element initialization and data handling in the view controller are included.
## To run unit tests open iOS_AssignmentUITests and NetworkManagerFrameworkTests


#Adding a New Language

###Localizable.strings is already added in this project.
###Add the necessary translations for the new language in the Localizable.strings file.
