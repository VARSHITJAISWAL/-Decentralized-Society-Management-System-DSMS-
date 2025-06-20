// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Decentralized Society Management System (DSMS)
/// @notice Smart contract to manage society maintenance, milk supply, and water supply tracking

contract DSMS {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    // -------- Society Maintenance --------
    struct Maintenance {
        uint256 amount;
        bool paid;
    }

    mapping(address => Maintenance) public maintenanceRecords;

    event MaintenancePaid(address indexed user, uint256 amount);

    function payMaintenance() external payable {
        require(msg.value > 0, "Amount must be greater than 0");
        maintenanceRecords[msg.sender] = Maintenance(msg.value, true);
        emit MaintenancePaid(msg.sender, msg.value);
    }

    // -------- Milk Supply --------
    struct MilkRecord {
        uint256 daysReceived;
        uint256 quantityTotal;
        uint256 monthlyBill;
    }

    mapping(address => MilkRecord) public milkLogs;

    event MilkUpdated(address indexed user, uint256 quantity, uint256 bill);

    function updateMilkDelivery(address user, uint256 quantity, uint256 bill) external {
        require(msg.sender == admin, "Only admin can update");
        milkLogs[user].daysReceived += 1;
        milkLogs[user].quantityTotal += quantity;
        milkLogs[user].monthlyBill += bill;
        emit MilkUpdated(user, quantity, bill);
    }

    // -------- Water Supply --------
    struct WaterRecord {
        uint256 daysDelivered;
        uint256 jarsReceived;
        uint256 monthlyBill;
    }

    mapping(address => WaterRecord) public waterLogs;

    event WaterRequested(address indexed user);
    event WaterUpdated(address indexed user, uint256 jars, uint256 bill);

    function requestWater() external {
        emit WaterRequested(msg.sender);
    }

    function updateWaterDelivery(address user, uint256 jars, uint256 bill) external {
        require(msg.sender == admin, "Only admin can update");
        waterLogs[user].daysDelivered += 1;
        waterLogs[user].jarsReceived += jars;
        waterLogs[user].monthlyBill += bill;
        emit WaterUpdated(user, jars, bill);
    }
}

