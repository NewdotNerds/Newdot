class LikeButton extends React.Component {
  constructor(props) {
    super(props);

    this.state = { 
      liked: this.props.liked,
      likeCount: this.props.likeCount
    };

    this.onUnlikeClick = this.onUnlikeClick.bind(this);
    this.onLikeClick = this.onLikeClick.bind(this);
  }

  componentWillMount() {
    const { likeableType, likeableId } = this.props;
    this.token = PubSub.subscribe('LikeButton:onClick', (msg, data) => {
      if (likeableType === data.type && likeableId === data.id) {
        this.setState({ liked: data.liked, likeCount: data.count });
      }
    });
  }

  componentWillUnmount() {
    PubSub.unsubscribe(this.token);
  }

  render () {
    return (
      <div className="like-button">
        <div className="like-button-wrapper">
          {this.renderLikeButton()}
        </div>
          {this.renderLikeCount()}
        </div>
    );
  }

  renderLikeButton() {
    if (this.state.liked) {
      return (
        <button className="unlike-button" onClick={this.onUnlikeClick}>
          <svg version="1.1" id="Capa_1" x="0px" y="0px"
   width="13.8551px" height="19.1818px" viewBox="-0.518 0 50.5 60.68" enable-background="new -0.518 0 50.5 60.68">
<path fill="#FF3A46" stroke="#FF3A46" strokeWidth="0.5" stroke-miterlimit="10" d="M4.307,2.671c3.1-3,14.5-0.5,14.5-0.5
  c0.3,0,3,0.5,3,3.899v21c0.2,4.4,5.8,4.101,5.7,0V6.171c0-3.5,2.7-4,3.1-4.101c0,0,11.4-2.6,14.5,0.5c10.3,10.2,0.3,55.8-19.6,57.3
  C4.406,61.47-6.094,12.87,4.307,2.671z"/>
</svg>
        </button>
      );
    } else {
      return (
        <button className="like-button" onClick={this.onLikeClick}>
          <svg version="1.1" id="Capa_1" x="0px" y="0px"
   width="13.8551px" height="19.1818px" viewBox="0 0 54.25 64.25" enable-background="new 0 0 54.25 64.25">
<path fill="#FFFFFF" stroke="#FF3A46" strokeWidth="4" stroke-miterlimit="10" d="M6.75,4.351c3.1-3,14.5-0.5,14.5-0.5
  c0.3,0,3,0.5,3,3.899v21c0.2,4.4,5.8,4.101,5.7,0V7.851c0-3.5,2.7-4,3.1-4.101c0,0,11.4-2.6,14.5,0.5c10.3,10.2,0.3,55.8-19.6,57.3
  C6.85,63.15-3.65,14.55,6.75,4.351z"/>
</svg>
        </button>
      );
    }
  }

  renderLikeCount() {
    if (this.state.likeCount === 0 ) {
      return;
    }
    if (this.props.disableOverlay) {
      return <span className="like-count">{this.state.likeCount}</span>
    }
    return (
      <span className="like-count" style={{ cursor: 'pointer' }}>
          <OverlayTriggerButton 
            text={this.state.likeCount} 
            overlayHeading={this.props.overlayHeading}
            apiEndpoint={this.props.overlayEndpoint} />
      </span>
    );
  }

  onUnlikeClick(e) {
    $.ajax({
      url: this.props.unlikeEndpoint,
      method: 'DELETE',
      dataType: 'json',
      success: (data) => {
        this.setState({ liked: data.liked, likeCount: data.count });
        PubSub.publish('LikeButton:onClick', data);
      }
    });
  }

  onLikeClick(e) {
    $.ajax({
      url: this.props.likeEndpoint,
      method: 'POST',
      dataType: 'json',
      success: (data) => {
        this.setState({ liked: data.liked, likeCount: data.count });
        PubSub.publish('LikeButton:onClick', data);
      }
    });
  }
}

LikeButton.propTypes = {
  liked: React.PropTypes.bool.isRequired,
  likeCount: React.PropTypes.oneOfType([React.PropTypes.number, React.PropTypes.string]).isRequired,
  likeEndpoint: React.PropTypes.string.isRequired,
  unlikeEndpoint: React.PropTypes.string.isRequired,
  likeableType: React.PropTypes.string.isRequired,
  likeableId: React.PropTypes.number.isRequired,
  disableOverlay: React.PropTypes.bool,
  overlayHeading: React.PropTypes.string,
  overlayEndpoint: React.PropTypes.string
};

LikeButton.defaultProps = {
  disableOverlay: false
}