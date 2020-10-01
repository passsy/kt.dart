class DefaultArgument {
  const DefaultArgument._();
}

/// Default value for 'vararg' constructors to distinguish between null and no value
///
/// See KtList.of(...), KtSet.of(...), listOf(...), ...
const DefaultArgument defaultArgument = DefaultArgument._();
