// ==================== flight.cpp ====================
#include "flight.h"
#include <iostream>
#include <iomanip>
using namespace std;

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
    void clearScreen(); // Forward declaration
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
    void clearScreen(); // Forward declaration
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