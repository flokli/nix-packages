self: super:

{
  bundlewrap = super.callPackage ./bundlewrap {};
  sp-flash-tool = super.callPackage ./sp-flash-tool {};
  terraform = super.terraform.overrideAttrs (old: {
    passthru.plugins = old.passthru.plugins // {
      terranix = super.callPackage ./terranix {};
    };
  });
  latex-tuddesign = super.callPackage ./latex-tuddesign {};
  latex-tuddesign-fonts = super.callPackage ./latex-tuddesign-fonts {};
  latex-tuddesign-thesis = super.callPackage ./latex-tuddesign-thesis {};
}
