// ==================== route.cpp ====================
#include "route.h"
#include <iostream>
using namespace std;

Route::Route(string src, string dest) 
    : source(src), destination(dest) {}

string Route::getSource() const { 
    return source; 
}

string Route::getDestination() const { 
    return destination; 
}

void Route::setSource(const string& src) { 
    source = src; 
}

void Route::setDestination(const string& dest) { 
    destination = dest; 
}

void Route::display() const {
    cout << source << " to " << destination;
}