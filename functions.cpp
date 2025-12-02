// ==================== functions.cpp ====================
#include "functions.h"
#include <iostream>
using namespace std;

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

void selectFlight(Airline& airline, Flight** selectedFlight) {
    airline.displayAllFlights();
    int flightChoice;
    cout << "\nEnter your choice: ";
    cin >> flightChoice;
    cleanStandardInputStream();
    
    *selectedFlight = airline.getFlightByIndex(flightChoice - 1);
    if (*selectedFlight != nullptr) {
        cout << "You have selected flight " << (*selectedFlight)->getFlightNumber() << " from ";
        (*selectedFlight)->getRoute().display();
        cout << ".\n";
    } else {
        cout << "Invalid flight selection!\n";
    }
    pressEnter();
}

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