# liga

Liga stavok hackaton

# How to build application:
  - clone project
  - checkout master branch
  - import into IDE
  - run command in terminal:
  ```sh
      $ flutter pub get
      $ flutter pub run build_runner build
  ```
  - create `config.json` file with following structure:
  ```json
  {
    "sport_radar_api_key": "your_api_key"
  }
  ```
  - replace `your_api_key` with Sport Radar Api key 
  - place this file in `assets` folder
  - install app on you device