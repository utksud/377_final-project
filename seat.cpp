// ==================== seat.cpp ====================
#include "seat.h"
#include <iostream>
using namespace std;

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
