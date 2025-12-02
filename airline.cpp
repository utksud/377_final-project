// ==================== airline.cpp ====================
#include "airline.h"
#include <iostream>
#include <fstream>
#include <sstream>
using namespace std;

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

Flight* Airline::getFlightByIndex(int index) {
    if (index >= 0 && index < (int)flights.size()) {
        return &flights[index];
    }
    return nullptr;
}

void Airline::displayAllFlights() const {
    void clearScreen(); // Forward declaration
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
