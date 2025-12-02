// ==================== function.h ====================
#ifndef UTILS_H
#define UTILS_H

#include "airline.h"
#include "flight.h"

// Utility Functions
void cleanStandardInputStream(void);
void clearScreen(void);
void pressEnter();
void displayHeader();

// Menu and Helper Functions
int menu();
void selectFlight(Airline& airline, Flight** selectedFlight);
void add_passenger(Flight* flight);
void remove_passenger(Flight* flight);
void save_data(const Airline& airline);

#endif // UTILS_H