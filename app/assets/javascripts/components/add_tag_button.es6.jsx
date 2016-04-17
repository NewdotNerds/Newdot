class AddTagButton extends React.Component {
  constructor(props) {
    super(props);
    this.state = { showPopover: false };

    this.closePopover = this.closePopover.bind(this);
  }

  render () {
    if (!this.state.showPopover) {
      return (
        <div className="add-tag-button">
          <button onClick={this.handleButtonClick.bind(this)}>
            <span className="icon-plus" />
          </button>
        </div>
      );
    } else {
      return (
        <div className="add-tag-button">
          <button onClick={this.closePopover}>
            <span className="icon-plus active" />
          </button>
          <AddTagPopover />
        </div>
      );
    }
  }

  handleButtonClick() {
    this.setState({ showPopover: true });
  }

  closePopover() {
    this.setState({ showPopover: false });
  }
}