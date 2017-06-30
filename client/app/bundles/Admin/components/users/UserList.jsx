import React from 'react';
import User from './User';
import {Link} from 'react-router-dom';
import {FormattedMessage, injectIntl, intlShape} from 'react-intl';
import {defaultMessages} from '../../../../libs/i18n/default';

class UserList extends React.Component {

  constructor(props, _railsContext) {
    super(props);
    this.state = {
      users: [],
    };
    this.handleDeleted = this.handleDeleted.bind(this);
  }

  handleDeleted(id) {
    const {formatMessage} = this.props.intl;

    this.setState({
      users: this.state.users.filter(user => {
        return user.id !== id
      })
    });
    $.growl.notice({message: formatMessage(defaultMessages.adminUsersDeleteSuccess)});
  }

  componentDidMount() {
    $.getJSON('/v1/users.json', (response) => {
      this.setState({ users: response.content });
    });
  }

  render() {
    const {formatMessage} = this.props.intl;

    return (
      <div className="row">
        <div className="col-md-12">
          <div className="certifications-table-header">
            <h2>{formatMessage(defaultMessages.adminUsersUsers)}</h2>
            <Link to="/admin/users/new">
              <button className="btn btn-success">
                {formatMessage(defaultMessages.adminUsersNew)}
              </button>
            </Link>
          </div>
          <div className="table-responsive col-md-12">
            <table className="table table-bordered table-hover table-striped">
              <thead>
                <tr>
                    <th>{formatMessage(defaultMessages.adminUsersName)}</th>
                    <th>{formatMessage(defaultMessages.adminUsersRole)}</th>
                    <th>{formatMessage(defaultMessages.adminUsersEdit)}</th>
                    <th>{formatMessage(defaultMessages.adminUsersDelete)}</th>
                </tr>
              </thead>
              <tbody>
                {
                  this.state.users.map(user => (
                    <User {...user} key={user.id} handleDeleted={this.handleDeleted}/>
                  ))
                }
              </tbody>
            </table>
          </div>
        </div>
      </div>
    );
  }
}

export default injectIntl(UserList);
