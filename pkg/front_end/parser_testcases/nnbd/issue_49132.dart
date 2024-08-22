class Foo {
  Foo.foo1(dynamic a, dynamic b)
      : x = a as int,
        y = b as int?;

  Foo.foo2(dynamic a, dynamic b)
      : x = a is int,
        y = b is int?;

  Foo.foo3(dynamic a, dynamic b)
      : x = a as int?,
        y = b as int;

  Foo.foo4(dynamic a, dynamic b)
      : x = a is int?,
        y = b is int;

  Foo.bar1(dynamic a, dynamic b)
      : x = a as int,
        y = b as int? {}

  Foo.bar2(dynamic a, dynamic b)
      : x = a is int,
        y = b is int? {}

  Foo.bar3(dynamic a, dynamic b)
      : x = a as int?,
        y = b as int {}

  Foo.bar4(dynamic a, dynamic b)
      : x = a is int?,
        y = b is int {}
}
