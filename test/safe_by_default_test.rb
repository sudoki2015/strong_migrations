require_relative "test_helper"

class SafeByDefaultTest < Minitest::Test
  def setup
    StrongMigrations.safe_by_default = true
  end

  def teardown
    StrongMigrations.safe_by_default = false
  end

  def test_add_index
    assert_safe AddIndex
  end

  def test_remove_index
    migrate AddIndex
    assert_safe RemoveIndex
  ensure
    migrate AddIndex, direction: :down
  end

  def test_add_reference
    assert_safe AddReference
  end

  def test_add_reference_foreign_key
    assert_safe AddReferenceForeignKey
  end

  def test_add_foreign_key
    assert_safe AddForeignKey
  end

  def test_change_column_null
    skip unless postgresql?

    assert_safe ChangeColumnNull
  end
end
