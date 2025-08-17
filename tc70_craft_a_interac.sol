pragma solidity ^0.8.0;

contract InteractiveARVRModuleMonitor {
    // Mapping to store device information
    mapping (address => Device) public devices;

    // Struct to represent a device
    struct Device {
        string name;
        string type; // AR/VR
        bool isConnected;
        uint256 lastHeartbeat;
    }

    // Event emitted when a device connects
    event DeviceConnected(address deviceAddress, string name, string type);

    // Event emitted when a device disconnects
    event DeviceDisconnected(address deviceAddress);

    // Function to register a new device
    function registerDevice(string memory _name, string memory _type) public {
        devices[msg.sender] = Device(_name, _type, true, block.timestamp);
        emit DeviceConnected(msg.sender, _name, _type);
    }

    // Function to update device heartbeat
    function updateHeartbeat() public {
        devices[msg.sender].lastHeartbeat = block.timestamp;
    }

    // Function to disconnect a device
    function disconnectDevice() public {
        devices[msg.sender].isConnected = false;
        emit DeviceDisconnected(msg.sender);
    }

    // Function to get device information
    function getDeviceInfo(address _deviceAddress) public view returns (string memory, string memory, bool, uint256) {
        Device storage device = devices[_deviceAddress];
        return (device.name, device.type, device.isConnected, device.lastHeartbeat);
    }
}