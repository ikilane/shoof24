class CategoryModel {
  final String? categoryId;
  final String? categoryName;
  final String? parentId;

  CategoryModel({
    this.categoryId,
    this.categoryName,
    this.parentId,
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
      : categoryId = json['category_id'].toString(),
        categoryName = json['category_name'].toString(),
        parentId = json['parent_id'].toString();

  Map<String, dynamic> toJson() => {
        'category_id': categoryId,
        'category_name': categoryName,
        'parent_id': parentId,
      };
}


class ChannelLive {
  final String? num;
  final String? name;
  final String? streamType;
  final String? streamId;
  final String? streamIcon;
  final String? epgChannelId;
  final String? added;
  final String? categoryId;
  final String? customSid;
  final int? tvArchive;
  final String? directSource;
  final int? tvArchiveDuration;
  final String? ext;

  const ChannelLive({
    this.num,
    this.name,
    this.streamType,
    this.streamId,
    this.streamIcon,
    this.epgChannelId,
    this.added,
    this.categoryId,
    this.customSid,
    this.tvArchive,
    this.directSource,
    this.tvArchiveDuration,
    this.ext,
  });

  ChannelLive.fromJson(Map<String, dynamic> json)
      : num = json['num'].toString(),
        name = json['name'].toString(),
        streamType = json['stream_type'].toString(),
        streamId = json['stream_id'].toString(),
        streamIcon = json['stream_icon'].toString(),
        epgChannelId = json['epg_channel_id'], // Nullable string
        added = json['added'].toString(),
        categoryId = json['category_id'].toString(),
        customSid = json['custom_sid'].toString(),
        tvArchive = json['tv_archive'] as int?,
        directSource = json['direct_source'].toString(),
        tvArchiveDuration = json['tv_archive_duration'] as int?,
        ext = json['ext'].toString();

  Map<String, dynamic> toJson() => {
        'num': num,
        'name': name,
        'stream_type': streamType,
        'stream_id': streamId,
        'stream_icon': streamIcon,
        'epg_channel_id': epgChannelId,
        'added': added,
        'category_id': categoryId,
        'custom_sid': customSid,
        'tv_archive': tvArchive,
        'direct_source': directSource,
        'tv_archive_duration': tvArchiveDuration,
        'ext': ext,
      };
}

class ChannelMovie {
  final String? num;
  final String? name;
  final String? streamType;
  final String? streamId;
  final String? streamIcon;
  final String? rating;
  final String? rating5based;
  final String? added;
  final String? isAdult;
  final String? categoryId;
  final String? containerExtension;
  final String? customSid;
  final String? directSource;

  ChannelMovie({
    this.num,
    this.name,
    this.streamType,
    this.streamId,
    this.streamIcon,
    this.rating,
    this.rating5based,
    this.added,
    this.isAdult,
    this.categoryId,
    this.containerExtension,
    this.customSid,
    this.directSource,
  });

  ChannelMovie.fromJson(Map<String, dynamic> json)
      : num = json['num'] == null ? null : json['num'].toString(),
        name = json['name'] == null ? null : json['name'].toString(),
        streamType =
            json['stream_type'] == null ? null : json['stream_type'].toString(),
        streamId =
            json['stream_id'] == null ? null : json['stream_id'].toString(),
        streamIcon =
            json['stream_icon'] == null ? null : json['stream_icon'].toString(),
        rating = json['rating'] == null ? null : json['rating'].toString(),
        rating5based = json['rating_5based'] == null
            ? null
            : json['rating_5based'].toString(),
        added = json['added'] == null ? null : json['added'].toString(),
        isAdult = json['is_adult'] == null ? null : json['is_adult'].toString(),
        categoryId =
            json['category_id'] == null ? null : json['category_id'].toString(),
        containerExtension = json['container_extension'] == null
            ? null
            : json['container_extension'].toString(),
        customSid =
            json['custom_sid'] == null ? null : json['custom_sid'].toString(),
        directSource = json['direct_source'] == null
            ? null
            : json['direct_source'].toString();

  Map<String, dynamic> toJson() => {
        'num': num,
        'name': name,
        'stream_type': streamType,
        'stream_id': streamId,
        'stream_icon': streamIcon,
        'rating': rating,
        'rating_5based': rating5based,
        'added': added,
        'is_adult': isAdult,
        'category_id': categoryId,
        'container_extension': containerExtension,
        'custom_sid': customSid,
        'direct_source': directSource
      };
}

class ChannelSerie {
  final String? num;
  final String? name;
  final String? seriesId;
  final String? cover;
  final String? plot;

  final String? rating;
  final String? rating5based;

  final String? categoryId;

  ChannelSerie({
    this.num,
    this.name,
    this.seriesId,
    this.cover,
    this.plot,
    this.rating,
    this.rating5based,
    this.categoryId,
  });

  ChannelSerie.fromJson(Map<String, dynamic> json)
      : num = json['num'].toString(),
        name = json['name'].toString(),
        seriesId = json['series_id'].toString(),
        cover = json['cover'].toString(),
        plot = json['plot'].toString(),
        rating = json['rating'].toString(),
        rating5based = json['rating_5based'].toString(),
        categoryId = json['category_id'].toString();

  Map<String, dynamic> toJson() => {
        'num': num,
        'name': name,
        'series_id': seriesId,
        'cover': cover,
        'plot': plot,
        'rating': rating,
        'rating_5based': rating5based,
        'category_id': categoryId
      };
}
