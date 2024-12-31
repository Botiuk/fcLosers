# fcLosers

An online home for a fictional football club called "Losers." It features news about the club, cards of players and coaches, tournament tables, a cup, a calendar, and video and photo galleries.

Built with: Rails 7.2.2, Ruby 3.3.5, postgres, bun, Tailwind, Cloudinary, Trix editor, devise, simple_calendar, pagy.

Test with: RSpec, factory_bot_rails and faker.

Code style checking: RuboCop and his special cops.

My native language is Ukrainian and this is a single language on app. But all interface text was made with I18n and easy to change with translating locale file.

The club's fictional name was chosen "Losers" because it could hardly exist in reality and as a contrast to the popular "cool" names such as "Leader," "Champion," and "Victoria." Each team considers itself the best, but in the case of unsuccessful performances, you can hear the phrase "Our losers lost again!" from the fans. Be funny if the fans would chant "Go "Losers", go!".

The site administrator is the club's press service. Registration is not available, users are created only through db:seed.

News about the team is available on the site, an unregistered user can only see those news that have a publication date and it is less than the current one. They can view news by categories to which they belong. The administrator can create, edit, and delete news. When creating a news, a cover, text, category, and publication date are added. Depending on whether the publication date is earlier than the current one, later, or absent altogether, it can be published, scheduled for publication, or a draft.

An unregistered user can view the club's team rosters. Each team consists of coaches and players, and their small cards with a photo are available on the general page, clicking on which you can view additional information about each. For the press service, players and coaches are divided into separate pages and presented as a common list for all teams. The administrator can edit the cards of club employees and remove them from the team.

Also available are data on current competitions in which teams participate. If the schedule provides for a standings table, then it is available on the corresponding page along with a list of all rounds of the championship and matches in them. For the cup system, all matches are available. You can view detailed information about each match. If at least one of the club teams participated in the meeting, then in addition to the protocol data, you can view the corresponding videos and photos. Are present general archive of all matches of the club's teams and search in archive matches with the opponent's name.

Each team of the club has a game calendar. Depending on whether it will be a home or away match, the marks in the calendar are made in different colors. You can go from them to the page with more details about the match.

Videos and photo albums can be linked to a single match. In this case, the user sees a special button to go to the game page. The administrator creates this link for media materials through the corresponding button either under each video or album or from the club's team match page.

The administrator gets access to additional functionality - creating team business cards with their logo and name, data about the stadiums where matches are held, and tournaments in which the club's teams participate. This information is necessary for the correct display of match data and the construction of tournament tables.

When creating a tournament, the tournament schema, and his start and end dates are selected. This is necessary to ensure that data about the current competition is displayed correctly. Then the administrator adds participants from all available teams and creates their matches from the tournament page. For each game necessary to choose the stadium where the match be played.