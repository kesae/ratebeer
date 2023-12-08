module Helpers
  private
  def arg_lists_to_hashes(arg_lists)
    hashes = []
    arg_lists.first[1].each_with_index do |_, i|
      hash = {}
      arg_lists.keys.each do |key|
        hash = hash.merge({key => arg_lists[key][i]})
      end
      hashes << hash
    end
    hashes
  end

  def create_many(type, common_args, arg_lists)
    result = []
    hashes = arg_lists_to_hashes(arg_lists)
    hashes.each do |hash|
      obj = FactoryBot.create(type, common_args.merge(hash))
      result << obj
    end
    result
  end


  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end
end
