class AddTagPopover extends React.Component {
  //Agregué el componentDidMount() para una mejor UX
  componentDidMount() {
    React.findDOMNode(this.refs.tagInput).focus(); 
  }  
  
  constructor(props) {
    super(props);
    this.state = { tagName: '' };
  }

  render () {
    return (
      <div className="add-tag-popover popover top" >
        <div className="arrow" />
        <h3 className="popover-title">
          Add your interest
        </h3>
        <div className="popover-content">
          <form onSubmit={this.handleAddTag.bind(this)}>
            <div className="input-group" >
              <input
                ref="tagInput"
                autofocus="true"
                type="text"
                value={this.state.tagName}
                onChange={this.handleInputChange.bind(this)}
                className="form-control"
              />
              <span
                className="input-group-addon add-button"
                onClick={this.handleAddTag.bind(this)}
              >
                Add
              </span>
            </div>
          </form>
        </div>
      </div>
    );
  }

  handleInputChange(e) {
    this.setState({ tagName: e.target.value });
  }

  handleAddTag(e) {
    e.preventDefault();
    if (this.state.tagName.length) {
      $.ajax({
        url: `/api/tags?tag_name=${this.state.tagName}`,
        method: 'POST',
        dataType: 'json',
        success: (data) => {
          PubSub.publish('TagFollowButton:onClick');
        }
      });
      this.props.closePopover();
    }
  }
}

