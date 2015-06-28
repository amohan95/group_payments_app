$(document).ready(function() {
  var el = new UserCard("Ananth Mohan", "./../img/ananth-profile.jpg", 500);
  $("#user-page").append(el);
  $("#user-page").append(new UserCard("Bananth Bmohan", "./../img/ananth-profile.jpg", 25));

  $("#group-page").append(new GroupCard("Stupidest Group", "./../img/ananth-profile.jpg",
                                        50, 500, ["Bananthus", "Binuantoiwe", "Hitler", "AlsoAnanth",
                                        "NotAnantyh"]));
});