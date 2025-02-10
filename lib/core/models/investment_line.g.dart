// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_line.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInvestmentLineCollection on Isar {
  IsarCollection<InvestmentLine> get investmentLines => this.collection();
}

const InvestmentLineSchema = CollectionSchema(
  name: r'InvestmentLine',
  id: -2834899735236285265,
  properties: {
    r'monthlyAmount': PropertySchema(
      id: 0,
      name: r'monthlyAmount',
      type: IsarType.double,
    ),
    r'quantity': PropertySchema(
      id: 1,
      name: r'quantity',
      type: IsarType.double,
    )
  },
  estimateSize: _investmentLineEstimateSize,
  serialize: _investmentLineSerialize,
  deserialize: _investmentLineDeserialize,
  deserializeProp: _investmentLineDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'asset': LinkSchema(
      id: -7875869314774960707,
      name: r'asset',
      target: r'Asset',
      single: true,
    ),
    r'category': LinkSchema(
      id: -7641182345263987438,
      name: r'category',
      target: r'Category',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _investmentLineGetId,
  getLinks: _investmentLineGetLinks,
  attach: _investmentLineAttach,
  version: '3.1.8',
);

int _investmentLineEstimateSize(
  InvestmentLine object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _investmentLineSerialize(
  InvestmentLine object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.monthlyAmount);
  writer.writeDouble(offsets[1], object.quantity);
}

InvestmentLine _investmentLineDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InvestmentLine(
    monthlyAmount: reader.readDouble(offsets[0]),
    quantity: reader.readDouble(offsets[1]),
  );
  object.id = id;
  return object;
}

P _investmentLineDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _investmentLineGetId(InvestmentLine object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _investmentLineGetLinks(InvestmentLine object) {
  return [object.asset, object.category];
}

void _investmentLineAttach(
    IsarCollection<dynamic> col, Id id, InvestmentLine object) {
  object.id = id;
  object.asset.attach(col, col.isar.collection<Asset>(), r'asset', id);
  object.category.attach(col, col.isar.collection<Category>(), r'category', id);
}

extension InvestmentLineQueryWhereSort
    on QueryBuilder<InvestmentLine, InvestmentLine, QWhere> {
  QueryBuilder<InvestmentLine, InvestmentLine, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InvestmentLineQueryWhere
    on QueryBuilder<InvestmentLine, InvestmentLine, QWhereClause> {
  QueryBuilder<InvestmentLine, InvestmentLine, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterWhereClause> idBetween(
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

extension InvestmentLineQueryFilter
    on QueryBuilder<InvestmentLine, InvestmentLine, QFilterCondition> {
  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
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

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
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

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition> idBetween(
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

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      monthlyAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthlyAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      monthlyAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monthlyAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      monthlyAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monthlyAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      monthlyAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monthlyAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension InvestmentLineQueryObject
    on QueryBuilder<InvestmentLine, InvestmentLine, QFilterCondition> {}

extension InvestmentLineQueryLinks
    on QueryBuilder<InvestmentLine, InvestmentLine, QFilterCondition> {
  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition> asset(
      FilterQuery<Asset> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'asset');
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      assetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'asset', 0, true, 0, true);
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition> category(
      FilterQuery<Category> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'category');
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'category', 0, true, 0, true);
    });
  }
}

extension InvestmentLineQuerySortBy
    on QueryBuilder<InvestmentLine, InvestmentLine, QSortBy> {
  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy>
      sortByMonthlyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyAmount', Sort.asc);
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy>
      sortByMonthlyAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyAmount', Sort.desc);
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension InvestmentLineQuerySortThenBy
    on QueryBuilder<InvestmentLine, InvestmentLine, QSortThenBy> {
  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy>
      thenByMonthlyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyAmount', Sort.asc);
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy>
      thenByMonthlyAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthlyAmount', Sort.desc);
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }
}

extension InvestmentLineQueryWhereDistinct
    on QueryBuilder<InvestmentLine, InvestmentLine, QDistinct> {
  QueryBuilder<InvestmentLine, InvestmentLine, QDistinct>
      distinctByMonthlyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthlyAmount');
    });
  }

  QueryBuilder<InvestmentLine, InvestmentLine, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }
}

extension InvestmentLineQueryProperty
    on QueryBuilder<InvestmentLine, InvestmentLine, QQueryProperty> {
  QueryBuilder<InvestmentLine, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InvestmentLine, double, QQueryOperations>
      monthlyAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthlyAmount');
    });
  }

  QueryBuilder<InvestmentLine, double, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }
}
