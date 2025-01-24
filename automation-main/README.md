# Robot Framework Automation

This project contains automation scripts using Robot Framework for testing a web application.

## Project Structure

- `resources/`: Contains resource files with reusable keywords.
  - `BaseResource.robot`: Contains common keywords used across different test cases.
  - `pages/`: Contains page-specific keywords.
    - `Login.resource`: Keywords related to the login page.
    - `CreateOrganization.resource`: Keywords related to creating an organization.

## Setup

1. Install dependencies:

   ```sh
   pip install -r requirements.txt
   ```
initializing browser
```sh
rfbrowser init
```

## Running Tests

To run the tests, use the following command:

```sh
robot -d ./logs path/to/your/testsuite.robot
```

## Keywords

### Start session

```Starts a new browser session.```

### Login in the application

```Logs into the application.```

### Wait and Click

```Waits for an element to be visible and then clicks it.```

### Wait and fill

```Waits for an element to be visible and then fills it.```

### Show message

```Waits for a message to be visible and takes a screenshot.```

### Verify element is disabled

```Verifies if the specified element is disabled.```

### Verify element is enabled

```Verifies if the specified element is enabled.```

