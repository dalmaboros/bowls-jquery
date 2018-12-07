$(document).on('turbolinks:load', () => {
  // Global Variables
  let bowlId = $(".column").data("id");

  // Scrap Prototype
  function Scrap(scrap_id, description, priority) {
    this.id = scrap_id;
    this.description = description;
    this.priority = priority || 0;
    this.format = () => {
      return `<li class="scrap-li"><a href="/scraps/${this.id}/edit">${this.description}</a> <a href="/bowls/${bowlId}/scraps/${this.id}" data-method="delete" class="delete-scrap" data-id="${this.id}" data-description="${this.description}"><span class="rotate">+</span></a></li>`;
    };
  };

  // Hide scraps div on page load
  $("#scraps").hide();

  /*** Displaying Scraps ***/

  // Event Listener: #show-scraps-button
  $("#show-scraps-button").on("click", (event) => {
    event.preventDefault();
    getScraps(bowlId, showScraps);
  });

  // Fetch scraps from database
  const getScraps = (bowlId, callback) => {
    fetch(`/bowls/${bowlId}.json`, {
      contentType: 'application/json',
      method: 'GET',
    })
    .then(response => {
      return response.json();
    })
    .then(data => {
      const scraps = data.scraps;
      callback(scraps);
    });
  };

  // Call appendScrap(params) and toggle #scraps div
  const showScraps = (scraps) => {
    $('#display-scraps').html("");
    if (scraps.length > 0) {
      scraps.forEach((params) => {
        appendScrap(params);
      });
    } else {
      $('#display-scraps').append("This bowl has no scraps");
    }
    $("#scraps").slideToggle();
  };

  // Create and append scrap JS objects to #display-scraps div
  const appendScrap = (scrap) => {
    const newScrap = new Scrap(scrap.id, scrap.description, scrap.priority);
    const newFormattedScrap = newScrap.format();
    if ($('#display-scraps:contains("This bowl has no scraps")').length) {
      $('#display-scraps').html("");
    };
    $('#display-scraps').append(newFormattedScrap);
  };

  /*** Adding Scraps ***/

  // Event Listener: #add-scraps-button
  $("#add-scraps-button").click(() => {
    $("#scraps-form").slideToggle();
    $("#bowl_scraps_attributes_0_description").focus();
    toggleAddScrapsButton();
  });

  // Toggle '+/x' on #add-scraps-button
  const toggleAddScrapsButton = () => {
    if ($("#plus").hasClass("rotate")) {
      $("#plus").removeClass("rotate", 500, "ease");
    } else {
      $("#plus").addClass("rotate", 500, "ease");
    };
  };

  // Submitting form data
  $('#scraps-form form').submit(function(event) { //arrow function breaks behavior here
    event.preventDefault();
    const data = $(this).serialize();

    $.ajax({
      url: `/bowls/${bowlId}`,
      type: "PUT",
      data: data,
      success: function(response) { // response => bowl object
        $(`#edit_bowl_${bowlId}`)[0].reset();
        if (typeof response == "object") {
          const newScrap = response.scraps[response.scraps.length-1];
          appendScrap(newScrap);
        } else {
          // Presumably the ojbect already exists, as that is
          // our only validation on the BowlScrap model
          alert("scrap already exists!");
          // $("label[for='bowl_scraps_attributes_0_description']").text("scrap already exists");
          // $("label[for='bowl_scraps_attributes_0_description']").attr("class", "error_explanation");
        };
      }
    });
  });

  /*** Deleting Scraps ***/

  // Event Listener: .delete-scrap ('x')
  $('#display-scraps').on('click', 'a.delete-scrap', function(event) { //doesn't like arrow function here
    event.preventDefault();
    if (confirm("Delete scrap from bowl?")) {
      removeScrapFromBowl(this.href, this.dataset.description);
    };
    return false;
  });

  // Remove scrap from bowl
  const removeScrapFromBowl = (href, scrapDescription) => {
    $.ajax({
      url: href,
      type: "DELETE",
      success: (response) => { // response => bowl object
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
  $(".next").click((event) => {
    event.preventDefault();
    const incrementer = 1;
    siftBowl(incrementer);
  });

  // Event listener: .previous button
  $(".previous").click((event) => {
    event.preventDefault();
    const incrementer = -1;
    siftBowl(incrementer);
  });

  // Load previous/next bowl on page
  const siftBowl = (incrementer) => {
    // Hide scraps if displayed
    // hideScraps();
    // Retrieve previous/next bowl
    getAdjascentBowl(incrementer);
  };

  const hideScraps = () => {
    if (!($('#scraps').is(":hidden"))) {
      $('#show-scraps-button').click();
    };
    if (!($('#scraps-form').is(":hidden"))) {
      $('#add-scraps-button').click();
    };
  };

  const getAdjascentBowl = (incrementer) => {
    $.get("/bowls.json", (response) => { // respone => array of bowl objects
      const currentBowlIndex = response.findIndex((bowl) => {
        return bowl.id == bowlId;
      });

      // Retrieve adjascent bowl as JS object
      const adjascentBowlIndex = currentBowlIndex+incrementer;
      const adjascentBowl = response[adjascentBowlIndex];

      // If adjascent bowl exists, grab its data
      if (adjascentBowl != undefined) {
        hideScraps();
        $.get(`/bowls/${adjascentBowl.id}.json`, (adjBowlResponse) => {
          updateDOM(adjBowlResponse);
        });
      };
    }); // .get request
  }; // getAdjascentBowl

  const updateDOM = (adjBowlResponse) => {
    // Update bowlId to be adjascentBowl's id
    bowlId = adjBowlResponse.id;
    // Populate DOM with JSON data
    $(".bowl-name").html(adjBowlResponse.name);
    $(document).prop('title', `BOWLS | ${adjBowlResponse.name}`);
    $("#edit-bowl").attr("href", `/bowls/${bowlId}/edit`);
    $("form.edit_bowl").attr("id", `edit_bowl_${bowlId}`);

    if (adjBowlResponse.scraps.length > 0) {
      const randomScrap = adjBowlResponse.scraps[Math.floor(Math.random()*adjBowlResponse.scraps.length)];
      $(".random-bowl").attr("href", `/bowls/${bowlId}/scraps/${randomScrap.id}`);
    } else {
      $(".random-bowl").removeAttr("href");
    };
  }; // updateDOM

});
