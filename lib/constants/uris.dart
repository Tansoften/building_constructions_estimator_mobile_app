import 'connection.dart';

const apiVersion    = "/api";

//Estimations
const estimationUri = "$host:$port$apiVersion/estimation/building";

//Windows
const windowUri     = "$host:$port$apiVersion/windows/building";

//Doors
const doorUri       = "$host:$port$apiVersion/doors/building";

//Building
const roomsUri      = "$host:$port$apiVersion/buildings";
const buildingUri   = "$host:$port$apiVersion/buildings/new";

//User
const registerUri   = "$host:$port$apiVersion/register";
const logoutUri     = "$host:$port$apiVersion/logout";
const userUri       = "$host:$port$apiVersion/user";
