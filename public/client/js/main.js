$(document).ready(function() {
  $(".backToGroupHome").click(function() {
    var pages = document.querySelector('iron-pages');
    pages.select(0);
  });

  $(".backToGroupDetail").click(function() {
    var pages = document.querySelector('iron-pages');
    pages.select(1);
  });

  $(".toCreateGroup").click(function() {
    var pages = document.querySelector('iron-pages');
    pages.select(5);    
  });

  var ananth = {
    name: "Ananth Mohan",
    img_url: "../img/ananth-profile.jpg",
    person_id: "102938123098"
  }

  var ananths = [];
  for(var i = 0; i < 10; ++i) {
    ananths.push(ananth);
  }


  $(".person-list-container").each(function() {

    $(this).append(new PersonList(ananths));  
  });








});

$(document).on('fb-ready', function(response) {
  FB.api('/me/picture?type=large', function(response) {
    var imgURL = response.data.url;
    console.log(imgURL);
    console.log(response);
    //card creation happens here passing in image url
  });
  FB.api('/me', function(response) {
    console.log(response.first_name);
    //card creation happens here passing in image url
  });
  hideLoading();
});

function getFBFriendsPhotos(listNames) {
  var listFriends = [];
  
  for(i=0; i < listNames.length; i++) {
    var string = "/";
    var stringTwo = "/picture?type=large";
    var combinedUserString = string.concat(listNames[i]);

    var personData = {};
    FB.api(combinedString, function(response) {
      if (response && !response.error) {
        console.log("Response " + response.data);
        listFriendsPhotos.push(response.data.url)
        personData["firstName"] = response.first_name;
        personData["lastName"] = response.last_name;
      }   
    });

    var combinedPictureString = combinedUserString.concat(stringTwo);
    FB.api(combinedPictureString, function(response) {
      if (response && !response.error) {
        console.log("Response " + response.data);
        personData["pictureURL"] = response.data.url;
      }
    });
    listFriends.push(personData);
  }
}

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

// Send Create Group Request
$('#create-group').click(function() {
  var groupName = '';
  var userList = [];

  return $.ajax({
    type: type,
    url: url,
    data: {id: localStorage['user_id'], name: groupName, users: userList},
    success: function(data) {
      $("#group-page").clear();
      data.group_list.forEach(function(group) {
        $("#group-page").append(createNewGroupCard(group.name, "./../img/ananth-profile.jpg",
                                            50, 500, group.users));
      });
    }
      ,
    error: error,
    statusCode: {
      401: function() {
        window.open("index.html", "_self");
      }
    }
  });
});

// Get Users
$('#create-group').click(function() {
  var groupName = '';

  return $.ajax({
    type: type,
    url: url,
    data: {name: groupName},
    success: function(groupList) {
      $("#group-page").clear();
      for group in groupList {
        $("#group-page").append(createNewGroupCard(group.name, "./../img/ananth-profile.jpg",
                                            50, 500, group.users));
      }
    }
      ,
    error: error,
    statusCode: {
      401: function() {
        window.open("index.html", "_self");
      }
    }
  });
});

function showLoading() {
  $(".loading-area").fadeIn('fast');
}

function hideLoading() {
  $(".loading-area").fadeOut('fast');
}
