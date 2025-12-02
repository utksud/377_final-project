// ==================== seat.h ====================
#ifndef SEAT_H
#define SEAT_H

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

#endif // SEAT_H