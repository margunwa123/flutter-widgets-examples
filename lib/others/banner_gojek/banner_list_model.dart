// class CtaButton {
//   final String title;
//   final String deeplink;
//   final String? imageUrl;

//   const CtaButton({
//     required this.title,
//     required this.deeplink,
//     this.imageUrl,
//   });
// }

// class OrganismType {}

// class BannerListItem {
//   // gopay.sdui.types.OrganismType type = 1 [(validate.rules).enum.const = 47];
//   // gopay.sdui.molecules.Text title = 2 [(validate.rules).any.required = true];
//   // gopay.sdui.molecules.Text subtitle = 3;
//   // gopay.sdui.molecules.TextButton textButton = 4;
//   // gopay.sdui.molecules.CTAWithIconButton ctaWithIconButton = 5;
//   // string icon_name = 6 [(validate.rules).string = {ignore_empty: false, min_len: 1}];
//   // string deeplink = 7;
//   // gopay.sdui.events.ClickEvent click_event = 8;
//   // gopay.sdui.events.ViewEvent view_event = 9;

//   final OrganismType type;
//   final String title;
//   final String? subtitle;
//   final TextButton? textButton;
//   final String iconUrl;
//   final CtaButton ctaButton;

//   BannerListItem({
//     required this.iconUrl,
//     required this.title,
//     this.subtitle,
//     required this.ctaButton,
//   });
// }

// class BannerList {}
