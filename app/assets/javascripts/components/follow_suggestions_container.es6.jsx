class FollowSuggestionsContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      users: [],
      activeUsers: []
    };
  }

  componentWillMount() {
    this.fetchUsers();
    this.token = PubSub.subscribe('UserFollowButton:onClick', (message, data) => {
      this.removeUser(data.followed_id)
    });
  }

  componentWillUnmount() {
    PubSub.unsubscribe(this.token);
  }

  fetchUsers() {
    $.ajax({
      url: '/api/follow_suggestions.json',
      method: 'GET', 
      dataType: 'json',
      success: (data) => {
        console.log(data);
        const newActives = data.slice(0, 6)
        this.setState({ 
          activeUsers: newActives,
          users: [ ...data.slice(6), ...newActives ]
        });
      }
    });
  }

  render () {
    return (
      <div className="follow-suggestions-container">
        <div className="suggestions-header">
          <h4 className="small-heading">¡La comunidad!</h4>
          <a className="refresh-link pull-right" onClick={this.refreshActiveUsers.bind(this)}>¿Quién más?</a>
        </div>
        <div>
          {this.renderSuggestions()}
        </div>
      </div>
    );
  }

  renderSuggestions() {
    if (this.state.users.length === 0) {
      return <h5>¡Estás siguiendo a todos!</h5>
    }
    return this.state.activeUsers.map(user => {
      return <SuggestionItem key={user.id} {...user} />
    });
  }

  refreshActiveUsers() {
    const newActives = this.state.users.slice(0, 6);
    this.setState({
      activeUsers: newActives,
      users: [ ...this.state.users.slice(6), ...newActives ]
    });
  }
  
  removeUser(id) {
    const filteredUsers = this.state.users.filter(user => {
      if (user.id === id) {
        removedUser = user;
      }
      return user.id !== id;
    });

    this.setState({
      users: filteredUsers
    });
  }
  
}