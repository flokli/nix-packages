self: super:

{
  bundlewrap = super.callPackage ./bundlewrap {};
  sp-flash-tool = super.callPackage ./sp-flash-tool {};
}
