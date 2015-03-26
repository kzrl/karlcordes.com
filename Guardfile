

# Compile SASS files.
guard :sass,
  :input           => "scss",
  :output          => "_site/css",
#  :style           => :compressed, # For debugging, set style to 'expanded' and line_numbers to true.
#  :line_numbers    => false

  :style           => :expanded, # For debugging, set style to 'expanded' and line_numbers to true.
  :line_numbers    => true

# tmux notification so that xfce4 nofify doesnt take up half of my screen. 
# should not affect non-tmux guard use - Karl
notification :tmux,
  :display_message => true,
  :timeout => 5, # in seconds
  :default_message_format => '%s >> %s',
  # the first %s will show the title, the second the message
  # Alternately you can also configure *success_message_format*,
  # *pending_message_format*, *failed_message_format*
  :line_separator => ' > ', # since we are single line we need a separator
  :color_location => 'status-left-bg' # to customize which tmux element will change color

