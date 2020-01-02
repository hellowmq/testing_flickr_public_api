class WeatherBean {
  int error;
  String status;
  String date;
  List<Results> results;

  WeatherBean({this.error, this.status, this.date, this.results});

  WeatherBean.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    date = json['date'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status'] = this.status;
    data['date'] = this.date;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'WeatherBean{results: $results}';
  }
}

class Results {
  String currentCity;
  String pm25;
  List<Index> index;
  List<WeatherData> weatherData;

  Results({this.currentCity, this.pm25, this.index, this.weatherData});

  Results.fromJson(Map<String, dynamic> json) {
    currentCity = json['currentCity'];
    pm25 = json['pm25'];
    if (json['index'] != null) {
      index = new List<Index>();
      json['index'].forEach((v) {
        index.add(new Index.fromJson(v));
      });
    }
    if (json['weather_data'] != null) {
      weatherData = new List<WeatherData>();
      json['weather_data'].forEach((v) {
        weatherData.add(new WeatherData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentCity'] = this.currentCity;
    data['pm25'] = this.pm25;
    if (this.index != null) {
      data['index'] = this.index.map((v) => v.toJson()).toList();
    }
    if (this.weatherData != null) {
      data['weather_data'] = this.weatherData.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Results{currentCity: $currentCity, pm25: $pm25, index: $index, weatherData: $weatherData}';
  }
}

class Index {
  String des;
  String tipt;
  String title;
  String zs;

  Index({this.des, this.tipt, this.title, this.zs});

  Index.fromJson(Map<String, dynamic> json) {
    des = json['des'];
    tipt = json['tipt'];
    title = json['title'];
    zs = json['zs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['des'] = this.des;
    data['tipt'] = this.tipt;
    data['title'] = this.title;
    data['zs'] = this.zs;
    return data;
  }

  @override
  String toString() {
    return 'Index{des: $des, tipt: $tipt, title: $title, zs: $zs}';
  }
}

class WeatherData {
  String date;
  String dayPictureUrl;
  String nightPictureUrl;
  String weather;
  String wind;
  String temperature;

  WeatherData(
      {this.date,
      this.dayPictureUrl,
      this.nightPictureUrl,
      this.weather,
      this.wind,
      this.temperature});

  WeatherData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dayPictureUrl = json['dayPictureUrl'];
    nightPictureUrl = json['nightPictureUrl'];
    weather = json['weather'];
    wind = json['wind'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['dayPictureUrl'] = this.dayPictureUrl;
    data['nightPictureUrl'] = this.nightPictureUrl;
    data['weather'] = this.weather;
    data['wind'] = this.wind;
    data['temperature'] = this.temperature;
    return data;
  }

  @override
  String toString() {
    return 'WeatherData{date: $date, dayPictureUrl: $dayPictureUrl, nightPictureUrl: $nightPictureUrl, weather: $weather, wind: $wind, temperature: $temperature}';
  }
}
