require 'test_helper'

class AlexanderGrahamBellTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::AlexanderGrahamBell::VERSION
  end

  def test_tel_link__creates_a_tel_link_for_valid_links
    assert_equal '<a href="tel:18002752273">1-800-275-2273</a>', AlexanderGrahamBell.tel_link('1-800-275-2273')
    assert_equal '<a href="tel:8052234567">8052234567</a>', AlexanderGrahamBell.tel_link('8052234567')
    assert_equal '<a href="tel:8052234567">(805)2234567</a>', AlexanderGrahamBell.tel_link('(805)2234567')
    assert_equal '<a href="tel:8052234567">(805) 223 4567</a>', AlexanderGrahamBell.tel_link('(805) 223 4567')
    assert_equal '<a href="tel:8052234567">805.223.4567</a>', AlexanderGrahamBell.tel_link('805.223.4567')
    assert_equal '<a href="tel:8052234567">805-223-4567</a>', AlexanderGrahamBell.tel_link('805-223-4567')
    assert_equal '<a href="tel:+18052234567">+18052234567</a>', AlexanderGrahamBell.tel_link('+18052234567')
    assert_equal '<a href="tel:+18052234567">+-1...-80-.-5    2 23()()()4567</a>', AlexanderGrahamBell.tel_link('+-1...-80-.-5    2 23()()()4567')
    assert_equal '<a href="tel:+18052234567;isub=5">+18052234567ext5</a>', AlexanderGrahamBell.tel_link('+18052234567ext5')
    assert_equal '<a href="tel:+18052234567;isub=5">+18052234567   x 5</a>', AlexanderGrahamBell.tel_link('+18052234567   x 5')
    assert_equal '<a href="tel:+18052234567;isub=5">+18052234567 , 5</a>', AlexanderGrahamBell.tel_link('+18052234567 , 5')
    assert_equal '<a href="tel:+18052234567;isub=5">+18052234567 EXT  : 5</a>', AlexanderGrahamBell.tel_link('+18052234567 EXT  : 5')

    assert_equal '', AlexanderGrahamBell.tel_link('')
  end

  def test_tel_link__creates_text_for_invalid_links
    assert_equal '1', AlexanderGrahamBell.tel_link('1')
    assert_equal '1800BIGTOMATO', AlexanderGrahamBell.tel_link('1800BIGTOMATO')
    assert_equal 'wal@do.com', AlexanderGrahamBell.tel_link('wal@do.com')
    assert_equal '', AlexanderGrahamBell.tel_link('')
    assert_equal '      ', AlexanderGrahamBell.tel_link('      ')
    assert_equal '&lt;a href=&quot;/sup/bro&quot;&gt;hi&lt;/a&gt;', AlexanderGrahamBell.tel_link('<a href="/sup/bro">hi</a>')
  end

  def test_tel_link__raises_a_type_error_given_an_integer
    err = assert_raises(TypeError) {
      AlexanderGrahamBell.tel_link(8051234567)
    }
    assert_equal 'Expected phone_number to be of type String but got Integer', err.message
  end

  def test_tel_link__raises_a_type_error_given_nil
    err = assert_raises(TypeError) {
      AlexanderGrahamBell.tel_link(nil)
    }
    assert_equal 'Expected phone_number to be of type String but got NilClass', err.message
  end

  def test_tel_href_valid_numbers
    assert_equal 'tel:18002752273', AlexanderGrahamBell.tel_href('1-800-275-2273')
    assert_equal 'tel:18002752273;isub=45', AlexanderGrahamBell.tel_href('1-800-275-2273x45')
    assert_equal 'tel:bald duck', AlexanderGrahamBell.tel_href('bald duck')
    assert_equal 'tel:', AlexanderGrahamBell.tel_href('')
  end
end
