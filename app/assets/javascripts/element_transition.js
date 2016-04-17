var ElementTransitions = {
  setup: function() {
    $(document).on('page:fetch.transition', function() {
      $('[data-animation="fadeInUp-fadeOutDown"]').addClass('animated fadeOutDown');
      $('[data-animation="fadeInUp-fadeOutDown-small"]').addClass('animated fadeOutDown-small');
      $('[data-animation="bounceInLeft-bounceOutLeft"]').addClass('animated bounceOutLeft');
    });

    $(document).on('page:change.transition', function() {
      $('[data-animation="fadeInUp-fadeOutDown"]').addClass('animated fadeInUp');
      $('[data-animation="fadeInUp-fadeOutDown-small"]').addClass('animated fadeInUp-small');
      $('[data-animation="bounceInLeft-bounceOutLeft"]').addClass('animated bounceInLeft');
    });
  }

};

$(document).ready(ElementTransitions.setup);
$(document).on('page:load', ElementTransitions.setup);