$(document).ready(function() { 

  $(".backToGroupHome").click(function() {
    var pages = document.querySelector('iron-pages');
      pages.select(0);
  });

  $(".backToGroupListEvents").click(function() {
    var pages = document.querySelector('iron-pages');
      pages.select(2);
  });

  $(".backToGroupListEvents").click(function() {
    var pages = document.querySelector('iron-pages');
      pages.select(1);
  });

});

$(document).on('fb-ready', function(response) {
  FB.api("/me/picture", function(response) {

  });
});

function createStupidThings() {
  var el = new createNewUserCard("Ananth Mohan", "./../img/ananth-profile.jpg", -500);
  $("#user-page").append(el);
  $("#user-page").append(createNewUserCard("Bananth Bmohan", "./../img/ananth-profile.jpg", 25));

  $("#group-page").append(createNewGroupCard("Stupidest Group", "./../img/ananth-profile.jpg",
                                        50, 500, ["Bananthus", "Binuantoiwe", "Hitler", "AlsoAnanth",
                                        "NotAnantyh"]));

  $("#event-page").append(createNewEventCard("Stupid Event", true));  
}

function createNewEventCard(event_name, has_unresolved_debts) {
  return new EventCard(event_name, has_unresolved_debts);
}

function createNewGroupCard(name, img_url, total_owed_to, total_owed_from, group_members) {
  return new GroupCard(name, img_url, convertAmount(total_owed_to),
                       convertAmount(total_owed_from), group_members);
}

function createNewUserCard(name, img_url, transaction_amount, description) {
  if(!description) description = ""; 
  return new UserCard(name, img_url, convertAmount(transaction_amount),
                      transaction_amount < 0, description);
}

function convertAmount(cents) {
  if(cents < 0) cents *= -1;
  var amount = parseFloat(cents) ? cents : 0.0;

  var components = (amount / 100).toFixed(2).toString().split(".");
  var decimal = components[1];
  var dollars = components[0] || "";
  var mod, remainder;
  var stringReverse = function(str) {
      return str.split("").reverse().join("");
  };

  if(dollars.length > 3) {
      dollars = stringReverse(dollars);
      remainder = (mod = dollars.length % 3) ? stringReverse(dollars.slice(mod * -1)) + "," : "";
      dollars = remainder + stringReverse(dollars.match(/.../g).join(","));
  }
  return ["$", [dollars, decimal].join(".")].join("");
}