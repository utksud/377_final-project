#include <iostream>
#include <string>
#include <vector>
using namespace std;

// Forward declarations
class Flight;
class Seat;

// Seat class
class Seat {
private:
    int row_number;
    char seat_character;

public:
    Seat(int row = 0, char character = 'A') 
        : row_number(row), seat_character(character) {}
    
    int getRowNumber() const { return row_number; }
    char getSeatCharacter() const { return seat_character; }
    
    void setRowNumber(int row) { row_number = row; }
    void setSeatCharacter(char character) { seat_character = character; }
    
    void display() const {
        cout << row_number << seat_character;
    }
};

// Route class
class Route {
private:
    string source;
    string destination;

public:
    Route(string src = "", string dest = "") 
        : source(src), destination(dest) {}
    
    string getSource() const { return source; }
    string getDestination() const { return destination; }
    
    void setSource(const string& src) { source = src; }
    void setDestination(const string& dest) { destination = dest; }
    
    void display() const {
        cout << source << " -> " << destination;
    }
};

// Passenger class
class Passenger {
private:
    string first_name;
    string last_name;
    string phone_number;

public:
    Passenger(string fname = "", string lname = "", string phone = "")
        : first_name(fname), last_name(lname), phone_number(phone) {}
    
    string getFirstName() const { return first_name; }
    string getLastName() const { return last_name; }
    string getPhoneNumber() const { return phone_number; }
    
    void setFirstName(const string& fname) { first_name = fname; }
    void setLastName(const string& lname) { last_name = lname; }
    void setPhoneNumber(const string& phone) { phone_number = phone; }
    
    void display() const {
        cout << first_name << " " << last_name << " (Ph: " << phone_number << ")";
    }
};

// Flight class
class Flight {
private:
    vector<Seat> seats;
    vector<Passenger> passengers;
    int number_of_rows;
    int number_of_seats_per_row;
    Route route;

public:
    Flight(int rows = 0, int seats_per_row = 0)
        : number_of_rows(rows), number_of_seats_per_row(seats_per_row) {}
    
    void addPassenger(const Passenger& passenger) {
        passengers.push_back(passenger);
    }
    
    void setRoute(const Route& r) {
        route = r;
    }
    
    Route getRoute() const {
        return route;
    }
    
    void initializeSeats() {
        seats.clear();
        for (int row = 1; row <= number_of_rows; row++) {
            for (int seat = 0; seat < number_of_seats_per_row; seat++) {
                char seat_char = 'A' + seat;
                seats.push_back(Seat(row, seat_char));
            }
        }
    }
    
    void displaySeats() const {
        cout << "Available Seats:\n";
        for (const auto& seat : seats) {
            seat.display();
            cout << " ";
        }
        cout << endl;
    }
    
    void displayPassengers() const {
        cout << "Passengers on this flight:\n";
        for (const auto& passenger : passengers) {
            passenger.display();
            cout << endl;
        }
    }
    
    void displayFlightInfo() const {
        cout << "\n=== Flight Information ===\n";
        cout << "Route: ";
        route.display();
        cout << "\nRows: " << number_of_rows 
             << ", Seats per row: " << number_of_seats_per_row << endl;
        displaySeats();
        displayPassengers();
    }
};

// Airline class
class Airline {
private:
    vector<Flight> flights;
    string name;

public:
    Airline(string airline_name = "") : name(airline_name) {}
    
    void addFlight(const Flight& flight) {
        flights.push_back(flight);
    }
    
    void setName(const string& airline_name) {
        name = airline_name;
    }
    
    string getName() const {
        return name;
    }
    
    void displayAllFlights();
};

// Main function demonstrating usage
int main() {
    // Create an airline
    Airline airline("Sky Airways");
    
    // Create a flight
    Flight flight1(10, 6);  // 10 rows, 6 seats per row
    flight1.initializeSeats();
    
    // Set route for the flight
    Route route1("New York", "Los Angeles");
    flight1.setRoute(route1);
    
    // Create and add passengers
    Passenger p1("John", "Doe", "555-1234");
    Passenger p2("Jane", "Smith", "555-5678");
    Passenger p3("Bob", "Johnson", "555-9012");
    
    flight1.addPassenger(p1);
    flight1.addPassenger(p2);
    flight1.addPassenger(p3);
    
    // Add flight to airline
    airline.addFlight(flight1);
    
    // Create another flight
    Flight flight2(8, 4);  // 8 rows, 4 seats per row
    flight2.initializeSeats();
    
    Route route2("Chicago", "Miami");
    flight2.setRoute(route2);
    
    Passenger p4("Alice", "Williams", "555-3456");
    flight2.addPassenger(p4);
    
    airline.addFlight(flight2);
    
    // Display all flights
    airline.displayAllFlights();
    
    return 0;
}
