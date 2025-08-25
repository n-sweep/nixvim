{ ... }: {

  plugins.qmk = {
    enable = true;
    settings = {
      name = "adv360pro";
      layout = [
        "x x x x x x x _ _ _ _ _ _ _ x x x x x x x"
        "x x x x x x x _ _ _ _ _ _ _ x x x x x x x"
        "x x x x x x x _ x x _ x x _ x x x x x x x"
        "x x x x x x _ _ _ x _ x _ _ _ x x x x x x"
        "x x x x x _ _ x x x _ x x x _ _ x x x x x"
      ];
      variant = "zmk";
    };
  };


}
