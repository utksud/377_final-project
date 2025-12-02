// ==================== passenger.h ====================
#ifndef PASSENGER_H
#define PASSENGER_H

#include <string>
using namespace std;

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

#endif // PASSENGER_H
