// ==================== flight.h ====================
#ifndef FLIGHT_H
#define FLIGHT_H

#include <string>
#include <vector>
#include "Seat.h"
#include "Route.h"
#include "Passenger.h"
using namespace std;

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

#endif // FLIGHT_H