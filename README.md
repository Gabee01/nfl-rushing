# NFL Rushing Statistics Project

## Project Description
This project was developed as part of a job application process for a senior Elixir role. It demonstrates skills in data processing and Elixir development by creating a web application that displays and manipulates NFL rushing statistics.

The application allows users to view, sort, filter, and download NFL rushing data. Although it was not successful in the job application, it showcases valuable skills in building interactive web applications with Elixir and Phoenix.

## Main Technologies and Libraries
- Elixir
- Phoenix Framework
- Phoenix LiveView
- Docker & Docker Compose

## Project Structure and Key Files
- `lib/nfl_rushing_live.ex`: Contains the LiveView module that handles sorting and filtering of the data.
- `lib/nfl_rushing.ex`: Contains the low-level code for listing, ordering, and filtering logic.
- `rushing.json`: The source data file containing NFL rushing statistics.
- `docker-compose.yml`: Defines the Docker services for running the application and tests.

## Setup and Running Instructions

### Requirements
- Git
- Docker & Docker Compose

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/Gabee01/nfl-rushing.git
   cd nfl-rushing
   ```

2. Run the application:
   ```bash
   docker-compose up web
   ```
   The application will be available at `http://localhost:4000/`

3. Run the test suite:
   ```bash
   docker-compose up test
   ```
   This will run the tests with code coverage, credo, and format checking.

## How to Use the Application
1. Open your web browser and navigate to `http://localhost:4000/`
2. You will see a table displaying NFL rushing statistics.
3. Use the search bar to filter players by name.
4. Click on column headers to sort the data by Total Rushing Yards, Longest Rush, or Total Rushing Touchdowns.
5. Use the "Download CSV" button to download the current view of the data as a CSV file.

## Interesting Challenges and Solutions
1. **Data Processing**: Handling and efficiently processing large datasets was a key challenge. This was addressed by implementing efficient sorting and filtering algorithms in Elixir.

2. **Real-time Updates**: Implementing real-time updates for sorting and filtering was achieved using Phoenix LiveView, providing a responsive user experience without the need for complex client-side JavaScript.

3. **CSV Export**: Exporting the filtered and sorted data as CSV was implemented using a JavaScript library, showcasing the ability to integrate external tools when necessary.

## Potential Improvements
1. Implement pagination to handle even larger datasets more efficiently.
2. Add more advanced filtering options (e.g., filter by team, position, or statistical thresholds).
3. Improve the UI/UX with a more polished design and responsive layout.
4. Implement user authentication and the ability to save favorite players or custom views.

## Learnings from the Project
1. Gained practical experience with Phoenix LiveView for building interactive web applications.
2. Improved skills in data processing and manipulation using Elixir.
3. Learned to integrate Docker for easy setup and deployment of Elixir applications.
4. Enhanced understanding of test-driven development in Elixir, achieving 100% test coverage.
5. Improved ability to write clean, well-structured Elixir code following best practices.

While this project didn't lead to a job offer, it provided valuable experience in building a full-stack Elixir application and working with real-world data processing challenges.

## About the Implementation
- Phoenix LiveView was used to load, filter, and order the table, providing a responsive user experience.
- A JavaScript library (table2csv) was integrated to export the CSV from the current table visualization.
- The project structure follows Elixir and Phoenix best practices, with clear separation of concerns between data processing (`NflRushing`) and presentation (`NflRushingLive`).
- Test coverage is maintained at 100% (excluding some framework-specific files), ensuring reliability and ease of future modifications.

This project demonstrates the ability to create efficient, well-tested, and user-friendly web applications using Elixir and Phoenix, showcasing skills valuable for any senior Elixir developer role.