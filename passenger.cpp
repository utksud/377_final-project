// ==================== passenger.cpp ====================
#include "passenger.h"
#include <iostream>
#include <iomanip>
using namespace std;

Passenger::Passenger(string fname, string lname, string phone, int r, char s, int passenger_id)
    : first_name(fname), last_name(lname), phone_number(phone), 
      row(r), seat(s), id(passenger_id) {}

string Passenger::getFirstName() const { 
    return first_name; 
}

string Passenger::getLastName() const { 
    return last_name; 
}

string Passenger::getPhoneNumber() const { 
    return phone_number; 
}

int Passenger::getRow() const {
    return row;
}

char Passenger::getSeat() const {
    return seat;
}

int Passenger::getId() const {
    return id;
}

void Passenger::setFirstName(const string& fname) { 
    first_name = fname; 
}

void Passenger::setLastName(const string& lname) { 
    last_name = lname; 
}

void Passenger::setPhoneNumber(const string& phone) { 
    phone_number = phone; 
}

void Passenger::setRow(int r) {
    row = r;
}

void Passenger::setSeat(char s) {
    seat = s;
}

void Passenger::setId(int passenger_id) {
    id = passenger_id;
}

void Passenger::display() const {
    cout << first_name << " " << last_name << " (Ph: " << phone_number 
         << ", Seat: " << row << seat << ", ID: " << id << ")";
}

void Passenger::displayInTable() const {
    cout << left << setw(15) << first_name 
         << setw(15) << last_name
         << setw(20) << phone_number
         << setw(8) << row
         << setw(8) << seat
         << setw(10) << id << endl;
}
