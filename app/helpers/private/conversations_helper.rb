module Private::ConversationsHelper
  include Shared::ConversationsHelper
  
  # get the opposite user of the conversation
  def private_conv_recipient(conversation)
    conversation.opposed_user(current_user)
  end

  # if the conversation has unshown messages, show a button to get them
  def load_private_messages(conversation)
    if conversation.messages.count > 0
      'private/conversations/conversation/messages_list/link_to_previous_messages'
    else
      'shared/empty_partial'
    end
  end

  # decide to show an option or not
  def add_to_contacts_partial_path(contact)
    if recipient_is_contact?
      'shared/empty_partial'
    else
      non_contact(contact)
    end
  end

  # decide which conversation heading style to show
  def conv_heading_class(contact)
    # show a conversation heading without or with options
    if unaccepted_contact_exists(contact)
     'conversation-heading-full'
    else
     'conversation-heading'
    end
  end

  private

  def recipient_is_contact?
    # check if recipient is a user's contact
    contacts = current_user.all_active_contacts
    contacts.find {|contact| contact['id'] == @recipient.id}.present?
  end

  def non_contact(contact)
    # if the contact request was sent by the user or recipient
    if unaccepted_contact_exists(contact)
      'shared/empty_partial'
    else
      # contact requests wasn't sent by any users
      'private/conversations/conversation/heading/add_user_to_contacts'
    end
  end

  def unaccepted_contact_exists(contact)
    # get a contact status with the recipient
    if contact.present?
      # check if an unaccepted contact between a user and a recipient exists
      contact.accepted ? false : true
    else
      false
    end
  end
end
