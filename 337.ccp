// ==================== FlightSystem.cpp ====================
#include "classes.h"

// ==================== Utility Functions Implementation ====================
void cleanStandardInputStream(void) {
    int leftover;
    do {
        leftover = cin.get();
    } while (leftover != '\n' && leftover != EOF);
}

void clearScreen(void) {
    #ifdef UNIX
    system("clear");
    #else
    system("cls");
    #endif
}

void pressEnter() {
    cout << "\n<<< Press Enter to Continue >>>>\n";
    cin.get();
}

void displayHeader() {
    clearScreen();
    cout << "\n Flight Management Application - Fall 2024\n";
    cout << "\nVersion: 1.0 ";
    cout << "\nTerm Project";
    cout << "\nProduced by: Your Name\n\n";
    pressEnter();
}

// ==================== Seat Class Implementation ====================
Seat::Seat(int row, char character) 
    : row_number(row), seat_character(character), is_occupied(false) {}

int Seat::getRowNumber() const { 
    return row_number; 
}

char Seat::getSeatCharacter() const { 
    return seat_character; 
}

bool Seat::isOccupied() const { 
    return is_occupied; 
}

void Seat::setOccupied(bool occupied) { 
    is_occupied = occupied; 
}

void Seat::display() const {
    cout << row_number << seat_character;
}

// ==================== Route Class Implementation ====================
Route::Route(string src, string dest) 
    : source(src), destination(dest) {}

string Route::getSource() const { 
    return source; 
}

string Route::getDestination() const { 
    return destination; 
}

void Route::setSource(const string& src) { 
    source = src; 
}

void Route::setDestination(const string& dest) { 
    destination = dest; 
}

void Route::display() const {
    cout << source << " -> " << destination;
}

// ==================== Passenger Class Implementation ====================
Passenger::Passenger(string fname, string lname, string phone)
    : first_name(fname), last_name(lname), phone_number(phone) {}

string Passenger::getFirstName() const { 
    return first_name; 
}

string Passenger::getLastName() const { 
    return last_name; 
}

string Passenger::getPhoneNumber() const { 
    return phone_number; 
}

void Passenger::setFirstName(const string& fname) { 
    first_name = fname; 
}

void Passenger::setLastName(const string& lname) { 
    last_name = lname; 
}

void Passenger::setPhoneNumber(const string& phone) { 
    phone_number = phone; 
}

void Passenger::display() const {
    cout << first_name << " " << last_name << " (Ph: " << phone_number << ")";
}

// ==================== Flight Class Implementation ====================
Flight::Flight(string flight_num, int rows, int seats_per_row)
    : flight_number(flight_num), number_of_rows(rows), 
      number_of_seats_per_row(seats_per_row) {}

string Flight::getFlightNumber() const { 
    return flight_number; 
}

int Flight::getNumberOfRows() const { 
    return number_of_rows; 
}

int Flight::getNumberOfSeatsPerRow() const { 
    return number_of_seats_per_row; 
}

Route Flight::getRoute() const {
    return route;
}

void Flight::setRoute(const Route& r) {
    route = r;
}

void Flight::addPassenger(const Passenger& passenger) {
    if (passengers.size() < seats.size()) {
        passengers.push_back(passenger);
        // Mark a seat as occupied
        for (auto& seat : seats) {
            if (!seat.isOccupied()) {
                seat.setOccupied(true);
                break;
            }
        }
    } else {
        cout << "Flight is full! Cannot add more passengers.\n";
    }
}

void Flight::removePassenger(const string& firstName, const string& lastName) {
    for (size_t i = 0; i < passengers.size(); i++) {
        if (passengers[i].getFirstName() == firstName && 
            passengers[i].getLastName() == lastName) {
            passengers.erase(passengers.begin() + i);
            // Free up a seat
            for (auto& seat : seats) {
                if (seat.isOccupied()) {
                    seat.setOccupied(false);
                    break;
                }
            }
            cout << "Passenger removed successfully!\n";
            return;
        }
    }
    cout << "Passenger not found!\n";
}

void Flight::initializeSeats() {
    seats.clear();
    for (int row = 1; row <= number_of_rows; row++) {
        for (int seat = 0; seat < number_of_seats_per_row; seat++) {
            char seat_char = 'A' + seat;
            seats.push_back(Seat(row, seat_char));
        }
    }
}

void Flight::show_seat_map() const {
    clearScreen();
    cout << "\n=== Seat Map for Flight " << flight_number << " ===\n";
    cout << "Route: ";
    route.display();
    cout << "\n\n";
    
    // Display column headers
    cout << "    ";
    for (int i = 0; i < number_of_seats_per_row; i++) {
        cout << "  " << (char)('A' + i) << " ";
    }
    cout << "\n";
    
    // Display seats row by row
    int index = 0;
    for (int row = 1; row <= number_of_rows; row++) {
        cout << (row < 10 ? " " : "") << row << "  ";
        for (int seat = 0; seat < number_of_seats_per_row; seat++) {
            if (seats[index].isOccupied()) {
                cout << " [X]";  // Occupied
            } else {
                cout << " [ ]";  // Available
            }
            index++;
        }
        cout << "\n";
    }
    cout << "\n[X] = Occupied    [ ] = Available\n";
}

void Flight::displayPassengers() const {
    clearScreen();
    cout << "\n=== Passengers on Flight " << flight_number << " ===\n";
    cout << "Route: ";
    route.display();
    cout << "\n\n";
    
    if (passengers.empty()) {
        cout << "No passengers on this flight.\n";
    } else {
        for (size_t i = 0; i < passengers.size(); i++) {
            cout << (i + 1) << ". ";
            passengers[i].display();
            cout << "\n";
        }
    }
    cout << "\nTotal Passengers: " << passengers.size() << "\n";
}

void Flight::displayFlightInfo() const {
    cout << "Flight: " << flight_number << " | ";
    route.display();
    cout << " | Rows: " << number_of_rows 
         << " | Seats/Row: " << number_of_seats_per_row;
}

// ==================== Airline Class Implementation ====================
Airline::Airline(string airline_name) : name(airline_name) {}

void Airline::addFlight(const Flight& flight) {
    flights.push_back(flight);
}

void Airline::setName(const string& airline_name) {
    name = airline_name;
}

string Airline::getName() const {
    return name;
}

Flight* Airline::getFlightByNumber(const string& flightNum) {
    for (size_t i = 0; i < flights.size(); i++) {
        if (flights[i].getFlightNumber() == flightNum) {
            return &flights[i];
        }
    }
    return nullptr;
}

void Airline::displayAllFlights() const {
    clearScreen();
    cout << "\n=== " << name << " - All Flights ===\n\n";
    if (flights.empty()) {
        cout << "No flights available.\n";
    } else {
        for (size_t i = 0; i < flights.size(); i++) {
            cout << (i + 1) << ". ";
            flights[i].displayFlightInfo();
            cout << "\n";
        }
    }
}

bool Airline::loadFlightsFromFile(const string& filename) {
    ifstream file(filename);
    if (!file.is_open()) {
        cout << "Error: Could not open file " << filename << "\n";
        return false;
    }
    
    string line;
    while (getline(file, line)) {
        stringstream ss(line);
        string flightNum, source, dest;
        int rows, seatsPerRow;
        
        ss >> flightNum >> source >> dest >> rows >> seatsPerRow;
        
        Flight flight(flightNum, rows, seatsPerRow);
        Route route(source, dest);
        flight.setRoute(route);
        flight.initializeSeats();
        
        addFlight(flight);
    }
    
    file.close();
    return true;
}

bool Airline::saveFlightsToFile(const string& filename) const {
    ofstream file(filename);
    if (!file.is_open()) {
        cout << "Error: Could not save to file " << filename << "\n";
        return false;
    }
    
    for (const auto& flight : flights) {
        file << flight.getFlightNumber() << " "
             << flight.getRoute().getSource() << " "
             << flight.getRoute().getDestination() << " "
             << flight.getNumberOfRows() << " "
             << flight.getNumberOfSeatsPerRow() << "\n";
    }
    
    file.close();
    cout << "Flight data saved successfully!\n";
    return true;
}

// ==================== Menu Function Implementation ====================
int menu() {
    int choice = -1;
    clearScreen();
    cout << "\n=== Flight Management System ===\n\n";
    cout << "Please select one of the following options:\n\n";
    cout << "1. Display All Flights\n";
    cout << "2. Select a Flight\n";
    cout << "3. Display Flight Seat Map\n";
    cout << "4. Display Passengers Information\n";
    cout << "5. Add a New Passenger\n";
    cout << "6. Remove an Existing Passenger\n";
    cout << "7. Save Data\n";
    cout << "8. Quit\n";
    cout << "\nEnter your choice (1-8): ";
    cin >> choice;
    cleanStandardInputStream();
    return choice;
}

// ==================== Add Passenger Function ====================
void add_passenger(Flight* flight) {
    if (flight == nullptr) {
        cout << "No flight selected!\n";
        pressEnter();
        return;
    }
    
    clearScreen();
    cout << "\n=== Add New Passenger ===\n\n";
    
    string firstName, lastName, phone;
    cout << "Enter first name: ";
    cin >> firstName;
    cleanStandardInputStream();
    
    cout << "Enter last name: ";
    cin >> lastName;
    cleanStandardInputStream();
    
    cout << "Enter phone number: ";
    cin >> phone;
    cleanStandardInputStream();
    
    Passenger p(firstName, lastName, phone);
    flight->addPassenger(p);
    
    cout << "\nPassenger added successfully!\n";
    pressEnter();
}

// ==================== Remove Passenger Function ====================
void remove_passenger(Flight* flight) {
    if (flight == nullptr) {
        cout << "No flight selected!\n";
        pressEnter();
        return;
    }
    
    clearScreen();
    flight->displayPassengers();
    
    string firstName, lastName;
    cout << "\nEnter first name of passenger to remove: ";
    cin >> firstName;
    cleanStandardInputStream();
    
    cout << "Enter last name of passenger to remove: ";
    cin >> lastName;
    cleanStandardInputStream();
    
    flight->removePassenger(firstName, lastName);
    pressEnter();
}

// ==================== Main Function ====================
int main() {
    displayHeader();
    
    Airline airline("Sky Airways");
    
    // Load flights from file
    cout << "Loading flight data from 'flights.txt'...\n";
    if (airline.loadFlightsFromFile("flights.txt")) {
        cout << "Flight data loaded successfully!\n";
    } else {
        cout << "Warning: Could not load flight data. Starting with empty airline.\n";
    }
    pressEnter();
    
    Flight* selectedFlight = nullptr;
    int choice;
    
    while ((choice = menu()) != 8) {
        switch (choice) {
            case 1:  // Display all flights
                airline.displayAllFlights();
                pressEnter();
                break;
                
            case 2:  // Select a flight
                {
                    airline.displayAllFlights();
                    string flightNum;
                    cout << "\nEnter flight number to select: ";
                    cin >> flightNum;
                    cleanStandardInputStream();
                    
                    selectedFlight = airline.getFlightByNumber(flightNum);
                    if (selectedFlight != nullptr) {
                        cout << "Flight " << flightNum << " selected!\n";
                    } else {
                        cout << "Flight not found!\n";
                    }
                    pressEnter();
                }
                break;
                
            case 3:  // Display seat map
                if (selectedFlight != nullptr) {
                    selectedFlight->show_seat_map();
                } else {
                    cout << "No flight selected!\n";
                }
                pressEnter();
                break;
                
            case 4:  // Display passengers
                if (selectedFlight != nullptr) {
                    selectedFlight->displayPassengers();
                } else {
                    cout << "No flight selected!\n";
                }
                pressEnter();
                break;
                
            case 5:  // Add passenger
                add_passenger(selectedFlight);
                break;
                
            case 6:  // Remove passenger
                remove_passenger(selectedFlight);
                break;
                
            case 7:  // Save data
                clearScreen();
                airline.saveFlightsToFile("flights.txt");
                pressEnter();
                break;
                
            default:
                cout << "Invalid choice! Please try again.\n";
                pressEnter();
                break;
        }
    }
    
    clearScreen();
    cout << "\nThank you for using Flight Management System!\n";
    cout << "Goodbye!\n\n";
    
    return 0;
}
