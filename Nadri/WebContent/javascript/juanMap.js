// 아이콘에 대한 정보를 보여줍니다.
var iconBase = '/images/spot/icon/';
var icons = {
	baby : {
		icon : iconBase + 'baby.png'
	},
	bike : {
		icon : iconBase + 'bike.png'
	},
	delivery : {
		icon : iconBase + 'delivery.png'
	},
	festival : {
		icon : iconBase + 'festival.png'
	},
	food : {
		icon : iconBase + 'food.png'
	},
	info : {
		icon : iconBase + 'info.png'
	},
	myplace : {
		icon : iconBase + 'myplace.png'
	},
	park : {
		icon : iconBase + 'park.png'
	},
	parking : {
		icon : iconBase + 'parking.png'
	},
	river : {
		icon : iconBase + 'river.png'
	},
	samdae : {
		icon : iconBase + 'samdae.png'
	},
	search : {
		icon : iconBase + 'search.png'
	},
	car : {
		icon : iconBase + 'car.png'
	},
	store : {
		icon : iconBase + 'store.png'
	},
	suyo : {
		icon : iconBase + 'suyo.png'
	}
};

//marker animation으로 찍기!
function addMarkerWithTimeout(position, timeout) {
	window.setTimeout(function() {
		marker = new google.maps.Marker({
			position : position,
			//icon: icons[feature.type].icon,
			map : map
		}, timeout);
	})
} // end of addMarkerWithTimeout

// Sets the map on all markers in the array.
function setMapOnAll(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
  setMapOnAll(null);
}

// Shows any markers currently in the array.
function showMarkers() {
  setMapOnAll(map);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
  clearMarkers();
  markers = [];
  locations = [];
}