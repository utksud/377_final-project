// ==================== airline.h ====================
#ifndef AIRLINE_H
#define AIRLINE_H

#include <string>
#include <vector>
#include "flight.h"
using namespace std;

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

#endif // AIRLINE_H