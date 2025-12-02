
// ==================== route.h ====================
#ifndef ROUTE_H
#define ROUTE_H

#include <string>
using namespace std;

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

#endif // ROUTE_H