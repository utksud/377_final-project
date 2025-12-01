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
    cout << "\n<<< Press Return to Continue>>>>\n";
    cin.get();
}

void displayHeader() {
    clearScreen();
    cout << "\nFMAS Version: 1.0\n";
    cout << "Term Project - Flight Management Application System\n";
    cout << "Produced by group#: Your Group Number\n";
    cout << "Names: Your Team Members Names\n";
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
    cout << source << " to " << destination;
}

// ==================== Passenger Class Implementation ====================
Passenger::Passenger(string fname, string lname, string phone, int r, char s, int passenger_id)
    : first_name(fname), last_name(lname), phone_number(phone), 
      row(r), seat(s), id(passenger_id) {}

string Passenger::getFirstName() const { 
    return first_name; 
}

string Passenger::getLastName() const { 
    return last_name; 
}

string Passenger::getPhoneNumber() const { 
    return phone_number; 
}

int Passenger::getRow() const {
    return row;
}

char Passenger::getSeat() const {
    return seat;
}

int Passenger::getId() const {
    return id;
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

void Passenger::setRow(int r) {
    row = r;
}

void Passenger::setSeat(char s) {
    seat = s;
}

void Passenger::setId(int passenger_id) {
    id = passenger_id;
}

void Passenger::display() const {
    cout << first_name << " " << last_name << " (Ph: " << phone_number 
         << ", Seat: " << row << seat << ", ID: " << id << ")";
}

void Passenger::displayInTable() const {
    cout << left << setw(15) << first_name 
         << setw(15) << last_name
         << setw(20) << phone_number
         << setw(8) << row
         << setw(8) << seat
         << setw(10) << id << endl;
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

vector<Passenger> Flight::getPassengers() const {
    return passengers;
}

void Flight::setRoute(const Route& r) {
    route = r;
}

void Flight::addPassenger(const Passenger& passenger) {
    // Check if seat is available
    if (!isSeatAvailable(passenger.getRow(), passenger.getSeat())) {
        cout << "Error: Seat " << passenger.getRow() << passenger.getSeat() 
             << " is already occupied!\n";
        return;
    }
    
    passengers.push_back(passenger);
    occupySeat(passenger.getRow(), passenger.getSeat());
    cout << "Passenger added successfully!\n";
}

void Flight::removePassengerById(int id) {
    for (size_t i = 0; i < passengers.size(); i++) {
        if (passengers[i].getId() == id) {
            cout << "Passenger " << passengers[i].getFirstName() << " " 
                 << passengers[i].getLastName() 
                 << " was successfully removed from flight " << flight_number << endl;
            
            freeSeat(passengers[i].getRow(), passengers[i].getSeat());
            passengers.erase(passengers.begin() + i);
            return;
        }
    }
    cout << "Passenger with ID " << id << " not found!\n";
}

void Flight::initializeSeats() {
    seats.clear();
    for (int row = 0; row <= number_of_rows; row++) {
        for (int seat = 0; seat < number_of_seats_per_row; seat++) {
            char seat_char = 'A' + seat;
            seats.push_back(Seat(row, seat_char));
        }
    }
}

bool Flight::isSeatAvailable(int row, char seat) const {
    for (const auto& s : seats) {
        if (s.getRowNumber() == row && s.getSeatCharacter() == seat) {
            return !s.isOccupied();
        }
    }
    return false;
}

void Flight::occupySeat(int row, char seat) {
    for (auto& s : seats) {
        if (s.getRowNumber() == row && s.getSeatCharacter() == seat) {
            s.setOccupied(true);
            return;
        }
    }
}

void Flight::freeSeat(int row, char seat) {
    for (auto& s : seats) {
        if (s.getRowNumber() == row && s.getSeatCharacter() == seat) {
            s.setOccupied(false);
            return;
        }
    }
}

void Flight::show_seat_map() const {
    clearScreen();
    cout << "\nAircraft Seat Map for flight " << flight_number << endl;
    cout << "     ";
    
    // Display column headers (A B C D E F)
    for (int i = 0; i < number_of_seats_per_row; i++) {
        cout << "  " << (char)('A' + i) << " ";
    }
    cout << "\n";
    
    // Display seats row by row with borders
    for (int row = 0; row <= number_of_rows; row++) {
        // Top border
        cout << "     ";
        for (int i = 0; i < number_of_seats_per_row; i++) {
            cout << "+---";
        }
        cout << "+\n";
        
        // Row number and seats
        cout << setw(4) << row << " ";
        for (int seat = 0; seat < number_of_seats_per_row; seat++) {
            char seat_char = 'A' + seat;
            bool occupied = false;
            
            // Check if seat is occupied
            for (const auto& s : seats) {
                if (s.getRowNumber() == row && s.getSeatCharacter() == seat_char && s.isOccupied()) {
                    occupied = true;
                    break;
                }
            }
            
            if (occupied) {
                cout << "| X ";
            } else {
                cout << "|   ";
            }
        }
        cout << "|\n";
    }
    
    // Bottom border
    cout << "     ";
    for (int i = 0; i < number_of_seats_per_row; i++) {
        cout << "+---";
    }
    cout << "+\n";
}

void Flight::displayPassengers() const {
    clearScreen();
    cout << "\nPassenger List (Flight:" << flight_number << " from ";
    route.display();
    cout << ")\n";
    
    if (passengers.empty()) {
        cout << "No passengers on this flight.\n";
    } else {
        cout << left << setw(15) << "First Name" 
             << setw(15) << "Last Name"
             << setw(20) << "Phone"
             << setw(8) << "Row"
             << setw(8) << "Seat"
             << setw(10) << "ID" << endl;
        cout << string(76, '-') << endl;
        
        for (const auto& p : passengers) {
            p.displayInTable();
            cout << string(76, '-') << endl;
        }
    }
}

void Flight::displayFlightInfo() const {
    cout << flight_number << " ";
    route.display();
    cout << " " << number_of_rows << " " << number_of_seats_per_row;
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
    cout << "\nHere is the list of available flights. Please select one:\n\n";
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

bool Airline::loadPassengersFromFile(const string& filename) {
    ifstream file(filename);
    if (!file.is_open()) {
        cout << "Error: Could not open file " << filename << "\n";
        return false;
    }
    
    string line;
    while (getline(file, line)) {
        stringstream ss(line);
        string flightNum, firstName, lastName, phone, seatStr;
        int id;
        
        ss >> flightNum >> firstName >> lastName >> phone >> seatStr >> id;
        
        // Parse seat (e.g., "6A" -> row=6, seat='A')
        int row = 0;
        char seat = 'A';
        if (!seatStr.empty()) {
            // Extract row number
            size_t i = 0;
            while (i < seatStr.length() && isdigit(seatStr[i])) {
                row = row * 10 + (seatStr[i] - '0');
                i++;
            }
            // Extract seat letter
            if (i < seatStr.length()) {
                seat = seatStr[i];
            }
        }
        
        Passenger p(firstName, lastName, phone, row, seat, id);
        
        // Find the flight and add passenger
        Flight* flight = getFlightByNumber(flightNum);
        if (flight != nullptr) {
            flight->addPassenger(p);
        }
    }
    
    file.close();
    return true;
}

bool Airline::savePassengersToFile(const string& filename) const {
    ofstream file(filename);
    if (!file.is_open()) {
        cout << "Error: Could not save to file " << filename << "\n";
        return false;
    }
    
    for (const auto& flight : flights) {
        vector<Passenger> passengers = flight.getPassengers();
        for (const auto& p : passengers) {
            file << flight.getFlightNumber() << " "
                 << p.getFirstName() << " "
                 << p.getLastName() << " "
                 << p.getPhoneNumber() << " "
                 << p.getRow() << p.getSeat() << " "
                 << p.getId() << "\n";
        }
    }
    
    file.close();
    cout << "All the data in the passenger list were saved.\n";
    return true;
}

// ==================== Menu Function Implementation ====================
int menu() {
    int choice = -1;
    clearScreen();
    cout << "\nPlease select one of the following options:\n\n";
    cout << "1. Select a flight\n";
    cout << "2. Display Flight Seat Map\n";
    cout << "3. Display Passengers Information\n";
    cout << "4. Add a New Passenger\n";
    cout << "5. Remove an Existing Passenger\n";
    cout << "6. Save data\n";
    cout << "7. Quit\n";
    cout << "\nEnter your choice: (1, 2, 3, 4, 5, 6, or 7) ";
    cin >> choice;
    cleanStandardInputStream();
    return choice;
}

// ==================== Select Flight Function ====================
void selectFlight(Airline& airline, Flight** selectedFlight) {
    airline.displayAllFlights();
    int flightChoice;
    cout << "\nEnter your choice: ";
    cin >> flightChoice;
    cleanStandardInputStream();
    
    // Get flight by index (choice - 1)
    string flightNum;
    // This is a simplified version - you'd need to get the actual flight number
    // For now, we'll ask for flight number directly
    cout << "Enter flight number (e.g., WJ1145): ";
    cin >> flightNum;
    cleanStandardInputStream();
    
    *selectedFlight = airline.getFlightByNumber(flightNum);
    if (*selectedFlight != nullptr) {
        cout << "You have selected flight " << flightNum << " from ";
        (*selectedFlight)->getRoute().display();
        cout << ".\n";
    } else {
        cout << "Flight not found!\n";
    }
    pressEnter();
}

// ==================== Add Passenger Function ====================
void add_passenger(Flight* flight) {
    if (flight == nullptr) {
        cout << "No flight selected!\n";
        pressEnter();
        return;
    }
    
    clearScreen();
    
    int id;
    string firstName, lastName, phone;
    int row;
    char seat;
    
    cout << "Please enter the passenger id: ";
    cin >> id;
    cleanStandardInputStream();
    
    cout << "Please enter the passenger first name: ";
    cin >> firstName;
    cleanStandardInputStream();
    
    cout << "Please enter the passenger last name: ";
    cin >> lastName;
    cleanStandardInputStream();
    
    cout << "Please enter the passenger phone number: ";
    cin >> phone;
    cleanStandardInputStream();
    
    cout << "Enter the passenger's desired row: ";
    cin >> row;
    cleanStandardInputStream();
    
    cout << "Enter the passenger's desired seat: ";
    cin >> seat;
    cleanStandardInputStream();
    
    Passenger p(firstName, lastName, phone, row, seat, id);
    flight->addPassenger(p);
}

// ==================== Remove Passenger Function ====================
void remove_passenger(Flight* flight) {
    if (flight == nullptr) {
        cout << "No flight selected!\n";
        pressEnter();
        return;
    }
    
    clearScreen();
    
    int id;
    cout << "Please enter the id of the passenger that needs to be removed: ";
    cin >> id;
    cleanStandardInputStream();
    
    flight->removePassengerById(id);
    pressEnter();
}

// ==================== Save Data Function ====================
void save_data(const Airline& airline) {
    clearScreen();
    char response;
    cout << "Do you want to save the data in the \"passengers.txt\"? Please answer <Y or N> ";
    cin >> response;
    cleanStandardInputStream();
    
    if (response == 'Y' || response == 'y') {
        airline.savePassengersToFile("passengers.txt");
    } else {
        cout << "Data not saved.\n";
    }
}

// ==================== Main Function ====================
int main() {
    displayHeader();
    
    Airline airline("Flight Management System");
    
    // Load flights from file
    cout << "Loading flight data from 'flights.txt'...\n";
    if (airline.loadFlightsFromFile("flights.txt")) {
        cout << "Flight data loaded successfully!\n";
    } else {
        cout << "Warning: Could not load flight data.\n";
    }
    
    // Load passengers from file
    cout << "Loading passenger data from 'passengers.txt'...\n";
    if (airline.loadPassengersFromFile("passengers.txt")) {
        cout << "Passenger data loaded successfully!\n";
    } else {
        cout << "Warning: Could not load passenger data.\n";
    }
    
    pressEnter();
    
    Flight* selectedFlight = nullptr;
    int choice;
    
    while ((choice = menu()) != 7) {
        switch (choice) {
            case 1:  // Select a flight
                selectFlight(airline, &selectedFlight);
                break;
                
            case 2:  // Display seat map
                if (selectedFlight != nullptr) {
                    selectedFlight->show_seat_map();
                } else {
                    cout << "No flight selected!\n";
                }
                pressEnter();
                break;
                
            case 3:  // Display passengers
                if (selectedFlight != nullptr) {
                    selectedFlight->displayPassengers();
                } else {
                    cout << "No flight selected!\n";
                }
                pressEnter();
                break;
                
            case 4:  // Add passenger
                add_passenger(selectedFlight);
                break;
                
            case 5:  // Remove passenger
                remove_passenger(selectedFlight);
                break;
                
            case 6:  // Save data
                save_data(airline);
                pressEnter();
                break;
                
            default:
                cout << "Invalid choice! Please try again.\n";
                pressEnter();
                break;
        }
    }
    
    clearScreen();
    cout << "\nProgram terminated.\n";
    
    return 0;
}
