self: super: {
  iosevka-term = super.iosevka.override {
    set = "term";
    privateBuildPlan = {
      family = "Iosevka Term";
      design = [
        "term" "v-l-italic" "v-i-italic" "v-g-singlestorey"
        "v-asterisk-high" "v-at-long" "v-brace-straight"
      ];
    };
  };
}
