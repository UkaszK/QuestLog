// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'side_quest.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSideQuestCollection on Isar {
  IsarCollection<SideQuest> get sideQuests => this.collection();
}

const SideQuestSchema = CollectionSchema(
  name: r'SideQuest',
  id: 9188474040182079828,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'questCategoryName': PropertySchema(
      id: 1,
      name: r'questCategoryName',
      type: IsarType.string,
    ),
    r'repeatDaysList': PropertySchema(
      id: 2,
      name: r'repeatDaysList',
      type: IsarType.byteList,
      enumMap: _SideQuestrepeatDaysListEnumValueMap,
    )
  },
  estimateSize: _sideQuestEstimateSize,
  serialize: _sideQuestSerialize,
  deserialize: _sideQuestDeserialize,
  deserializeProp: _sideQuestDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _sideQuestGetId,
  getLinks: _sideQuestGetLinks,
  attach: _sideQuestAttach,
  version: '3.1.0+1',
);

int _sideQuestEstimateSize(
  SideQuest object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.questCategoryName.length * 3;
  bytesCount += 3 + object.repeatDaysList.length;
  return bytesCount;
}

void _sideQuestSerialize(
  SideQuest object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeString(offsets[1], object.questCategoryName);
  writer.writeByteList(
      offsets[2], object.repeatDaysList.map((e) => e.index).toList());
}

SideQuest _sideQuestDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SideQuest(
    name: reader.readString(offsets[0]),
    questCategoryName: reader.readString(offsets[1]),
    repeatDaysList: reader
            .readByteList(offsets[2])
            ?.map((e) => _SideQuestrepeatDaysListValueEnumMap[e] ?? Day.monday)
            .toList() ??
        [],
  );
  object.id = id;
  return object;
}

P _sideQuestDeserializeProp<P>(
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
    case 2:
      return (reader
              .readByteList(offset)
              ?.map(
                  (e) => _SideQuestrepeatDaysListValueEnumMap[e] ?? Day.monday)
              .toList() ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SideQuestrepeatDaysListEnumValueMap = {
  'monday': 0,
  'tuesday': 1,
  'wednesday': 2,
  'thursday': 3,
  'friday': 4,
  'saturday': 5,
  'sunday': 6,
};
const _SideQuestrepeatDaysListValueEnumMap = {
  0: Day.monday,
  1: Day.tuesday,
  2: Day.wednesday,
  3: Day.thursday,
  4: Day.friday,
  5: Day.saturday,
  6: Day.sunday,
};

Id _sideQuestGetId(SideQuest object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sideQuestGetLinks(SideQuest object) {
  return [];
}

void _sideQuestAttach(IsarCollection<dynamic> col, Id id, SideQuest object) {
  object.id = id;
}

extension SideQuestQueryWhereSort
    on QueryBuilder<SideQuest, SideQuest, QWhere> {
  QueryBuilder<SideQuest, SideQuest, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SideQuestQueryWhere
    on QueryBuilder<SideQuest, SideQuest, QWhereClause> {
  QueryBuilder<SideQuest, SideQuest, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<SideQuest, SideQuest, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterWhereClause> idBetween(
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

extension SideQuestQueryFilter
    on QueryBuilder<SideQuest, SideQuest, QFilterCondition> {
  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questCategoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questCategoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questCategoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questCategoryName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questCategoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questCategoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questCategoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questCategoryName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questCategoryName',
        value: '',
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      questCategoryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questCategoryName',
        value: '',
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListElementEqualTo(Day value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatDaysList',
        value: value,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListElementGreaterThan(
    Day value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatDaysList',
        value: value,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListElementLessThan(
    Day value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatDaysList',
        value: value,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListElementBetween(
    Day lower,
    Day upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatDaysList',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDaysList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDaysList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDaysList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDaysList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDaysList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterFilterCondition>
      repeatDaysListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDaysList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SideQuestQueryObject
    on QueryBuilder<SideQuest, SideQuest, QFilterCondition> {}

extension SideQuestQueryLinks
    on QueryBuilder<SideQuest, SideQuest, QFilterCondition> {}

extension SideQuestQuerySortBy on QueryBuilder<SideQuest, SideQuest, QSortBy> {
  QueryBuilder<SideQuest, SideQuest, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterSortBy> sortByQuestCategoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questCategoryName', Sort.asc);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterSortBy>
      sortByQuestCategoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questCategoryName', Sort.desc);
    });
  }
}

extension SideQuestQuerySortThenBy
    on QueryBuilder<SideQuest, SideQuest, QSortThenBy> {
  QueryBuilder<SideQuest, SideQuest, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterSortBy> thenByQuestCategoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questCategoryName', Sort.asc);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QAfterSortBy>
      thenByQuestCategoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questCategoryName', Sort.desc);
    });
  }
}

extension SideQuestQueryWhereDistinct
    on QueryBuilder<SideQuest, SideQuest, QDistinct> {
  QueryBuilder<SideQuest, SideQuest, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QDistinct> distinctByQuestCategoryName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questCategoryName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SideQuest, SideQuest, QDistinct> distinctByRepeatDaysList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatDaysList');
    });
  }
}

extension SideQuestQueryProperty
    on QueryBuilder<SideQuest, SideQuest, QQueryProperty> {
  QueryBuilder<SideQuest, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SideQuest, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SideQuest, String, QQueryOperations>
      questCategoryNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questCategoryName');
    });
  }

  QueryBuilder<SideQuest, List<Day>, QQueryOperations>
      repeatDaysListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatDaysList');
    });
  }
}
