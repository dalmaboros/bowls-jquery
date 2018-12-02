$(document).ready(function() {
  // Global Variables
  let bowlId = $(".column").data("id");

  // Scrap Prototype
  function Scrap(scrap_id, description, priority) {
    this.id = scrap_id;
    this.description = description;
    this.priority = priority || 0;
    this.format = function() {
      return `<li class="scrap-li"><a href="/scraps/${this.id}/edit">${this.description}</a> <a href="/bowls/${bowlId}/scraps/${this.id}" data-method="delete" class="delete-scrap" data-id="${this.id}" data-description="${this.description}"><span class="rotate">+</span></a></li>`;
    };
  };

  // Hide scraps div on page load
  $("#scraps").hide();

  /*** Displaying Scraps ***/

  // Event Listener: #show-scraps-button
  $("#show-scraps-button").on("click", function(event) {
    event.preventDefault();
    getScraps(bowlId, showScraps);
  });

  // Fetch scraps from database
  function getScraps(bowlId, callback) {
    fetch(`/bowls/${bowlId}.json`, {
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

  // Call appendScrap function and toggle #scraps div
  function showScraps(scraps) {
    $('#display-scraps').html("");
    if (scraps.length > 0) {
      scraps.forEach(function(params) {
        appendScrap(params);
      });
    } else {
      $('#display-scraps').append("This bowl has no scraps");
    }
    $("#scraps").slideToggle();
  };

  // Create and append scrap JS objects to #display-scraps div
  function appendScrap(scrap) {
    const newScrap = new Scrap(scrap.id, scrap.description, scrap.priority);
    const newFormattedScrap = newScrap.format();
    if ($('#display-scraps:contains("This bowl has no scraps")').length) {
      $('#display-scraps').html("");
    };
    $('#display-scraps').append(newFormattedScrap);
  };

  /*** Adding Scraps ***/

  // Event Listener: #add-scraps-button
  $("#add-scraps-button").click(function(){
    $("#scraps-form").slideToggle();
    $("#bowl_scraps_attributes_0_description").focus();
    toggleAddScrapsButton();
  });

  // Toggle '+/x' on #add-scraps-button
  function toggleAddScrapsButton() {
    if ($("#plus").hasClass("rotate")) {
      $("#plus").removeClass("rotate", 500, "ease");
    } else {
      $("#plus").addClass("rotate", 500, "ease");
    };
  };

  // Submitting form data
  $('form').submit(function(event) {
    event.preventDefault();
    let data = $(this).serialize();

    $.ajax({
      url: `/bowls/${bowlId}`,
      type: "PUT",
      data: data,
      success: function(response) { // response => bowl object
        $(`#edit_bowl_${bowlId}`)[0].reset();
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

  /*** Deleting Scraps ***/

  // Event Listener: .delete-scrap ('x')
  $('#display-scraps').on('click', 'a.delete-scrap', function(event) {
    event.preventDefault();
    if (confirm("Delete scrap from bowl?")) {
      removeScrapFromBowl(this.href, this.dataset.description);
    };
    return false;
  });

  // Remove scrap from bowl
  function removeScrapFromBowl(href, scrapDescription) {
    $.ajax({
      url: href,
      type: "DELETE",
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

  /*** Sifting Through Bowls ***/

  // Event listener: .next
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
        return bowl.id == bowlId;
      });
      // Retrieve adjascent bowl as JS object
      let adjascentBowlIndex = currentBowlIndex+incrementer;
      let adjascentBowl = response[adjascentBowlIndex];

      // If adjascent bowl exists, grab its data
      if (adjascentBowl != undefined) {
        $.get(`/bowls/${adjascentBowl.id}.json`, function(adjBowlJsonData) {
          // Update id to be adjascentBowl's id
          bowlId = adjBowlJsonData.id;
          // Populate DOM with JSON data
          $(".bowl-name").html(adjBowlJsonData.name);
          $(document).prop('title', `BOWLS | ${adjBowlJsonData.name}`);
          $("#edit-bowl").attr("href", `/bowls/${bowlId}/edit`);
          $("form.edit_bowl").attr("id", `edit_bowl_${bowlId}`);
          // $("form.edit_bowl").attr("action", `/bowls/${bowlId}`);

          // Set href for .random-bowl
          if (adjBowlJsonData.scraps.length > 0) {
            let randomScrap = adjBowlJsonData.scraps[Math.floor(Math.random()*adjBowlJsonData.scraps.length)];
            $(".random-bowl").attr("href", `/bowls/${bowlId}/scraps/${randomScrap.id}`);
          } else {
            $(".random-bowl").removeAttr("href");
          };
        });
      };
    }); // .get request
  }; // getAdjascentBowl

});
