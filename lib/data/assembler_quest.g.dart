// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assembler_quest.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAssemblerQuestCollection on Isar {
  IsarCollection<AssemblerQuest> get assemblerQuests => this.collection();
}

const AssemblerQuestSchema = CollectionSchema(
  name: r'AssemblerQuest',
  id: 6765939510980737925,
  properties: {
    r'endTime': PropertySchema(
      id: 0,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'questInfo': PropertySchema(
      id: 1,
      name: r'questInfo',
      type: IsarType.object,
      target: r'QuestInfo',
    ),
    r'startTime': PropertySchema(
      id: 2,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 3,
      name: r'status',
      type: IsarType.byte,
      enumMap: _AssemblerQueststatusEnumValueMap,
    )
  },
  estimateSize: _assemblerQuestEstimateSize,
  serialize: _assemblerQuestSerialize,
  deserialize: _assemblerQuestDeserialize,
  deserializeProp: _assemblerQuestDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'QuestInfo': QuestInfoSchema, r'SubTask': SubTaskSchema},
  getId: _assemblerQuestGetId,
  getLinks: _assemblerQuestGetLinks,
  attach: _assemblerQuestAttach,
  version: '3.1.0+1',
);

int _assemblerQuestEstimateSize(
  AssemblerQuest object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      QuestInfoSchema.estimateSize(
          object.questInfo, allOffsets[QuestInfo]!, allOffsets);
  return bytesCount;
}

void _assemblerQuestSerialize(
  AssemblerQuest object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.endTime);
  writer.writeObject<QuestInfo>(
    offsets[1],
    allOffsets,
    QuestInfoSchema.serialize,
    object.questInfo,
  );
  writer.writeDateTime(offsets[2], object.startTime);
  writer.writeByte(offsets[3], object.status.index);
}

AssemblerQuest _assemblerQuestDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AssemblerQuest(
    endTime: reader.readDateTime(offsets[0]),
    questInfo: reader.readObjectOrNull<QuestInfo>(
          offsets[1],
          QuestInfoSchema.deserialize,
          allOffsets,
        ) ??
        QuestInfo(),
    startTime: reader.readDateTime(offsets[2]),
    status:
        _AssemblerQueststatusValueEnumMap[reader.readByteOrNull(offsets[3])] ??
            QuestStatus.open,
  );
  object.id = id;
  return object;
}

P _assemblerQuestDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<QuestInfo>(
            offset,
            QuestInfoSchema.deserialize,
            allOffsets,
          ) ??
          QuestInfo()) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (_AssemblerQueststatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          QuestStatus.open) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AssemblerQueststatusEnumValueMap = {
  'open': 0,
  'completed': 1,
  'active': 2,
  'pending': 3,
};
const _AssemblerQueststatusValueEnumMap = {
  0: QuestStatus.open,
  1: QuestStatus.completed,
  2: QuestStatus.active,
  3: QuestStatus.pending,
};

Id _assemblerQuestGetId(AssemblerQuest object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _assemblerQuestGetLinks(AssemblerQuest object) {
  return [];
}

void _assemblerQuestAttach(
    IsarCollection<dynamic> col, Id id, AssemblerQuest object) {
  object.id = id;
}

extension AssemblerQuestQueryWhereSort
    on QueryBuilder<AssemblerQuest, AssemblerQuest, QWhere> {
  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AssemblerQuestQueryWhere
    on QueryBuilder<AssemblerQuest, AssemblerQuest, QWhereClause> {
  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterWhereClause> idBetween(
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

extension AssemblerQuestQueryFilter
    on QueryBuilder<AssemblerQuest, AssemblerQuest, QFilterCondition> {
  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      endTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      endTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      endTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      endTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
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

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
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

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition> idBetween(
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

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      startTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      startTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      startTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      statusEqualTo(QuestStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      statusGreaterThan(
    QuestStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      statusLessThan(
    QuestStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition>
      statusBetween(
    QuestStatus lower,
    QuestStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AssemblerQuestQueryObject
    on QueryBuilder<AssemblerQuest, AssemblerQuest, QFilterCondition> {
  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterFilterCondition> questInfo(
      FilterQuery<QuestInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'questInfo');
    });
  }
}

extension AssemblerQuestQueryLinks
    on QueryBuilder<AssemblerQuest, AssemblerQuest, QFilterCondition> {}

extension AssemblerQuestQuerySortBy
    on QueryBuilder<AssemblerQuest, AssemblerQuest, QSortBy> {
  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy>
      sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy>
      sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension AssemblerQuestQuerySortThenBy
    on QueryBuilder<AssemblerQuest, AssemblerQuest, QSortThenBy> {
  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy>
      thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy>
      thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension AssemblerQuestQueryWhereDistinct
    on QueryBuilder<AssemblerQuest, AssemblerQuest, QDistinct> {
  QueryBuilder<AssemblerQuest, AssemblerQuest, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QDistinct>
      distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<AssemblerQuest, AssemblerQuest, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension AssemblerQuestQueryProperty
    on QueryBuilder<AssemblerQuest, AssemblerQuest, QQueryProperty> {
  QueryBuilder<AssemblerQuest, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AssemblerQuest, DateTime, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<AssemblerQuest, QuestInfo, QQueryOperations>
      questInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questInfo');
    });
  }

  QueryBuilder<AssemblerQuest, DateTime, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<AssemblerQuest, QuestStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
