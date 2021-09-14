$(document).on('change', '#user-platform', function() {
  let platformId = $('#user-platform').val();
  //カテゴリーが初期値でない場合
  if (platformId != '--') {
    $('.form-group-favorite').val('');
    $('.form-group-favorite option').css('display', 'block');
    $('#form-group-favorite').css('display', 'block');

    if (platformId == 2) {
      $('.form-group-favorite option[value]').each(function(i) {
        if (i>=18) {
          $('.form-group-favorite option[value = ' +(i)+ ']').css('display', 'none');
        }
      });
    } else if (platformId == 3) {
      $('.form-group-favorite option[value]').each(function(i) {
        if (i>=1&&i<19 || i>=37) {
          $('.form-group-favorite option[value = ' +(i)+ ']').css('display', 'none');
        }
      });
    } else if (platformId == 4) {
      $('.form-group-favorite option[value]').each(function(i) {
        if (i>=1&&i<38) {
          $('.form-group-favorite option[value = ' +(i)+ ']').css('display', 'none');
        }
      });
    }
  } else {
    $('.form-group-favorite').val('');
    $('.form-group-favorite option').css('display', 'none');
    $('#form-group-favorite').css('display', 'none');
  }
});