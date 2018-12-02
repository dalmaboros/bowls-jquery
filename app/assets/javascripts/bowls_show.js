$(document).ready(function() {
  // Hide scraps div initially
  $("#scraps").hide();

  // Global Variables
  let id = $(".column").data("id");

  // Scrap Prototype
  function Scrap(scrap_id, description, priority) {
    this.id = scrap_id;
    this.description = description;
    this.priority = priority || 0;
    this.format = function() {
      return `<li class="scrap-li"><a href="/scraps/${this.id}/edit">${this.description}</a> <a href="/bowls/${id}/scraps/${this.id}" data-method="delete" class="delete-scrap" data-id="${this.id}" data-description="${this.description}"><span class="rotate">+</span></a></li>`;
    };
  };

  // Event Listener: #show-scraps-button button
  $("#show-scraps-button").on("click", function(event) {
    event.preventDefault();
    getScraps(id, showScraps);
  });

  // Event Listener: #add-scraps-button button
  $("#add-scraps-button").click(function(){
    $("#scraps-form").slideToggle();
    $("#bowl_scraps_attributes_0_description").focus();
    toggleAddScrapsButton();
  });

  // Toggle +/x on #add-scraps-button
  function toggleAddScrapsButton() {
    if ($("#plus").hasClass("rotate")) {
      $("#plus").removeClass("rotate", 500, "ease");
    } else {
      $("#plus").addClass("rotate", 500, "ease");
    };
  };

  // Event Listener: .delete-scrap link
  $('#display-scraps').on('click', 'a.delete-scrap', function(event) {
    event.preventDefault();
    if (confirm("Delete scrap from bowl?")) {
      removeScrapFromBowl(this.href, this.dataset.description);
    };
    return false;
  });

  function removeScrapFromBowl(href, scrapDescription) {
    $.ajax({
      url: href,
      type: "DELETE",
      // headers: { 'Content-Type': 'application/json' },
      success: function(response) { // response => bowl object
        if ($(`#scraps li:contains(${scrapDescription})`).length) {
          $(`#scraps li:contains(${scrapDescription})`).remove();
        };
        if ($(`#scraps li`).length == 0) {
          $('#display-scraps').append("This bowl has no scraps");
        };
      }
    });
  };

  // Fetch scraps from database
  function getScraps(id, callback) {
    fetch(`/bowls/${id}.json`, {
      contentType: 'application/json',
      method: 'GET',
    })
    .then(response => {
      return response.json();
    })
    .then(data => {
      let scraps = data.scraps;
      callback(scraps);
    });
  };

  // Display scraps and toggle "show/hide scrap" button
  function showScraps(scraps) {
    $('#display-scraps').html("");
    if (scraps.length > 0) {
      scraps.forEach(function(params) {
        appendScrap(params);
      });
    } else {
      $('#display-scraps').append("This bowl has no scraps");
    }
    // toggleShowScrapsLink();
    $("#scraps").slideToggle();
  };

  // Append scraps to #scraps div
  function appendScrap(scrap) {
    const newScrap = new Scrap(scrap.id, scrap.description, scrap.priority);
    const newScrapFormat = newScrap.format();
    // Clear #scraps div if the bowl has no scraps
    if ($('#display-scraps:contains("This bowl has no scraps")').length) {
      $('#display-scraps').html("");
    };
    $('#display-scraps').append(newScrapFormat);
  };

  // Toggle "scraps"/"hide scraps" text
  function toggleShowScrapsLink() {
    $("#scraps").slideToggle();
    if ($("#show-scraps-button").text() == "scraps") {
      $("#show-scraps-button").text("hide scraps");
    } else {
      $("#show-scraps-button").text("scraps");
      // hideScraps();
    };
  };

  // Clear #scraps div
  function hideScraps() {
    $("#scraps").slideToggle();
  };

  // Form submit
  $('form').submit(function(event) {
    event.preventDefault();
    let data = $(this).serialize();
    let url = `/bowls/${id}`;

    $.ajax({
      url: url,
      type: "PUT",
      data: data,
      // headers: { 'Content-Type': 'application/json' },
      success: function(response) { // response => bowl object
        $(`#edit_bowl_${id}`)[0].reset();
        if (typeof response == "object") {
          let newScrap = response.scraps[response.scraps.length-1];
          appendScrap(newScrap);
        } else {
          // Presumably the ojbect already exists, as that is
          // our only validation on the BowlScrap model
          alert("Scrap already exists!");
          // but let's implement a prettier error handler?
        };
      }
    });
  });

  // Sifting Through Bowls

  // Event listener: .next button
  $(".next").click(function(event) {
    event.preventDefault();
    let incrementer = 1;
    getAdjascentBowl(incrementer);
  });

  // Event listener: .previous button
  $(".previous").click(function(event) {
    event.preventDefault();
    let incrementer = -1;
    getAdjascentBowl(incrementer);
  });

  // Load previous/next bowl
  function getAdjascentBowl(incrementer) {
    // Hide scraps if displayed
    let scrapsHidden = $('#scraps').is(":hidden");
    let formHidden = $('#scraps-form').is(":hidden");
    if (!scrapsHidden) {
      $('#show-scraps-button').click();
    };
    if (!formHidden) {
      $('#add-scraps-button').click();
    };

    // Retrieve current bowl as JS object
    $.get("/bowls.json", function(response) { // respone => array of bowl objects
      let currentBowlIndex = response.findIndex(function(bowl) {
        return bowl.id == id;
      });
      // Retrieve adjascent bowl as JS object
      let adjascentBowlIndex = currentBowlIndex+incrementer;
      let adjascentBowl = response[adjascentBowlIndex];

      // If adjascent bowl exists, grab its data
      if (adjascentBowl != undefined) {
        $.get(`/bowls/${adjascentBowl.id}.json`, function(adjBowlJsonData) {
          // Update id to be adjascentBowl's id
          id = adjBowlJsonData.id;
          // Populate DOM with JSON data
          $(".bowl-name").html(adjBowlJsonData.name);
          $(document).prop('title', `BOWLS | ${adjBowlJsonData.name}`);
          $("#edit-bowl").attr("href", `/bowls/${id}/edit`);
          $("form.edit_bowl").attr("id", `edit_bowl_${id}`);
          // $("form.edit_bowl").attr("action", `/bowls/${id}`);

          // Set href for .random-bowl
          if (adjBowlJsonData.scraps.length > 0) {
            let randomScrap = adjBowlJsonData.scraps[Math.floor(Math.random()*adjBowlJsonData.scraps.length)];
            $(".random-bowl").attr("href", `/bowls/${id}/scraps/${randomScrap.id}`);
          } else {
            $(".random-bowl").removeAttr("href");
          };
        });
      };
    }); // .get request
  }; // getAdjascentBowl

});
