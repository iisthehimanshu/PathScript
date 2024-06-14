import 'dart:convert';
import 'dart:math';
import 'dart:io';

class land {
  bool? landmarkExist;
  List<Landmarks>? landmarks;
  Map<String, Landmarks>? landmarksMap; // Add this line
  Map<String, String>? landmarksNameMap; // Add this line
  List<String>? landmarkNames;

  land(
      {this.landmarkExist,
      this.landmarks,
      this.landmarksMap,
      this.landmarkNames,
      this.landmarksNameMap}); // Update the constructor

  land.fromJson(Map<dynamic, dynamic> json) {
    landmarkExist = json['landmarkExist'];
    if (json['landmarks'] != null) {
      landmarks = <Landmarks>[];
      landmarksMap = {}; // Initialize the map
      landmarkNames = [];
      landmarksNameMap = {};
      json['landmarks'].forEach((v) {
        Landmarks landmark = Landmarks.fromJson(v);
        landmarks!.add(landmark);
        if (landmark.properties!.polyId != null) {
          landmarksMap![landmark.properties!.polyId!] =
              landmark; // Add to the map using polyID as the key
        }
        if (landmark.name != null) {
          landmarkNames!.add(landmark.name!);
          if (landmark.properties!.polyId != null) {
            landmarksNameMap![landmark.name!] = landmark.properties!.polyId!;
          }
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['landmarkExist'] = this.landmarkExist;
    if (this.landmarks != null) {
      data['landmarks'] = this.landmarks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void mergeLandmarks(List<Landmarks>? landmarksList) {
    if (landmarksList != null) {
      landmarks ??= [];
      landmarks!.addAll(landmarksList);
      // Update landmarksMap and landmarksNameMap accordingly
      landmarksMap ??= {};
      landmarksNameMap ??= {};
      for (var landmark in landmarksList) {
        if (landmark.properties!.polyId != null) {
          landmarksMap![landmark.properties!.polyId!] = landmark;
        }
        if (landmark.name != null) {
          landmarkNames ??= [];
          landmarkNames!.add(landmark.name!);
          if (landmark.properties!.polyId != null) {
            landmarksNameMap![landmark.name!] = landmark.properties!.polyId!;
          }
        }
      }
    }
  }
}

class Landmarks {
  Element? element;
  Properties? properties;
  String? sId;
  String? buildingID;
  int? coordinateX;
  int? coordinateY;
  int? doorX;
  int? doorY;
  String? featureType;
  String? type;
  int? floor;
  String? geometryType;
  String? name;
  List<Lifts>? lifts;
  List<Stairs>? stairs;
  List<Others>? others;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? buildingName;
  String? venueName;
  bool? wasPolyIdNull;

  Landmarks(
      {this.element,
      this.properties,
      this.sId,
      this.buildingID,
      this.coordinateX,
      this.coordinateY,
      this.doorX,
      this.doorY,
      this.featureType,
      this.type,
      this.floor,
      this.geometryType,
      this.name,
      this.lifts,
      this.stairs,
      this.others,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.buildingName,
      this.venueName,
      this.wasPolyIdNull});

  Landmarks.fromJson(Map<dynamic, dynamic> json) {
    element =
        json['element'] != null ? new Element.fromJson(json['element']) : null;
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    sId = json['_id'];
    wasPolyIdNull = false;
    if (properties!.polyId == null) {
      wasPolyIdNull = true;
      properties!.polyId = json['_id'];
    }
    buildingID = json['building_ID'];
    coordinateX = json['coordinateX'] != null
        ? json['coordinateX'].toInt()
        : json['coordinateX'];
    coordinateY = json['coordinateY'] != null
        ? json['coordinateY'].toInt()
        : json['coordinateY'];
    doorX = json['doorX'] != null ? json['doorX'].toInt() : json['doorX'];
    doorY = json['doorY'] != null ? json['doorY'].toInt() : json['doorY'];
    featureType = json['feature_type'];
    type = json['type'];
    floor = json['floor'];
    geometryType = json['geometryType'];
    name = json['name'];
    if (json['lifts'] != null) {
      lifts = <Lifts>[];
      json['lifts'].forEach((v) {
        lifts!.add(new Lifts.fromJson(v));
      });
    }
    if (json['stairs'] != null) {
      stairs = <Stairs>[];
      json['stairs'].forEach((v) {
        stairs!.add(new Stairs.fromJson(v));
      });
    }
    if (json['others'] != null) {
      others = <Others>[];
      json['others'].forEach((v) {
        others!.add(new Others.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    buildingName = json['buildingName'];
    venueName = json['venueName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.element != null) {
      data['element'] = this.element!.toJson();
    }
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    data['_id'] = this.sId;
    data['building_ID'] = this.buildingID;
    data['coordinateX'] = this.coordinateX;
    data['coordinateY'] = this.coordinateY;
    data['doorX'] = this.doorX;
    data['doorY'] = this.doorY;
    data['feature_type'] = this.featureType;
    data['type'] = this.type;
    data['floor'] = this.floor;
    data['geometryType'] = this.geometryType;
    data['name'] = this.name;
    if (this.lifts != null) {
      data['lifts'] = this.lifts!.map((v) => v.toJson()).toList();
    }
    if (this.stairs != null) {
      data['stairs'] = this.stairs!.map((v) => v.toJson()).toList();
    }
    if (this.others != null) {
      data['others'] = this.others!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['buildingName'] = this.buildingName;
    data['venueName'] = this.venueName;
    return data;
  }
}

class Element {
  String? type;
  String? subType;

  Element({this.type, this.subType});

  Element.fromJson(Map<dynamic, dynamic> json) {
    type = json['type'];
    subType = json['subType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['subType'] = this.subType;
    return data;
  }
}

class Properties {
  String? contactNo;
  String? daysOpen;
  String? direction;
  String? doorMaterial;
  String? doorType;
  String? email;
  String? endTime;
  String? latitude;
  String? longitude;
  String? motion;
  String? node;
  String? nodeId;
  String? openingMechanism;
  String? protocol;
  String? startTime;
  String? timings;
  String? url;
  String? macId;
  String? arName;
  String? arValue;
  String? approxHeight;
  String? tapDirection;
  String? tapType;
  String? basinClock;
  bool? blowDryer;
  String? cubicleClock;
  bool? handShower;
  bool? liquidSoap;
  String? numCubicles;
  String? numUrinals;
  String? numWashbasin;
  bool? paperNapkins;
  bool? sanitaryNapkins;
  bool? soapbar;
  bool? tapMug;
  bool? toiletRolls;
  String? urinalClock;
  String? washroomType;
  String? wheelChairAccessibility;
  String? downwardSteps;
  String? name;
  String? stepHeight;
  String? stepsNumber;
  String? upwardSteps;
  String? stairsPoint;
  String? audio;
  String? brailleAvailability;
  String? capacity;
  String? callLocation;
  String? panelDir;
  String? shopNature;
  String? photo;
  bool? polygonExist;
  String? polyId;
  String? filename;
  List<String>? nonWalkableGrids;
  int? floorLength;
  int? floorBreadth;
  List<String>? flrDistMatrix;
  List<String>? frConn;
  List<String>? clickedPoints;
  int? floorAngle;
  List<String>? polygonId;

  Properties(
      {this.contactNo,
      this.daysOpen,
      this.direction,
      this.doorMaterial,
      this.doorType,
      this.email,
      this.endTime,
      this.latitude,
      this.longitude,
      this.motion,
      this.node,
      this.nodeId,
      this.openingMechanism,
      this.protocol,
      this.startTime,
      this.timings,
      this.url,
      this.macId,
      this.arName,
      this.arValue,
      this.approxHeight,
      this.tapDirection,
      this.tapType,
      this.basinClock,
      this.blowDryer,
      this.cubicleClock,
      this.handShower,
      this.liquidSoap,
      this.numCubicles,
      this.numUrinals,
      this.numWashbasin,
      this.paperNapkins,
      this.sanitaryNapkins,
      this.soapbar,
      this.tapMug,
      this.toiletRolls,
      this.urinalClock,
      this.washroomType,
      this.wheelChairAccessibility,
      this.downwardSteps,
      this.name,
      this.stepHeight,
      this.stepsNumber,
      this.upwardSteps,
      this.stairsPoint,
      this.audio,
      this.brailleAvailability,
      this.capacity,
      this.callLocation,
      this.panelDir,
      this.shopNature,
      this.photo,
      this.polygonExist,
      this.polyId,
      this.filename,
      this.nonWalkableGrids,
      this.floorLength,
      this.floorBreadth,
      this.flrDistMatrix,
      this.frConn,
      this.clickedPoints,
      this.floorAngle,
      this.polygonId});

  Properties.fromJson(Map<dynamic, dynamic> json) {
    contactNo = json['contactNo'];
    daysOpen = json['daysOpen'];
    direction = json['direction'];
    doorMaterial = json['doorMaterial'];
    doorType = json['doorType'];
    email = json['email'];
    endTime = json['endTime'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    motion = json['motion'];
    node = json['node'];
    nodeId = json['nodeId'];
    openingMechanism = json['openingMechanism'];
    protocol = json['protocol'];
    startTime = json['startTime'];
    timings = json['timings'];
    url = json['url'];
    macId = json['macId'];
    arName = json['arName'];
    arValue = json['arValue'];
    approxHeight = json['approxHeight'];
    tapDirection = json['tapDirection'];
    tapType = json['tapType'];
    basinClock = json['basinClock'];
    blowDryer = json['blowDryer'];
    cubicleClock = json['cubicleClock'];
    handShower = json['handShower'];
    liquidSoap = json['liquidSoap'];
    numCubicles = json['numCubicles'];
    numUrinals = json['numUrinals'];
    numWashbasin = json['numWashbasin'];
    paperNapkins = json['paperNapkins'];
    sanitaryNapkins = json['sanitaryNapkins'];
    soapbar = json['soapbar'];
    tapMug = json['tapMug'];
    toiletRolls = json['toiletRolls'];
    urinalClock = json['urinalClock'];
    washroomType = json['washroomType'];
    wheelChairAccessibility = json['wheelChairAccessibility'];
    downwardSteps = json['downwardSteps'];
    name = json['name'];
    stepHeight = json['stepHeight'];
    stepsNumber = json['stepsNumber'];
    upwardSteps = json['upwardSteps'];
    stairsPoint = json['stairsPoint'];
    audio = json['audio'];
    brailleAvailability = json['brailleAvailability'];
    capacity = json['capacity'];
    callLocation = json['callLocation'];
    panelDir = json['panelDir'];
    shopNature = json['shopNature'];
    photo = json['photo'];
    polygonExist = json['polygonExist'];
    polyId = json['polyId'];
    filename = json['filename'];
    nonWalkableGrids = json['nonWalkableGrids'].cast<String>();
    floorLength = json['floorLength'];
    floorBreadth = json['floorBreadth'];
    flrDistMatrix = json['flr_dist_matrix'].cast<String>();
    frConn = json['frConn'].cast<String>();
    clickedPoints = json['clickedPoints'].cast<String>();
    floorAngle = json['floorAngle'];
    polygonId = json['polygonId'].cast<String>();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactNo'] = this.contactNo;
    data['daysOpen'] = this.daysOpen;
    data['direction'] = this.direction;
    data['doorMaterial'] = this.doorMaterial;
    data['doorType'] = this.doorType;
    data['email'] = this.email;
    data['endTime'] = this.endTime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['motion'] = this.motion;
    data['node'] = this.node;
    data['nodeId'] = this.nodeId;
    data['openingMechanism'] = this.openingMechanism;
    data['protocol'] = this.protocol;
    data['startTime'] = this.startTime;
    data['timings'] = this.timings;
    data['url'] = this.url;
    data['macId'] = this.macId;
    data['arName'] = this.arName;
    data['arValue'] = this.arValue;
    data['approxHeight'] = this.approxHeight;
    data['tapDirection'] = this.tapDirection;
    data['tapType'] = this.tapType;
    data['basinClock'] = this.basinClock;
    data['blowDryer'] = this.blowDryer;
    data['cubicleClock'] = this.cubicleClock;
    data['handShower'] = this.handShower;
    data['liquidSoap'] = this.liquidSoap;
    data['numCubicles'] = this.numCubicles;
    data['numUrinals'] = this.numUrinals;
    data['numWashbasin'] = this.numWashbasin;
    data['paperNapkins'] = this.paperNapkins;
    data['sanitaryNapkins'] = this.sanitaryNapkins;
    data['soapbar'] = this.soapbar;
    data['tapMug'] = this.tapMug;
    data['toiletRolls'] = this.toiletRolls;
    data['urinalClock'] = this.urinalClock;
    data['washroomType'] = this.washroomType;
    data['wheelChairAccessibility'] = this.wheelChairAccessibility;
    data['downwardSteps'] = this.downwardSteps;
    data['name'] = this.name;
    data['stepHeight'] = this.stepHeight;
    data['stepsNumber'] = this.stepsNumber;
    data['upwardSteps'] = this.upwardSteps;
    data['stairsPoint'] = this.stairsPoint;
    data['audio'] = this.audio;
    data['brailleAvailability'] = this.brailleAvailability;
    data['capacity'] = this.capacity;
    data['callLocation'] = this.callLocation;
    data['panelDir'] = this.panelDir;
    data['shopNature'] = this.shopNature;
    data['photo'] = this.photo;
    data['polygonExist'] = this.polygonExist;
    data['polyId'] = this.polyId;
    data['filename'] = this.filename;
    data['nonWalkableGrids'] = this.nonWalkableGrids;
    data['floorLength'] = this.floorLength;
    data['floorBreadth'] = this.floorBreadth;
    data['flr_dist_matrix'] = this.flrDistMatrix;
    data['frConn'] = this.frConn;
    data['clickedPoints'] = this.clickedPoints;
    data['floorAngle'] = this.floorAngle;
    data['polygonId'] = this.polygonId;
    return data;
  }
}

class Lifts {
  String? name;
  int? distance;
  int? x;
  int? y;

  Lifts({this.name, this.distance, this.x, this.y});

  Lifts.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
    x = json['x'].toInt();
    y = json['y'].toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

class CommonLifts {
  String? name;
  int? distance;
  int? x1;
  int? x2;
  int? y1;
  int? y2;

  CommonLifts({this.name, this.distance, this.x1, this.y1, this.x2, this.y2});
}

class Stairs {
  String? name;
  int? distance;
  int? x;
  int? y;

  Stairs({this.name, this.distance, this.x, this.y});

  Stairs.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
    x = json['x'].toInt();
    y = json['y'].toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

class Others {
  String? name;
  int? distance;

  Others({this.name, this.distance});

  Others.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['distance'] = this.distance;
    return data;
  }
}

class tools {
  static Map<int, int> getTurnMap(List<int> pathNodes, int numCols) {
    Map<int, int> res = new Map();

    for (int i = 1; i < pathNodes.length - 1; i++) {
      int currPos = pathNodes[i];
      int nextPos = pathNodes[i + 1];
      int prevPos = pathNodes[i - 1];

      int x1 = (currPos % numCols);
      int y1 = (currPos ~/ numCols);

      int x2 = (nextPos % numCols);
      int y2 = (nextPos ~/ numCols);

      int x3 = (prevPos % numCols);
      int y3 = (prevPos ~/ numCols);

      int prevDeltaX = x1 - x3;
      int prevDeltaY = y1 - y3;
      int nextDeltaX = x2 - x1;
      int nextDeltaY = y2 - y1;

      if ((prevDeltaX != nextDeltaX) || (prevDeltaY != nextDeltaY)) {
        if (prevDeltaX == 0 && nextDeltaX == 0) {
        } else if (prevDeltaY == 0 && nextDeltaY == 0) {
        } else {
          res[i] = currPos;
        }
      }
    }
    return res;
  }

  static List<int> getTurnpoints(List<int> pathNodes, int numCols) {
    List<int> res = [];

    for (int i = 1; i < pathNodes.length - 1; i++) {
      int currPos = pathNodes[i];
      int nextPos = pathNodes[i + 1];
      int prevPos = pathNodes[i - 1];

      int x1 = (currPos % numCols);
      int y1 = (currPos ~/ numCols);

      int x2 = (nextPos % numCols);
      int y2 = (nextPos ~/ numCols);

      int x3 = (prevPos % numCols);
      int y3 = (prevPos ~/ numCols);

      int prevDeltaX = x1 - x3;
      int prevDeltaY = y1 - y3;
      int nextDeltaX = x2 - x1;
      int nextDeltaY = y2 - y1;

      if ((prevDeltaX != nextDeltaX) || (prevDeltaY != nextDeltaY)) {
        if (prevDeltaX == 0 && nextDeltaX == 0) {
        } else if (prevDeltaY == 0 && nextDeltaY == 0) {
        } else {
          res.add(currPos);
        }
      }
    }
    return res;
  }

  static double calculateDistance(List<int> p1, List<int> p2) {
    return sqrt(pow(p1[0] - p2[0], 2) + pow(p1[1] - p2[1], 2));
  }

  static List<int> generateCompletePath(
      List<int> turns, int numCols, List<int> nonWalkableCells) {
    List<int> completePath = [];

    // Start with the first point in your path
    int currentPoint = turns[0];
    int x = currentPoint % numCols;
    int y = currentPoint ~/ numCols;
    completePath.add(x + y * numCols);

    // Connect each turn point with a straight line
    for (int i = 1; i < turns.length; i++) {
      int turnPoint = turns[i];
      int turnX = turnPoint % numCols;
      int turnY = turnPoint ~/ numCols;

      // Connect straight line from current point to turn point
      while (x != turnX || y != turnY) {
        if (x < turnX) {
          x++;
        } else if (x > turnX) {
          x--;
        }
        if (y < turnY) {
          y++;
        } else if (y > turnY) {
          y--;
        }

        // Convert current x, y coordinates back to index form
        int currentIndex = x + y * numCols;

        // Check if the current index is in the non-walkable cells list
        if (nonWalkableCells.contains(currentIndex)) {
          // Handle non-walkable cell, such as breaking out of the loop or finding an alternative path
          // Here, I'll just break out of the loop
          break;
        }

        // Add the current index to the complete path
        completePath.add(currentIndex);
      }
    }

    return completePath;
  }
}

class Node {
  int index;
  int x, y;
  int g = 0, h = 0, f = 0;
  Node? parent;

  Node(this.index, this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Node && runtimeType == other.runtimeType && index == other.index;

  @override
  int get hashCode => index.hashCode;
}

Future<List<int>> findBestPathAmongstBoth(
    int numRows,
    int numCols,
    List<int> nonWalkableCells,
    int sourceIndex,
    int destinationIndex,
    int floor,
    String Bid) async {
  int sourceX = sourceIndex % numCols;
  int sourceY = sourceIndex ~/ numCols;
  int destinationX = destinationIndex % numCols;
  int destinationY = destinationIndex ~/ numCols;

  // List<int> p1 = findPath(
  //     numRows, numCols, nonWalkableCells, sourceIndex, destinationIndex);
  // p1 = await getFinalOptimizedPath(p1, nonWalkableCells, numCols, sourceX, sourceY,
  //     destinationX, destinationY, building, floor,Bid);
  // List<int> p2 = findPath(
  //     numRows, numCols, nonWalkableCells, destinationIndex, sourceIndex);
  // p2 = await getFinalOptimizedPath(p2, nonWalkableCells, numCols, destinationX,
  //     destinationY, sourceX, sourceY, building, floor,Bid);

  List<int> p1 = findPath(
      numRows, numCols, nonWalkableCells, sourceIndex, destinationIndex);
  p1 = getFinalOptimizedPath(p1, nonWalkableCells, numCols, sourceX, sourceY,
      destinationX, destinationY);
  List<int> p2 = findPath(
      numRows, numCols, nonWalkableCells, destinationIndex, sourceIndex);
  p2 = getFinalOptimizedPath(p2, nonWalkableCells, numCols, destinationX,
      destinationY, sourceX, sourceY);

  Map<int, int> p1turns = tools.getTurnMap(p1, numCols);
  Map<int, int> p2turns = tools.getTurnMap(p2, numCols);



// If either path is empty, return the other path
  if (p1.isEmpty) {
    return p2.reversed.toList();
  } else if (p2.isEmpty) {
    return p1;
  }

  // Check if both paths start and end at the correct indices
  bool p1Valid = p1.first == sourceIndex && p1.last == destinationIndex;
  bool p2Valid = p2.first == destinationIndex && p2.last == sourceIndex;

  if (p1Valid && !p2Valid) {
    return p1;
  } else if (!p1Valid && p2Valid) {
    return p2.reversed.toList();
  }

  // Compare the number of turns
  if (p1turns.length < p2turns.length) {
    return p1;
  } else if (p1turns.length > p2turns.length) {
    return p2.reversed.toList();
  }

  // If the number of turns is the same, compare the length of the paths
  if (p1.length < p2.length) {
    return p1;
  } else if (p1.length > p2.length) {
    return p2.reversed.toList();
  } else {
    return p1;
  }

  // If all else fails, return an empty list
  return [];
}

List<int> findPath(
  int numRows,
  int numCols,
  List<int> nonWalkableCells,
  int sourceIndex,
  int destinationIndex,
) {
  sourceIndex -= 1;
  destinationIndex -= 1;

  if (sourceIndex < 0 ||
      sourceIndex >= numRows * numCols ||
      destinationIndex < 0 ||
      destinationIndex >= numRows * numCols) {
    return [];
  }

  List<Node> nodes = List.generate(numRows * numCols, (index) {
    int x = index % numCols + 1;
    int y = index ~/ numCols + 1;
    return Node(index + 1, x, y);
  });

  Set<int> nonWalkableSet = nonWalkableCells.toSet();
  List<int> openSet = [sourceIndex];
  Set<int> closedSet = {};

  while (openSet.isNotEmpty) {
    int currentIdx = openSet.removeAt(0);
    closedSet.add(currentIdx);

    if (currentIdx == destinationIndex) {
      List<int> path = [];
      Node current = nodes[currentIdx];
      while (current.parent != null) {
        path.insert(0, current.index);
        current = current.parent!;
      }
      path.insert(0, sourceIndex + 1);
      return path;
    }

    for (int neighborIndex
        in getNeighbors(currentIdx, numRows, numCols, nonWalkableSet)) {
      if (closedSet.contains(neighborIndex)) continue;

      Node neighbor = nodes[neighborIndex];
      int tentativeG =
          nodes[currentIdx].g + getMovementCost(nodes[currentIdx], neighbor);

      if (!openSet.contains(neighborIndex) || tentativeG < neighbor.g) {
        neighbor.parent = nodes[currentIdx];
        neighbor.g = tentativeG;
        neighbor.h = heuristic(neighbor, nodes[destinationIndex]);
        neighbor.f = neighbor.g + neighbor.h;

        if (!openSet.contains(neighborIndex)) {
          openSet.add(neighborIndex);
          openSet.sort((a, b) {
            int compare = nodes[a].f.compareTo(nodes[b].f);
            if (compare == 0) {
              return nodes[a].h.compareTo(nodes[b].h);
            }
            return compare;
          });
        }
      }
    }
  }

  return [];
}

// Function to skip points between consecutive turns in the path
List<int> skipConsecutiveTurns(
    List<int> path, int numRows, int numCols, Set<int> nonWalkableSet) {
  List<int> optimizedPath = [];
  optimizedPath.add(path.first);

  for (int i = 1; i < path.length - 1; i++) {
    int prev = path[i - 1];
    int current = path[i];
    int next = path[i + 1];

    // Check if the points form a turn
    if (!isTurn(prev, current, next, numRows, numCols) ||
        nonWalkableSet.contains(current)) {
      optimizedPath.add(current);
    }
  }

  optimizedPath.add(path.last);
  return optimizedPath;
}

// Function to check if the given points form a turn
bool isTurn(int prev, int current, int next, int numRows, int numCols) {
  int prevRow = prev ~/ numCols;
  int prevCol = prev % numCols;
  int currentRow = current ~/ numCols;
  int currentCol = current % numCols;
  int nextRow = next ~/ numCols;
  int nextCol = next % numCols;

  // Check if the points form a turn
  return (prevRow == currentRow && nextCol == currentCol) ||
      (prevCol == currentCol && nextRow == currentRow);
}

List<int> getNeighbors(
    int index, int numRows, int numCols, Set<int> nonWalkableSet) {
  int x = (index % numCols) + 1;
  int y = (index ~/ numCols) + 1;
  List<int> neighbors = [];

  for (int dx = -1; dx <= 1; dx++) {
    for (int dy = -1; dy <= 1; dy++) {
      if (dx == 0 && dy == 0) {
        continue;
      }

      int newX = x + dx;
      int newY = y + dy;

      if (newX >= 1 && newX <= numCols && newY >= 1 && newY <= numRows) {
        int neighborIndex = (newY - 1) * numCols + (newX - 1);
        if (!nonWalkableSet.contains(neighborIndex + 1)) {
          neighbors.add(neighborIndex);
        }
      }
    }
  }

  return neighbors;
}

int heuristic(Node a, Node b) {
  double dx = (a.x - b.x).toDouble();
  double dy = (a.y - b.y).toDouble();
  return sqrt(dx * dx + dy * dy).round();
}

int getMovementCost(Node a, Node b) {
  return (a.x != b.x && a.y != b.y) ? 15 : 10;
}

List<Node> getTurnpoints(List<Node> pathNodes, int numCols) {
  List<Node> res = [];

  for (int i = 1; i < pathNodes.length - 1; i++) {
    Node currPos = pathNodes[i];
    Node nextPos = pathNodes[i + 1];
    Node prevPos = pathNodes[i - 1];

    int x1 = (currPos.index % numCols);
    int y1 = (currPos.index ~/ numCols);

    int x2 = (nextPos.index % numCols);
    int y2 = (nextPos.index ~/ numCols);

    int x3 = (prevPos.index % numCols);
    int y3 = (prevPos.index ~/ numCols);

    int prevDeltaX = x1 - x3;
    int prevDeltaY = y1 - y3;
    int nextDeltaX = x2 - x1;
    int nextDeltaY = y2 - y1;

    if ((prevDeltaX != nextDeltaX) || (prevDeltaY != nextDeltaY)) {
      res.add(currPos);
    }
  }
  return res;
}

double pointLineDistance(Node point, Node start, Node end) {
  if (start.x == end.x && start.y == end.y) {
    return distance(point, start);
  } else {
    double n = ((end.x - start.x) * (start.y - point.y) -
                (start.x - point.x) * (end.y - start.y))
            .abs() +
        0.0;
    double d = sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2));
    return n / d;
  }
}

double distance(Node a, Node b) {
  return sqrt(pow(a.y - b.x, 2) + pow(a.y - b.x, 2));
}

List<Node> rdp(List<Node> points, double epsilon, Set<int> nonWalkableIndices) {
  if (points.length < 3) return points;

  // Find the point with the maximum distance
  double dmax = 0;
  int index = 0;
  int end = points.length - 1;
  for (int i = 1; i < end; i++) {
    double d = perpendicularDistance(points[i], points[0], points[end]);
    if (d > dmax) {
      index = i;
      dmax = d;
    }
  }

  // If max distance is greater than epsilon, recursively simplify
  List<Node> result = [];
  if (dmax > epsilon) {
    List<Node> recursiveResults1 =
        rdp(points.sublist(0, index + 1), epsilon, nonWalkableIndices);
    List<Node> recursiveResults2 =
        rdp(points.sublist(index, end + 1), epsilon, nonWalkableIndices);
    result = [
      ...recursiveResults1.sublist(0, recursiveResults1.length - 1),
      ...recursiveResults2
    ];
  } else {
    // Ensure rectilinear path by including only points that align with the grid
    result = [points[0]]; // Start node is always included
    Node previousPoint = points[0];
    for (int i = 1; i < end; i++) {
      if (points[i].x == previousPoint.x || points[i].y == previousPoint.y) {
        if (!nonWalkableIndices.contains(points[i].index)) {
          result.add(points[i]);
          previousPoint = points[i];
        }
      }
    }
    result.add(points[end]); // End node is always included
  }

  return result;
}

List<int> getIntersectionPoints(int currX, int currY, int prevX, int prevY,
    int nextX, int nextY, int nextNextX, int nextNextY) {
  double x1 = currX + 0.0, y1 = currY + 0.0;
  double x2 = prevX + 0.0, y2 = prevY + 0.0;
  double x3 = nextX + 0.0, y3 = nextY + 0.0;
  double x4 = nextNextX + 0.0, y4 = nextNextY + 0.0;

  double determinant = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);

  if (determinant == 0) {
    // Lines are parallel, no intersection
    return [];
  }

  double intersectionX =
      ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) /
          determinant;
  double intersectionY =
      ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) /
          determinant;

  return [intersectionX.toInt(), intersectionY.toInt()];
}

double perpendicularDistance(Node point, Node lineStart, Node lineEnd) {
  double dx = (lineEnd.x - lineStart.x) + 0.0;
  double dy = (lineEnd.y - lineStart.y) + 0.0;
  double mag = dx * dx + dy * dy;
  double u =
      ((point.x - lineStart.x) * dx + (point.y - lineStart.y) * dy) / mag;
  double ix, iy;
  if (u < 0) {
    ix = lineStart.x.toDouble();
    iy = lineStart.y.toDouble();
  } else if (u > 1) {
    ix = lineEnd.x.toDouble();
    iy = lineEnd.y.toDouble();
  } else {
    ix = (lineStart.x + u * dx).toDouble();
    iy = (lineStart.y + u * dy).toDouble();
  }
  double dx2 = point.x - ix;
  double dy2 = point.y - iy;
  return sqrt(dx2 * dx2 + dy2 * dy2);
}

List<int> getOptiPath(Map<int, int> getTurns, int numCols, List<int> path) {
  Map<int, int> pt = {};
  var keys = getTurns.keys.toList();
  for (int i = 0; i < keys.length - 1; i++) {
    if (keys[i + 1] - 1 == keys[i]) {
      pt[keys[i + 1]] = getTurns[keys[i + 1]]!;
    }
  }

  var ptKeys = pt.keys.toList();
  for (int i = 0; i < pt.length; i++) {
    int curr = path[ptKeys[i]];
    int next = path[ptKeys[i] + 1];
    int prev = path[ptKeys[i] - 1];
    int nextNext = path[ptKeys[i] + 2];

    int currX = curr % numCols;
    int currY = curr ~/ numCols;

    int nextX = next % numCols;
    int nextY = next ~/ numCols;

    int prevX = prev % numCols;
    int prevY = prev ~/ numCols;

    int nextNextX = nextNext % numCols;
    int nextNextY = nextNext ~/ numCols;

    if (nextX == currX) {
      currY = prevY;
      int newIndexY = currY * numCols + currX;
      path[ptKeys[i]] = newIndexY;
    } else if (nextY == currY) {
      currX = prevX;
      int newIndexX = currY * numCols + currX;
      path[ptKeys[i]] = newIndexX;
    }
  }

  return path;
}

List<int> getFinalOptimizedPath(List<int> path, List<int> nonWalkableCells,
    int numCols, int sourceX, int sourceY, int destinationX, int destinationY) {
  List<List<int>> getPoints = [];
  Map<int, int> getTurns = tools.getTurnMap(path, numCols);

  path = getOptiPath(getTurns, numCols, path);

  List<int> turns = tools.getTurnpoints(path, numCols);

  for (int i = 0; i < turns.length; i++) {
    int x = turns[i] % numCols;
    int y = turns[i] ~/ numCols;

    getPoints.add([x, y]);
  }
//optimizing turnsss
  for (int i = 0; i < getPoints.length - 1; i++) {
    if (getPoints[i][0] != getPoints[i + 1][0] &&
        getPoints[i][1] != getPoints[i + 1][1]) {
      int dist =
          tools.calculateDistance(getPoints[i], getPoints[i + 1]).toInt();
      if (dist <= 15) {
        //points of prev turn
        int index1 = getPoints[i][0] + getPoints[i][1] * numCols;
        int ind1 = path.indexOf(index1);

        int prev = path[ind1 - 1];

        int currX = index1 % numCols;
        int currY = index1 ~/ numCols;

        int prevX = prev % numCols;
        int prevY = prev ~/ numCols;

        //straight line eqautaion1
        //y-prevY=(currY-prevY)/(currX-prevX)*(x-prevX);

        //points of next turn;
        int index2 = getPoints[i + 1][0] + getPoints[i + 1][1] * numCols;
        int ind2 = path.indexOf(index2);
        int next = path[ind2 + 1];

        int nextX = index2 % numCols;
        int nextY = index2 ~/ numCols;

        int nextNextX = next % numCols;
        int nextNextY = next ~/ numCols;

        int ind3 = path.indexOf(index1 - 1);

        List<int> intersectPoints = getIntersectionPoints(
            currX, currY, prevX, prevY, nextX, nextY, nextNextX, nextNextY);

        if (intersectPoints.isNotEmpty) {
          //non walkabkle check

          //first along the x plane

          //intersecting points
          int x1 = intersectPoints[0];
          int y1 = intersectPoints[1];

          //next point
          int x2 = nextX;
          int y2 = nextY;

          bool isNonWalkablePoint = false;

          while (x1 <= x2) {
            int pointIndex = x1 + y1 * numCols;
            if (nonWalkableCells.contains(pointIndex)) {
              isNonWalkablePoint = true;
              break;
            }
            x1 = x1 + 1;
          }

          //along the y-axis

          //next point
          int x3 = currX;
          int y3 = currY;

          while (y1 >= y3) {
            int pointIndex = x3 + y1 * numCols;
            if (nonWalkableCells.contains(pointIndex)) {
              isNonWalkablePoint = true;
              break;
            }
            y1 = y1 - 1;
          }

          if (isNonWalkablePoint == false) {
            path.removeRange(ind1, ind2);

            int newIndex = intersectPoints[0] + intersectPoints[1] * numCols;

            path[ind1] = newIndex;

            getPoints[i] = [intersectPoints[0], intersectPoints[1]];

            getPoints.removeAt(i + 1);
          }
        }
      }
    }
  }
  List<int> tu = [];
  tu.add(sourceX + sourceY * numCols);
  tu.addAll(tools.getTurnpoints(path, numCols));
  tu.add(destinationX + destinationY * numCols);

  //creating a new array and gearting the path from it.
  //  path.clear();
  // //
  path = tools.generateCompletePath(tu, numCols, nonWalkableCells);

  return path;
}

List<List<int>> findIntersection(List<int> p1, List<int> p2, List<int> p3,
    List<int> p11, List<int> p22, List<int> nonWalkableCells, int numCols) {
  double m1 = (p11[1] - p1[1]) / (p11[0] - p1[0]);
  double m2 = (p22[1] - p2[1]) / (p22[0] - p2[0]);
  if (m1.isInfinite || m1.isNaN) {
    m1 = p1[0] + 0.0;
  }
  if (m2.isInfinite || m2.isNaN) {
    m2 = p2[0] + 0.0;
  }
  //eq of parallel lines
  double node1 = (m1);
  double node2 = (m2);

  //checking vertical and horizontal condition

  List<List<int>> intersections = [
    [node1.toInt(), p3[1]],
    [node2.toInt(), p3[1]]
  ];

  int index1 = intersections[0][0] + intersections[0][1] * numCols;
  int index2 = intersections[1][0] + intersections[1][1] * numCols;
  if (nonWalkableCells.contains(index1) || nonWalkableCells.contains(index2)) {
    node1 = p1[1] + 0.0;
    node2 = p2[1] + 0.0;
    intersections = [
      [p3[0], node1.toInt()],
      [p3[0], node2.toInt()],
      [p1[0], p1[1]],
      [p2[0], p2[1]]
    ];
  } else {
    intersections = [
      [node1.toInt(), p3[1]],
      [node2.toInt(), p3[1]],
      [p1[0], p1[1]],
      [p2[0], p2[1]]
    ];
  }
  //noww new points areeee

  return intersections;
}

// Function to calculate the distance between two points
double calculateDistance(List<int> p1, List<int> p2) {
  return sqrt(pow((p2[0] - p1[0]), 2) + pow((p2[1] - p1[1]), 2));
}

// Function to check if a point (x, y) is within range of P1 or P2
bool isWithinRange(List<int> target, List<int> p1, List<int> p2, double range) {
  double distanceToP1 = calculateDistance(target, p1);
  double distanceToP2 = calculateDistance(target, p2);
  return distanceToP1 <= range && distanceToP2 <= range;
}

int calculateindex(int x, int y, int fl) {
  return (y * fl) + x;
}

int sumUsingLoop(int n) {
  int sum = 0;
  for (int i = 1; i <= n; i++) {
    sum += i;
  }
  return sum;
}

void main() async {
  String data = await File('LandmarkData.json').readAsString();
  Map<String, dynamic> responseBody = jsonDecode(data);
  land LandmarkData = land.fromJson(responseBody);
  Map<int, List<int>> nonWalkable = {};
  Map<int, List<int>> floorDimenssion = {};
  List<List<dynamic>> output = [[],[],[],[]];
  List<String> toBeRemoved = [];

  LandmarkData.landmarks!.forEach((Element) {
    if (Element.element!.type == "Floor") {
      List<int> allIntegers = [];
      String jointnonwalkable =
      Element.properties!.nonWalkableGrids!.join(',');
      RegExp regExp = RegExp(r'\d+');
      Iterable<Match> matches = regExp.allMatches(jointnonwalkable);
      for (Match match in matches) {
        String matched = match.group(0)!;
        allIntegers.add(int.parse(matched));
      }
      nonWalkable[Element.floor!] = allIntegers;
      floorDimenssion[Element.floor!] = [
        Element.properties!.floorLength!,
        Element.properties!.floorBreadth!
      ];
    }
  });

  int totalLandmarksbefore = 0;
  LandmarkData.landmarks!.forEach((Element){
    if((Element.element!.subType != "Floor")){
      if((Element.doorX??Element.coordinateX!) > floorDimenssion[Element.floor]![0] || (Element.doorY??Element.coordinateY!) > floorDimenssion[Element.floor]![1]){
        output[0].add("${Element.name} is wrongly annotated");
        toBeRemoved.add(Element.sId!);
      }else if(Element.name == null || Element.name!.toLowerCase() == "undefined"){
        output[0].add("${Element.name} is wrongly annotated");
      }else{
        totalLandmarksbefore ++;
      }
    }
  });

  toBeRemoved.forEach((Element) {
    LandmarkData.landmarks!.removeWhere((element) => element.sId == Element);
  });

  int totalLandmarksafter = totalLandmarksbefore - toBeRemoved.length;


  int totalPath = sumUsingLoop(totalLandmarksafter);

  print("Landmarks before are $totalLandmarksbefore and after are $totalLandmarksafter");



  for (int i = 0; i < LandmarkData.landmarks!.length - 1; i++) {
    if ((LandmarkData.landmarks![i].element!.subType != "Floor")) {
      int x = 0;
      for (int j = i + 1; j < LandmarkData.landmarks!.length; j++) {
        if (LandmarkData.landmarks![j].element!.subType != "Floor" && LandmarkData.landmarks![j].floor == LandmarkData.landmarks![i].floor) {
          int floor = LandmarkData.landmarks![i].floor!;
          int sourceX = LandmarkData.landmarks![i].doorX??LandmarkData.landmarks![i].coordinateX!;
          int sourceY = LandmarkData.landmarks![i].doorY??LandmarkData.landmarks![i].coordinateY!;
          int destinationX = LandmarkData.landmarks![j].doorX??LandmarkData.landmarks![j].coordinateX!;
          int destinationY = LandmarkData.landmarks![j].doorY??LandmarkData.landmarks![j].coordinateY!;
          int numRows = floorDimenssion[floor]![1]; //floor breadth
          int numCols = floorDimenssion[floor]![0]; //floor length
          int sourceIndex = calculateindex(sourceX, sourceY, numCols);
          int destinationIndex = calculateindex(destinationX, destinationY, numCols);
          try{
            List<int> path = await findBestPathAmongstBoth(
                numRows,
                numCols,
                nonWalkable[floor]!,
                sourceIndex,
                destinationIndex,
                floor,"");
            if(path.first != sourceIndex || path.last != destinationIndex){
              output[2].add("Path Not found between ${LandmarkData.landmarks![i].name} and ${LandmarkData.landmarks![j].name}");
            }else{
              x++;
            }
          }catch(E){
            output[3].add("Error while finding path between ${LandmarkData.landmarks![i].name} and ${LandmarkData.landmarks![j].name}");
          }
        }
        print("${i*totalLandmarksafter + j} / $totalPath");
      }
      if(x==0){
        output[1].add("Position of ${LandmarkData.landmarks![i].name} is not right");
      }
    }
  }

  StringBuffer csvData = StringBuffer();
  for (var row in output) {
    csvData.writeln(row.map((e) => e.toString()).join(','));
  }

  // Specify the file path
  String filePath = 'output.csv';

  // Write the CSV string to the file
  File file = File(filePath);
  file.writeAsString(csvData.toString()).then((_) {
    print('CSV file saved at $filePath');
  }).catchError((error) {
    print('Failed to save CSV file: $error');
  });

  print("Script Complete");
}
