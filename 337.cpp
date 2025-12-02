// ==================== main.cpp ====================
#include "functions.h"
#include <iostream>
using namespace std;

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