//画像プレビュー
$(function(){
  var dataBox = new DataTransfer();
  var file_field = document.querySelector('input[type=file]')

  $('.hidden-field').change(function(){
    var index = $(this).data("image")
    var file = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){
      var fileReader = new FileReader();

      dataBox.items.add(file)

      var num = $('.item-image').length + 1 + i
      fileReader.readAsDataURL(file);

      if(num == 5){
        $('#image-block__boxes').css('display', 'none')
      }
      fileReader.onloadend = function() {
        var src = fileReader.result
        var html= `<div class='item-image' data-image="${file.name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src}>
                      </div>
                    </div>
                    <div class='item-image__operation'>
                      <div class='item-image__operation__delete'>×</div>
                    </div>
                  </div>`
        //image-block__boxes要素の前にhtmlを差し込む
        $('#image-block__boxes').before(html);
      };
      $('#image-block__boxes').attr('class', `item-num-${num}`)
    });
    $(".image-label").prop("for", `item_images_attributes_${index + 1}_url`)
  });
  $(document).on("click", '.item-image__operation__delete', function(){
    const targetIndex = $(this).parent().data('index')
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    
  var target_image = $(this).parent().parent()
  var target_name = $(target_image).data('image')
  if(file_field.files.length==1){
    $('input[type=file]').val(null)
    dataBox.clearData();
    // console.log(dataBox)
  }else{
    $.each(file_field.files, function(i,input){
      if(input.name==target_name){
        dataBox.items.remove(i)
      }
    })
    file_field.files = dataBox.files
  }
  target_image.remove();
  var num = $('.item-image').length
  $('#image-block__boxes').show()
  $('#image-block__boxes').attr('class', `item-num-${num}`)
  })
});



//ブランドインクリメンタルサーチ
$(function(){
  $("#item_brand_id").on("keyup", function(){
    var input = $("item_brand_id").val();
    $.ajax({
      type: 'GET',
      url: '/items/index',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(items) {
      console.log("成功です");
    })
  });
});


//カテゴリー選択
$(function(){
  function appendOption(category){
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
                        <div class='listing-select-wrapper__box'>
                          <select class="listing-select-wrapper__box--select" id="child_category" name="category_id">
                            <option value="選択してください" data-category="選択してください">選択してください</option>
                            ${insertHTML}
                          <select>
                        </div>
                      </div>`;
    $('.item-detail__categories').append(childSelectHtml);
  }
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
                              <div class='listing-select-wrapper__box'>
                                <select class="listing-select-wrapper__box--select" id="grandchild_category" name="category_id">
                                  <option value="選択してください" data-category="選択してください">選択してください</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('.item-detail__categories').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value;
    if (parentCategory != "選択してください"){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.item-detail__category').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category');
    if (childId != "選択してください"){ 
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove();
    }
  });
});