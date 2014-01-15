module ApplicationHelper

	def active(page)

		#About is active only one way
		if page=='About' and current_page?(controller: 'page', action: 'about')
			return raw('class="active"')
		end

		#Home is active via "home" or via "Users#Index"
		if page=='Home' and (current_page?(controller: 'page', action: 'home') or current_page?(controller: 'events', action: 'index'))
			return raw('class="active"')
		end

	end

end
