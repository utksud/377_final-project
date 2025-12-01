// ==================== FlightSystem.h ====================
#ifndef FLIGHTSYSTEM_H
#define FLIGHTSYSTEM_H

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <iomanip>
using namespace std;

// Forward declarations
class Flight;

// ==================== Utility Functions ====================
void cleanStandardInputStream(void);
void clearScreen(void);
void pressEnter();
void displayHeader();

// ==================== Seat Class ====================
class Seat {
private:
    int row_number;
    char seat_character;
    bool is_occupied;

public:
    Seat(int row = 0, char character = 'A');
    
    int getRowNumber() const;
    char getSeatCharacter() const;
    bool isOccupied() const;
    
    void setOccupied(bool occupied);
    void display() const;
};

// ==================== Route Class ====================
class Route {
private:
    string source;
    string destination;

public:
    Route(string src = "", string dest = "");
    
    string getSource() const;
    string getDestination() const;
    
    void setSource(const string& src);
    void setDestination(const string& dest);
    
    void display() const;
};

// ==================== Passenger Class ====================
class Passenger {
private:
    string first_name;
    string last_name;
    string phone_number;
    int row;
    char seat;
    int id;

public:
    Passenger(string fname = "", string lname = "", string phone = "", 
              int r = 0, char s = 'A', int passenger_id = 0);
    
    string getFirstName() const;
    string getLastName() const;
    string getPhoneNumber() const;
    int getRow() const;
    char getSeat() const;
    int getId() const;
    
    void setFirstName(const string& fname);
    void setLastName(const string& lname);
    void setPhoneNumber(const string& phone);
    void setRow(int r);
    void setSeat(char s);
    void setId(int passenger_id);
    
    void display() const;
    void displayInTable() const;
};

// ==================== Flight Class ====================
class Flight {
private:
    vector<Seat> seats;
    vector<Passenger> passengers;
    int number_of_rows;
    int number_of_seats_per_row;
    Route route;
    string flight_number;

public:
    Flight(string flight_num = "", int rows = 0, int seats_per_row = 0);
    
    string getFlightNumber() const;
    int getNumberOfRows() const;
    int getNumberOfSeatsPerRow() const;
    Route getRoute() const;
    vector<Passenger> getPassengers() const;
    
    void setRoute(const Route& r);
    void addPassenger(const Passenger& passenger);
    void removePassengerById(int id);
    void initializeSeats();
    bool isSeatAvailable(int row, char seat) const;
    void occupySeat(int row, char seat);
    void freeSeat(int row, char seat);
    void show_seat_map() const;
    void displayPassengers() const;
    void displayFlightInfo() const;
};

// ==================== Airline Class ====================
class Airline {
private:
    vector<Flight> flights;
    string name;

public:
    Airline(string airline_name = "");
    
    void addFlight(const Flight& flight);
    void setName(const string& airline_name);
    string getName() const;
    
    Flight* getFlightByNumber(const string& flightNum);
    Flight* getFlightByIndex(int index);
    void displayAllFlights() const;
    bool loadFlightsFromFile(const string& filename);
    bool loadPassengersFromFile(const string& filename);
    bool savePassengersToFile(const string& filename) const;
};

// ==================== Menu and Helper Functions ====================
int menu();
void selectFlight(Airline& airline, Flight** selectedFlight);
void add_passenger(Flight* flight);
void remove_passenger(Flight* flight);
void save_data(const Airline& airline);

#endif // FLIGHTSYSTEM_H

