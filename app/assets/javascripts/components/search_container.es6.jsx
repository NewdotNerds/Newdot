class SearchContainer extends React.Component {
  constructor(props) {
    super(props)

    this.state = { showDropdown: false, term: '', posts: [], users: [], tags: [] }
    this.hideDropdown = this.hideDropdown.bind(this);
    this.showDropdown = this.showDropdown.bind(this);
  }

  search(term) {
    this.setState({ term });

    $.ajax({
      url: `/api/autocomplete.json/?term=${term}`,
      method: 'GET',
      success: (data) => { this.setState({
        posts: data.posts,
        users: data.users,
        tags: data.tags
      });}
    });
  }

  hideDropdown() {
    setTimeout(() => { this.setState({ showDropdown: false }) }, 250); //FIXME: really hacky workaround.
  }

  showDropdown() {
    this.setState({ showDropdown: true });
  }

  render () {
    return (
      <div>
        <SearchBar 
          onInputFocus={this.showDropdown}
          onInputBlur={this.hideDropdown}
          term={this.state.term} 
          onSearchTermChange={(term) => {this.search(term)}}
        />
        {this.renderSearchResults()}
      </div>
    );
  }

  renderSearchResults() {
    if(!this.state.showDropdown || (this.state.posts.length === 0 && this.state.users.length === 0 && this.state.tags.length === 0)) {
      return;
    }

    return (
      <SearchResultsList
        term={this.state.term}
        posts={this.state.posts}
        users={this.state.users}
        tags={this.state.tags}
      />
    );
  }
}