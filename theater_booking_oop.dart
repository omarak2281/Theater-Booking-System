import 'dart:io';

// Class representing a single seat in the theater
class Seat {
  String status; // 'E' for Empty, 'B' for Booked

  Seat() : status = 'E'; // Initialize as empty by default
}

// Class representing the theater
class Theater {
  final int rows;
  final int columns;
  late List<List<Seat>> seats;

  Theater(this.rows, this.columns) {
    // Initialize the theater grid with empty seats
    seats = List.generate(rows, (_) => List.filled(columns, Seat()));
  }

  // Display the current layout of the theater
  void displayLayout() {
    print("\n--- Theater Layout ---");
    print("E = Empty, B = Booked");
    for (var row in seats) {
      print(row.map((seat) => seat.status).join(' '));
    }
  }

  // Check if a seat is available
  bool isSeatAvailable(int row, int col) {
    return seats[row][col].status == 'E';
  }

  // Book a seat
  void bookSeat(int row, int col) {
    seats[row][col].status = 'B';
  }
}

// Class representing a booking
class Booking {
  String name;
  String phone;

  Booking(this.name, this.phone);
}

// Class managing the booking system
class BookingSystem {
  final Theater theater;
  Map<String, Booking> bookings = {};

  BookingSystem(this.theater);

  // Display all current bookings
  void showBookings() {
    print("\n--- Current Bookings ---");
    if (bookings.isEmpty) {
      print("No seats booked yet.");
    } else {
      bookings.forEach((seat, booking) {
        print("Seat $seat: ${booking.name} (${booking.phone})");
      });
    }
  }

  // Book a seat
  void bookASeat() {
    print("\n--- Book a Seat ---");
    print("Enter 0 to return to main menu");

    // Get row input
    stdout.write("Enter row (1-${theater.rows}): ");
    String? rowInput = stdin.readLineSync();
    if (rowInput == '0') return;
    int row = int.tryParse(rowInput ?? '') ?? -1;
    if (row < 1 || row > theater.rows) {
      print("Invalid row. Must be between 1 and ${theater.rows}.");
      return;
    }

    // Get column input
    stdout.write("Enter column (1-${theater.columns}): ");
    String? colInput = stdin.readLineSync();
    if (colInput == '0') return;
    int col = int.tryParse(colInput ?? '') ?? -1;
    if (col < 1 || col > theater.columns) {
      print("Invalid column. Must be between 1 and ${theater.columns}.");
      return;
    }

    // Convert to zero-based index
    int rowIndex = row - 1;
    int colIndex = col - 1;

    // Check if the seat is already booked
    if (!theater.isSeatAvailable(rowIndex, colIndex)) {
      print("Seat is already booked. Choose another seat.");
      return;
    }

    // Collect customer details
    stdout.write("Your name (or 0 to cancel): ");
    String? name = stdin.readLineSync();
    if (name == '0') return;

    stdout.write("Your phone number (or 0 to cancel): ");
    String? phone = stdin.readLineSync();
    if (phone == '0') return;

    if (name == null || phone == null || name.isEmpty || phone.isEmpty) {
      print("Name and phone number are required.");
      return;
    }

    // Book the seat
    theater.bookSeat(rowIndex, colIndex);
    String seatPosition = "$row,$col";
    bookings[seatPosition] = Booking(name, phone);
    print("Seat booked successfully!");
  }
}

// Main class to run the program
void main() {
  // Create a 5x5 theater
  Theater theater = Theater(5, 5);
  BookingSystem bookingSystem = BookingSystem(theater);

  print("Welcome to Theater Booking System");

  // Main program loop
  while (true) {
    print("\nMenu:");
    print("1 - Book a seat");
    print("2 - View theater layout");
    print("3 - Show bookings");
    print("4 - Exit");

    stdout.write("Choose option (1-4): ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        bookingSystem.bookASeat();
        break;

      case '2':
        theater.displayLayout();
        break;

      case '3':
        bookingSystem.showBookings();
        break;

      case '4':
        print("Thank you for using Theater Booking System");
        return;

      default:
        print("Invalid option. Please choose 1-4.");
    }
  }
}