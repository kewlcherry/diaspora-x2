class User extends Backbone.Model
  initializer: ->
    # ...

  fetchPosts: ->
    $c.getChannel @channelId()
    
  getName: ->
    @get('jid').replace /@.+/, ''

  getStatus: ->
    (@get('status') + "").replace(/<.+?>/g,'')
    
  channelId: ->
    "/user/#{@get('jid')}/channel"
    
  subscribe: ->
    $c.subscribeToUser @get('jid')

  unsubscribe: ->
    $c.unsubscribeFromUser @get('jid')
  
  grantChannelPermissions: ->
    $c.grantChannelPermissions @get('jid'), @channelId()
    
  getAvatar: ->
    if @get('jid').match /@buddycloud/
      "http://media.buddycloud.com/channel/54x54/buddycloud.com/#{@getName()}.png"
    else
      "http://www.gravatar.com/avatar/#{hex_md5(@get('jid'))}?d=http://media.buddycloud.com/channel/54x54/buddycloud.com/welcome.bot.png"
    
this.User = User

class UserCollection extends Backbone.Collection
  model: User
  
  findByJid : (jid) ->
    @find (user) ->
      user.get('jid') == jid
      
  findOrCreateByJid : (jid) ->
    user  = null
    
    if @findByJid(jid)
      user = @findByJid(jid)
    else
      user = new User {
        jid : jid
      }
      @add user

    user
  # comparator: (post) ->
  #   post.get('published')
  
this.Users = new UserCollection