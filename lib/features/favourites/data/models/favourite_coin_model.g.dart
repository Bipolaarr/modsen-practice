// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_coin_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavouriteCoinModelCollection on Isar {
  IsarCollection<FavouriteCoinModel> get favouriteCoinModels =>
      this.collection();
}

const FavouriteCoinModelSchema = CollectionSchema(
  name: r'FavouriteCoinModel',
  id: -5746215873428194139,
  properties: {
    r'coinId': PropertySchema(
      id: 0,
      name: r'coinId',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 1,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _favouriteCoinModelEstimateSize,
  serialize: _favouriteCoinModelSerialize,
  deserialize: _favouriteCoinModelDeserialize,
  deserializeProp: _favouriteCoinModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _favouriteCoinModelGetId,
  getLinks: _favouriteCoinModelGetLinks,
  attach: _favouriteCoinModelAttach,
  version: '3.1.0+1',
);

int _favouriteCoinModelEstimateSize(
  FavouriteCoinModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.coinId.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _favouriteCoinModelSerialize(
  FavouriteCoinModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.coinId);
  writer.writeString(offsets[1], object.userId);
}

FavouriteCoinModel _favouriteCoinModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavouriteCoinModel(
    coinId: reader.readString(offsets[0]),
    userId: reader.readString(offsets[1]),
  );
  object.id = id;
  return object;
}

P _favouriteCoinModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favouriteCoinModelGetId(FavouriteCoinModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favouriteCoinModelGetLinks(
    FavouriteCoinModel object) {
  return [];
}

void _favouriteCoinModelAttach(
    IsarCollection<dynamic> col, Id id, FavouriteCoinModel object) {
  object.id = id;
}

extension FavouriteCoinModelQueryWhereSort
    on QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QWhere> {
  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FavouriteCoinModelQueryWhere
    on QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QWhereClause> {
  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavouriteCoinModelQueryFilter
    on QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QFilterCondition> {
  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coinId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'coinId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'coinId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'coinId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'coinId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'coinId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'coinId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'coinId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'coinId',
        value: '',
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      coinIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'coinId',
        value: '',
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension FavouriteCoinModelQueryObject
    on QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QFilterCondition> {}

extension FavouriteCoinModelQueryLinks
    on QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QFilterCondition> {}

extension FavouriteCoinModelQuerySortBy
    on QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QSortBy> {
  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      sortByCoinId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coinId', Sort.asc);
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      sortByCoinIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coinId', Sort.desc);
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension FavouriteCoinModelQuerySortThenBy
    on QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QSortThenBy> {
  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      thenByCoinId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coinId', Sort.asc);
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      thenByCoinIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'coinId', Sort.desc);
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension FavouriteCoinModelQueryWhereDistinct
    on QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QDistinct> {
  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QDistinct>
      distinctByCoinId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'coinId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension FavouriteCoinModelQueryProperty
    on QueryBuilder<FavouriteCoinModel, FavouriteCoinModel, QQueryProperty> {
  QueryBuilder<FavouriteCoinModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FavouriteCoinModel, String, QQueryOperations> coinIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coinId');
    });
  }

  QueryBuilder<FavouriteCoinModel, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
