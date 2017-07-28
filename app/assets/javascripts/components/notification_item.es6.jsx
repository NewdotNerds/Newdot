class NotificationItem extends React.Component {
  constructor(props) {
    super(props);

    this.state = { unread: this.props.unread };
  }

  componentWillReceiveProps(nextProps) {
    this.setState({
      unread: nextProps.unread
    });
  }

  render () {
    return (
      <li
        className={this.state.unread ? 'unread-notification' : ''}
        onClick={() => this.handleMarkAsRead()}>
        <a href={this.props.url}>
          <span dangerouslySetInnerHTML={{ __html: this.props.actor_avatar_img_tag }} />
          <div className="notification-metadata">
            {this.notificationContent()}
            <br/>
            <small>{this.notificationIcon()} {this.props.time_ago}</small>
          </div>
        </a>
      </li>
    );
  }

  notificationContent() {
    const { actor, action, type } = this.props;
    switch (type) {
      case 'post':
        return `${actor} ${action} ${type}`;
      case 'user':
        return `${actor} ${action}`;
      case 'response':
        return `${actor} ${action} ${type}`;
    }
  }

  // FIXME: this is tightly coupled to action.
  notificationIcon() {
    switch(this.props.action) {
      case 'le dio tong a tu':
        return <svg className="fa-tong" version="1.1" id="Capa_1" x="0px" y="0px" width="13.8551px" height="11.1818px" viewBox="-0.518 0 50.5 60.68" enable-background="new -0.518 0 50.5 60.68">
            <path fill="#04bf75" stroke="#04bf75" strokeWidth="0.5" stroke-miterlimit="10" d="M4.307,2.671c3.1-3,14.5-0.5,14.5-0.5
              c0.3,0,3,0.5,3,3.899v21c0.2,4.4,5.8,4.101,5.7,0V6.171c0-3.5,2.7-4,3.1-4.101c0,0,11.4-2.6,14.5,0.5c10.3,10.2,0.3,55.8-19.6,57.3
              C4.406,61.47-6.094,12.87,4.307,2.671z"/>
          </svg>;
      case 'empezó a seguirte':
        return <i className="fa fa-user"></i>;
      case 'respondió tu':
      case 'también comentó en un':
        return <i className="fa fa-commenting-o"></i>;
    }
  }

  handleMarkAsRead(id) {
    $.ajax({
      url: `/api/notifications/${this.props.id}/mark_as_read`,
      method: 'POST',
      dataType: 'json',
      success: () => {
        this.setState({
          unread: false
        });
      }
    });
  }
}