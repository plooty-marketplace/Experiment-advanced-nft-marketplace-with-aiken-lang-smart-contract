contract SimpleMarketplace {
    record Item {
        address owner;
        string name;
        uint price;
    }

    map(uint => Item) public items;

    function addItem(uint id, string name, uint price) public {
        require(price > 0, "Price must be positive");
        items[id] = Item(msg.sender, name, price);
        emit ItemAdded(id, name, price);
    }

    function buyItem(uint id) public payable {
        require(items[id].price > 0, "Item does not exist");
        require(msg.value >= items[id].price, "Insufficient funds");

        // Transfer ownership
        items[id].owner.transfer(msg.value);
        items[id].owner = msg.sender;
        emit ItemPurchased(id, msg.sender);
    }
}




// Descriptions








     1. Data Types:
Aiken supports various data types, including basic types like integers, booleans, and strings, as well as more complex structures such as records and lists.
You can define custom data types to suit the needs of your contract.
    2. Collections:
The library provides functionalities for working with collections, such as lists and maps. This allows developers to store and manipulate groups of data easily.
    3. Mathematical Functions:
Aiken includes standard mathematical functions for operations like addition, subtraction, multiplication, and division, which are essential for calculating prices, royalties, and other numerical values.
    4. String Manipulation:
Functions for manipulating strings, such as concatenation, substring extraction, and length checking, are available for handling metadata and user inputs.
    5. Time and Date Functions:
Aiken provides functions to work with timestamps and durations, which are useful for implementing time-based features like auctions and expiration dates.
    6. Event Emission:
The library includes utilities for emitting events, which are crucial for logging important actions and changes in the contract state. This allows external applications and users to listen for and react to specific events.
    7. Error Handling:
Aiken provides mechanisms for error handling, allowing developers to specify conditions under which errors should be raised, along with custom error messages.
    8. Integration with Blockchain:
The standard library includes functionalities to interact with the blockchain, such as reading and writing to the blockchain state, managing transaction fees, and handling user addresses.

