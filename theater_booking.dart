import 'dart:io';

void main() {
  // Create a 5x5 grid to represent theater seats
  // Each seat starts as 'E' (Empty)
  List<List<String>> theaterSeats = List.generate(5, (_) => List.filled(5, 'E'));
  
  // Dictionary to store booking information
  // Key: Seat position, Value: Customer details
  Map<String, Map<String, String>> bookings = {};

  // Display welcome message
  print("Welcome to Theater Booking System");

  // Main program loop - continues until user chooses to exit
  while (true) {
    // Display menu options to the user
    print("\nMenu:");
    print("1 - Book a seat");
    print("2 - View theater layout");
    print("3 - Show bookings");
    print("4 - Exit");

    // Prompt user for menu choice
    stdout.write("Choose option (1-4): ");
    String? choice = stdin.readLineSync();

    // Process user's menu selection
    switch (choice) {
      case '1':
        // Seat booking process starts here
        print("\n--- Book a Seat ---");
        print("Enter 0 to return to main menu");
        
        // Get row selection from user
        stdout.write("Enter row (1-5): ");
        String? rowInput = stdin.readLineSync();
        
        // Allow user to cancel and return to main menu
        if (rowInput == '0') continue;
        
        // Convert row input to integer
        int row = int.tryParse(rowInput ?? '') ?? -1;
        
        // Validate row input
        if (row < 1 || row > 5) {
          print("Invalid row. Must be between 1 and 5.");
          continue;
        }

        // Get column selection from user
        stdout.write("Enter column (1-5): ");
        String? colInput = stdin.readLineSync();
        
        // Allow user to cancel and return to main menu
        if (colInput == '0') continue;
        
        // Convert column input to integer
        int col = int.tryParse(colInput ?? '') ?? -1;
        
        // Validate column input
        if (col < 1 || col > 5) {
          print("Invalid column. Must be between 1 and 5.");
          continue;
        }

        // Convert to zero-based index for array access
        int rowIndex = row - 1;
        int colIndex = col - 1;

        // Check if selected seat is already booked
        if (theaterSeats[rowIndex][colIndex] == 'B') {
          print("Seat is already booked. Choose another seat.");
          continue;
        }

        // Collect customer name
        stdout.write("Your name (or 0 to cancel): ");
        String? name = stdin.readLineSync();
        
        // Allow user to cancel and return to main menu
        if (name == '0') continue;

        // Collect customer phone number
        stdout.write("Your phone number (or 0 to cancel): ");
        String? phone = stdin.readLineSync();
        
        // Allow user to cancel and return to main menu
        if (phone == '0') continue;

        // Validate that name and phone are not empty
        if (name == null || phone == null || name.isEmpty || phone.isEmpty) {
          print("Name and phone number are required.");
          continue;
        }

        // Mark seat as booked in the seating layout
        theaterSeats[rowIndex][colIndex] = 'B';
        
        // Store booking information
        String seatPosition = "$row,$col";
        bookings[seatPosition] = {'name': name, 'phone': phone};

        // Confirm booking to user
        print("Seat booked successfully!");
        break;

      case '2':
        // Display current theater layout
        print("\n--- Theater Layout ---");
        print("E = Empty, B = Booked");
        for (var row in theaterSeats) {
          print(row.join(' '));
        }
        break;

      case '3':
        // Show all current bookings
        print("\n--- Current Bookings ---");
        if (bookings.isEmpty) {
          print("No seats booked yet.");
        } else {
          bookings.forEach((seat, details) {
            print("Seat $seat: ${details['name']} (${details['phone']})");
          });
        }
        break;

      case '4':
        // Exit the program
        print("Thank you for using Theater Booking System");
        return;

      default:
        // Handle invalid menu selection
        print("Invalid option. Please choose 1-4.");
    }
  }
}