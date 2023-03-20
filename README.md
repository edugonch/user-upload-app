# User Upload App
This Rails app allows users to upload CSV files containing user data and create users from the file's content.

## Features
* Upload CSV files containing user data
* Validates user data and shows errors in case of invalid data
* Creates valid users and shows the results in a table
* Handles empty files and files with invalid formats
## Requirements
* Ruby 3.0.2
* Rails 6.1.4
* PostgreSQL 13.3
## Installation
1. Clone this repository:
```sh
git clone https://github.com/edugonch/user-upload-app.git
cd user-upload-app
```

2. Install dependencies:
```sh
bundle install
```

3. Set up the database:
```sh
rails db:create db:migrate
```

4. Start the app:
```sh
rails server
```

5. Open http://localhost:3000/ in your browser and start uploading CSV files.

## Usage
1. Access the app's root URL http://localhost:3000/.
2. Click on the "Choose file" button and select a CSV file containing user data.
3. Click on the "Import" button to upload the file and create users.
4. If the file contains valid user data, the app will show a table with the results. If the file contains invalid data or has an invalid format, the app will show an error message.

## License
The app is available as open source under the terms of the MIT License.