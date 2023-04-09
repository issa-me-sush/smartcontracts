// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SensorData {
    struct GPSData {
        uint256 timestamp;
        int256 lat;
        int256 lon;
    }

    struct TempData {
        uint256 timestamp;
        int256 value;
    }

    struct HumidityData {
        uint256 timestamp;
        uint256 value;
    }

    mapping(uint256 => GPSData) public gpsDataHistory;
    mapping(uint256 => TempData) public tempDataHistory;
    mapping(uint256 => HumidityData) public humidityDataHistory;

    mapping(uint256 => uint256) public gpsTimestampToIndex;
    mapping(uint256 => uint256) public tempTimestampToIndex;
    mapping(uint256 => uint256) public humidityTimestampToIndex;

    uint256 public gpsDataCount;
    uint256 public tempDataCount;
    uint256 public humidityDataCount;

    function storeGPSData(int256 lat, int256 lon) public {
        uint256 timestamp = block.timestamp;
        gpsDataHistory[gpsDataCount] = GPSData(timestamp, lat, lon);
        gpsTimestampToIndex[timestamp] = gpsDataCount;
        gpsDataCount++;
    }

    function storeTempData(int256 value) public {
        uint256 timestamp = block.timestamp;
        tempDataHistory[tempDataCount] = TempData(timestamp, value);
        tempTimestampToIndex[timestamp] = tempDataCount;
        tempDataCount++;
    }

    function storeHumidityData(uint256 value) public {
        uint256 timestamp = block.timestamp;
        humidityDataHistory[humidityDataCount] = HumidityData(timestamp, value);
        humidityTimestampToIndex[timestamp] = humidityDataCount;
        humidityDataCount++;
    }

    function getGPSDataByTimestamp(uint256 timestamp) public view returns (uint256, int256, int256) {
        uint256 index = gpsTimestampToIndex[timestamp];
        GPSData memory data = gpsDataHistory[index];
        return (data.timestamp, data.lat, data.lon);
    }

    function getTempDataByTimestamp(uint256 timestamp) public view returns (uint256, int256) {
        uint256 index = tempTimestampToIndex[timestamp];
        TempData memory data = tempDataHistory[index];
        return (data.timestamp, data.value);
    }

    function getHumidityDataByTimestamp(uint256 timestamp) public view returns (uint256, uint256) {
        uint256 index = humidityTimestampToIndex[timestamp];
        HumidityData memory data = humidityDataHistory[index];
        return (data.timestamp, data.value);
    }
}
