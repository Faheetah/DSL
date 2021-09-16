trigger Trello.Webhook, label: :trello do
  board "some board"
  card label_in: ["in progress", "done"}, status: "created"
end

notifier :slack do
  Slack.message do
    channel "some-channel"
    message "some message, ideally a way to get a var from what notified"
  end
end

Trello.update_card do
  id Var(:trello, :id) # idk, some way to get the context
  description "updated description"
end
