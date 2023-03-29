
use hypr.nu *



# Send all screen to the nth workspace defined.
def main [x: int] {
    let source_ws = (monitors | get workspaces | each {|ws| $ws | where active | get name | first });
    let target_ws = (monitors | get workspaces | each {|w|  $w | get name | get $x});
    # construct a list containing for each screen a list of the current workspace and the workspace to go to. 
    $source_ws | zip $target_ws | each {|screen| $screen | switch_ws; }
}