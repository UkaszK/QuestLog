// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_info.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuestInfoSchema = Schema(
  name: r'QuestInfo',
  id: 6158967784012604539,
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
    r'subTasks': PropertySchema(
      id: 2,
      name: r'subTasks',
      type: IsarType.objectList,
      target: r'SubTask',
    )
  },
  estimateSize: _questInfoEstimateSize,
  serialize: _questInfoSerialize,
  deserialize: _questInfoDeserialize,
  deserializeProp: _questInfoDeserializeProp,
);

int _questInfoEstimateSize(
  QuestInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.questCategoryName.length * 3;
  bytesCount += 3 + object.subTasks.length * 3;
  {
    final offsets = allOffsets[SubTask]!;
    for (var i = 0; i < object.subTasks.length; i++) {
      final value = object.subTasks[i];
      bytesCount += SubTaskSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _questInfoSerialize(
  QuestInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeString(offsets[1], object.questCategoryName);
  writer.writeObjectList<SubTask>(
    offsets[2],
    allOffsets,
    SubTaskSchema.serialize,
    object.subTasks,
  );
}

QuestInfo _questInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestInfo(
    name: reader.readStringOrNull(offsets[0]) ?? '',
    questCategoryName: reader.readStringOrNull(offsets[1]) ?? '',
    subTasks: reader.readObjectList<SubTask>(
          offsets[2],
          SubTaskSchema.deserialize,
          allOffsets,
          SubTask(),
        ) ??
        const [],
  );
  return object;
}

P _questInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readObjectList<SubTask>(
            offset,
            SubTaskSchema.deserialize,
            allOffsets,
            SubTask(),
          ) ??
          const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension QuestInfoQueryFilter
    on QueryBuilder<QuestInfo, QuestInfo, QFilterCondition> {
  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameContains(
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
      questCategoryNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questCategoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
      questCategoryNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questCategoryName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
      questCategoryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questCategoryName',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
      questCategoryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questCategoryName',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> subTasksIsEmpty() {
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition>
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

extension QuestInfoQueryObject
    on QueryBuilder<QuestInfo, QuestInfo, QFilterCondition> {
  QueryBuilder<QuestInfo, QuestInfo, QAfterFilterCondition> subTasksElement(
      FilterQuery<SubTask> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'subTasks');
    });
  }
}
