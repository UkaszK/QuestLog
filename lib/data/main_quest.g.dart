// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_quest.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMainQuestCollection on Isar {
  IsarCollection<MainQuest> get mainQuests => this.collection();
}

const MainQuestSchema = CollectionSchema(
  name: r'MainQuest',
  id: 2983301218365953035,
  properties: {
    r'dueDate': PropertySchema(
      id: 0,
      name: r'dueDate',
      type: IsarType.dateTime,
    ),
    r'dueText': PropertySchema(
      id: 1,
      name: r'dueText',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'priority': PropertySchema(
      id: 3,
      name: r'priority',
      type: IsarType.byte,
      enumMap: _MainQuestpriorityEnumValueMap,
    ),
    r'questCategoryName': PropertySchema(
      id: 4,
      name: r'questCategoryName',
      type: IsarType.string,
    ),
    r'subTasks': PropertySchema(
      id: 5,
      name: r'subTasks',
      type: IsarType.stringList,
    )
  },
  estimateSize: _mainQuestEstimateSize,
  serialize: _mainQuestSerialize,
  deserialize: _mainQuestDeserialize,
  deserializeProp: _mainQuestDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _mainQuestGetId,
  getLinks: _mainQuestGetLinks,
  attach: _mainQuestAttach,
  version: '3.1.0+1',
);

int _mainQuestEstimateSize(
  MainQuest object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dueText.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.questCategoryName.length * 3;
  bytesCount += 3 + object.subTasks.length * 3;
  {
    for (var i = 0; i < object.subTasks.length; i++) {
      final value = object.subTasks[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _mainQuestSerialize(
  MainQuest object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dueDate);
  writer.writeString(offsets[1], object.dueText);
  writer.writeString(offsets[2], object.name);
  writer.writeByte(offsets[3], object.priority.index);
  writer.writeString(offsets[4], object.questCategoryName);
  writer.writeStringList(offsets[5], object.subTasks);
}

MainQuest _mainQuestDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MainQuest(
    dueDate: reader.readDateTimeOrNull(offsets[0]),
    name: reader.readString(offsets[2]),
    priority:
        _MainQuestpriorityValueEnumMap[reader.readByteOrNull(offsets[3])] ??
            QuestPriority.low,
    questCategoryName: reader.readString(offsets[4]),
    subTasks: reader.readStringList(offsets[5]) ?? [],
  );
  object.id = id;
  return object;
}

P _mainQuestDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (_MainQuestpriorityValueEnumMap[reader.readByteOrNull(offset)] ??
          QuestPriority.low) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MainQuestpriorityEnumValueMap = {
  'low': 0,
  'normal': 1,
  'high': 2,
};
const _MainQuestpriorityValueEnumMap = {
  0: QuestPriority.low,
  1: QuestPriority.normal,
  2: QuestPriority.high,
};

Id _mainQuestGetId(MainQuest object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mainQuestGetLinks(MainQuest object) {
  return [];
}

void _mainQuestAttach(IsarCollection<dynamic> col, Id id, MainQuest object) {
  object.id = id;
}

extension MainQuestQueryWhereSort
    on QueryBuilder<MainQuest, MainQuest, QWhere> {
  QueryBuilder<MainQuest, MainQuest, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MainQuestQueryWhere
    on QueryBuilder<MainQuest, MainQuest, QWhereClause> {
  QueryBuilder<MainQuest, MainQuest, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<MainQuest, MainQuest, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterWhereClause> idBetween(
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

extension MainQuestQueryFilter
    on QueryBuilder<MainQuest, MainQuest, QFilterCondition> {
  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dueDate',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dueText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dueText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueTextContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dueText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueTextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dueText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> dueTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueText',
        value: '',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      dueTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dueText',
        value: '',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameContains(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> priorityEqualTo(
      QuestPriority value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> priorityGreaterThan(
    QuestPriority value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> priorityLessThan(
    QuestPriority value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priority',
        value: value,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> priorityBetween(
    QuestPriority lower,
    QuestPriority upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
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

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      questCategoryNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questCategoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      questCategoryNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questCategoryName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      questCategoryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questCategoryName',
        value: '',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      questCategoryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questCategoryName',
        value: '',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subTasks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subTasks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subTasks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subTasks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subTasks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subTasks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subTasks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subTasks',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subTasks',
        value: '',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subTasks',
        value: '',
      ));
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition> subTasksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterFilterCondition>
      subTasksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subTasks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension MainQuestQueryObject
    on QueryBuilder<MainQuest, MainQuest, QFilterCondition> {}

extension MainQuestQueryLinks
    on QueryBuilder<MainQuest, MainQuest, QFilterCondition> {}

extension MainQuestQuerySortBy on QueryBuilder<MainQuest, MainQuest, QSortBy> {
  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> sortByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> sortByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> sortByDueText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueText', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> sortByDueTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueText', Sort.desc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> sortByQuestCategoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questCategoryName', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy>
      sortByQuestCategoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questCategoryName', Sort.desc);
    });
  }
}

extension MainQuestQuerySortThenBy
    on QueryBuilder<MainQuest, MainQuest, QSortThenBy> {
  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByDueText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueText', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByDueTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueText', Sort.desc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy> thenByQuestCategoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questCategoryName', Sort.asc);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QAfterSortBy>
      thenByQuestCategoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questCategoryName', Sort.desc);
    });
  }
}

extension MainQuestQueryWhereDistinct
    on QueryBuilder<MainQuest, MainQuest, QDistinct> {
  QueryBuilder<MainQuest, MainQuest, QDistinct> distinctByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueDate');
    });
  }

  QueryBuilder<MainQuest, MainQuest, QDistinct> distinctByDueText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QDistinct> distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<MainQuest, MainQuest, QDistinct> distinctByQuestCategoryName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questCategoryName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MainQuest, MainQuest, QDistinct> distinctBySubTasks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subTasks');
    });
  }
}

extension MainQuestQueryProperty
    on QueryBuilder<MainQuest, MainQuest, QQueryProperty> {
  QueryBuilder<MainQuest, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MainQuest, DateTime?, QQueryOperations> dueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueDate');
    });
  }

  QueryBuilder<MainQuest, String, QQueryOperations> dueTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueText');
    });
  }

  QueryBuilder<MainQuest, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<MainQuest, QuestPriority, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<MainQuest, String, QQueryOperations>
      questCategoryNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questCategoryName');
    });
  }

  QueryBuilder<MainQuest, List<String>, QQueryOperations> subTasksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subTasks');
    });
  }
}
