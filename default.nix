self: super:

{
  bundlewrap = super.callPackage ./bundlewrap {};
  sp-flash-tool = super.callPackage ./sp-flash-tool {};
  terraform = super.terraform.overrideAttrs (old: {
    passthru.plugins = old.passthru.plugins // {
      terranix = super.callPackage ./terranix {};
    };
  });
}
