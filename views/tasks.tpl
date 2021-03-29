% include("header.tpl") 
% include("banner.tpl")

<link rel="stylesheet" type="text/css" href="/static/styles.css"/>

<br><br>
<div class="w3-row">
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>Today</i></h1>
        </div>
        <table id="task-list-today" class="w3-table">
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>Tomorrow</i></h1>
        </div>
        <table id="task-list-tomorrow" class="w3-table">
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>The Next Day</i></h1>
        </div>
        <table id="task-list-the-next-day" class="w3-table">
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>The Day After That</i></h1>
        </div>
        <table id="task-list-the-day-after-that" class="w3-table">
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
</div>
<input id="current_input" hidden value="" />
<script>
/* API CALLS */

function api_get_tasks(success_function) {
    $.ajax({
        url: "api/tasks",
        type: "GET",
        success: success_function
    });
}

function api_create_task(task, success_function) {
    console.log("creating task with:", task)
    $.ajax({
        url: "api/tasks",
        type: "POST",
        data: JSON.stringify(task),
        contentType: "application/json; charset=utf-8",
        success: success_function
    });
}

function api_update_task(task, success_function) {
    console.log("updating task with:", task)
    task.id = parseInt(task.id)
    $.ajax({
        url: "api/tasks",
        type: "PUT",
        data: JSON.stringify(task),
        contentType: "application/json; charset=utf-8",
        success: success_function
    });
}

function api_delete_task(task, success_function) {
    console.log("deleting task with:", task)
    task.id = parseInt(task.id)
    $.ajax({
        url: "api/tasks",
        type: "DELETE",
        data: JSON.stringify(task),
        contentType: "application/json; charset=utf-8",
        success: success_function
    });
}

/* KEYPRESS MONITOR */

function input_keypress(event) {
    if (event.target.id != "current_input") {
        $("#current_input").val(event.target.id)
    }
    id = event.target.id.replace("input-", "");
    $("#filler-" + id).prop('hidden', true);
    $("#save_edit-" + id).prop('hidden', false);
    $("#undo_edit-" + id).prop('hidden', false);
}

/* EVENT HANDLERS */

days = ["today","tomorrow","the-next-day","the-day-after-that"]

function move_task(event) {
    if ($("#current_input").val() != "") { // Make sure that we aren't currently editing a task
        return // Exit the function
    }
    console.log("move item", event.target.id) // Print out the id of the task we want to move
    id = event.target.id.replace("move_task-", ""); // Get the id of the task to move from the id of the move arrow

    for (let day of days) {
        if (event.target.className.search(day) > 0) {
            target_list = day;
            break;
        } 
    };
    

    api_update_task({ // Update the task with the new data using the API
            'id': id, //Task ID 
            'list': target_list // Task list
        },
        function(result) { // Success function
            console.log(result); // Print the result
            get_current_tasks(); // Update the tasks on the screen
        });
    }


function complete_task(event) {
    if ($("#current_input").val() != "") {
        return
    }
    console.log("complete item", event.target.id)
    id = event.target.id.replace("description-", "");
    completed = event.target.className.search("completed") > 0;
    console.log("updating :", {
        'id': id,
        'completed': completed == false
    })
    api_update_task({
            'id': id,
            'completed': completed == false
        },
        function(result) {
            console.log(result);
            get_current_tasks();
        });
}

function edit_task(event) {
    if ($("#current_input").val() != "") {
        return
    }
    console.log("edit item", event.target.id)
    id = event.target.id.replace("edit_task-", "");
    // move the text to the input editor
    $("#input-" + id).val($("#description-" + id).text());
    // hide the text display
    $("#move_task-" + id + "-0").prop('hidden', true);
    $("#move_task-" + id + "-1").prop('hidden', true);
    $("#move_task-" + id + "-2").prop('hidden', true);
    $("#description-" + id).prop('hidden', true);
    $("#edit_task-" + id).prop('hidden', true);
    $("#delete_task-" + id).prop('hidden', true);
    // show the editor
    $("#color-" + id).prop('hidden', false);
    $("#editor-" + id).prop('hidden', false);
    $("#save_edit-" + id).prop('hidden', false);
    $("#undo_edit-" + id).prop('hidden', false);
    // set the editing flag
    $("#current_input").val(event.target.id)
}

function save_edit(event) {
    console.log("save item", event.target.id)
    id = event.target.id.replace("save_edit-", "");
    console.log("desc to save = ", $("#input-" + id).val())
    if ((id != "today") & (id != "tomorrow") & (id != "the-next-day") & (id != "the-day-after-that")) {
        api_update_task({
                'id': id,
                description: $("#input-" + id).val(),
                color: $("#color-" + id).val()
            },
            function(result) {
                console.log(result);
                get_current_tasks();
                $("#current_input").val("")
            });
    } else {
        api_create_task({
                description: $("#input-" + id).val(),
                list: id,
                color: $("#color-" + id).val()
            },
            function(result) {
                console.log(result);
                get_current_tasks();
                $("#current_input").val("")
            });
    }
}

function undo_edit(event) {
    id = event.target.id.replace("undo_edit-", "")
    console.log("undo", [id])
    $("#input-" + id).val("");
    if ((id != "today") & (id != "tomorrow") & (id != "the-next-day") & (id != "the-day-after-that")) {
        // hide the editor
        $("#color-" + id).prop('hidden', true);
        $("#editor-" + id).prop('hidden', true);
        $("#save_edit-" + id).prop('hidden', true);
        $("#undo_edit-" + id).prop('hidden', true);
        // show the text display
        $("#move_task-" + id + "-0").prop('hidden', false);
        $("#move_task-" + id + "-1").prop('hidden', false);
        $("#move_task-" + id + "-2").prop('hidden', false);
        $("#description-" + id).prop('hidden', false);
        $("#filler-" + id).prop('hidden', false);
        $("#edit_task-" + id).prop('hidden', false);
        $("#delete_task-" + id).prop('hidden', false);
    }
    // set the editing flag
    $("#current_input").val("")
}

function delete_task(event) {
    if ($("#current_input").val() != "") {
        return
    }
    console.log("delete item", event.target.id)
    id = event.target.id.replace("delete_task-", "");
    api_delete_task({
            'id': id
        },
        function(result) {
            console.log(result);
            get_current_tasks();
        });
}

function display_task(x) {
    found = false;
    arrows = [];
    lists = [];
    const vw = Math.max(document.documentElement.clientWidth || 0, window.innerWidth || 0)
    i = 3
    for (let day of days) {
        if (day == x.list) {
            found = true;
            continue;
        }
        if (!found) {
            arrows.push(vw > 600 ? "arrow_back_ios" : "keyboard_arrow_up")
        } else {
            arrows.push(vw > 600 ? "arrow_forward_ios" : "keyboard_arrow_down")
        }
        lists.push(day);
        --i;
    }
    completed = x.completed ? " completed" : "";
    ls = window.localStorage;
    darkened = ls.getItem('darkmode') == 'true' ? " dark": "";
    if ((x.id == "today") | (x.id == "tomorrow") | (x.id == "the-next-day") | (x.id == "the-day-after-that")) {
        t = `<tr id="task-${x.id}" class="task">
                <td colspan="3" style="width:54px"><input id="color-${x.id}" value="#ffffff" type="color"></input></td>
                <td><span id="editor-${x.id}">
                        <input id="input-${x.id}" style="height:22px" class="w3-input" 
                        type="text" autofocus placeholder="Add an item..."/>
                    </span>
                </td>
                <td style="width:72px">
                    <span id="save_edit-${x.id}" hidden class="save_edit material-icons">done</span>
                    <span id="undo_edit-${x.id}" hidden class="undo_edit material-icons">cancel</span>
                </td>
            </tr>`;
    } else {
        t = `<tr id="task-${x.id}" class="task">`
        for (i = 0; i < 3; ++i) {
            t+= `<td style="width:18px; padding: 0px;">
                    <span id="move_task-${x.id}-${i}" class="move_task ${lists[i]} material-icons${darkened}">
                        ${arrows[i]}
                    </span>
                    ${i==0 ? `<input hidden id="color-${x.id}" value="${x.color}" type="color"></input>` : ''}
                </td>`
        }
        t+=     `<td>
                    <span id="color-${x.id}" style="background-color: ${x.color}; width: 1ch; height: 17px; display: inline-block; margin: 0px"></span>
                    <span id="description-${x.id}" class="description${completed}${darkened}" style="padding-left: 0px">${x.description }</span>
                    <span id="editor-${x.id}" hidden>
                        <input id="input-${x.id}" style="height:22px" class="w3-input${darkened}" type="text" autofocus/>
                    </span>
                </td>
                <td>
                    <span id="edit_task-${x.id}" class="edit_task ${x.list} material-icons${darkened}">edit</span>
                    <span id="delete_task-${x.id}" class="delete_task material-icons${darkened}">delete</span>
                    <span id="save_edit-${x.id}" hidden class="save_edit material-icons${darkened}">done</span>
                    <span id="undo_edit-${x.id}" hidden class="undo_edit material-icons${darkened}">cancel</span>
                </td>
            </tr>`;
    }
    $("#task-list-" + x.list).append(t);
    $("#current_input").val("")
}

function get_current_tasks() {
    
        // display the tasks
    api_get_tasks(function(result) {
        // remove the old tasks
        $(".task").remove();
        // display the new task editor
        display_task({
            id: "today",
            list: "today"
        })
        display_task({
            id: "tomorrow",
            list: "tomorrow"
        })
        display_task({
            id: "the-next-day",
            list: "the-next-day"
        })
        display_task({
            id: "the-day-after-that",
            list: "the-day-after-that"
        })
        for (const task of result.tasks) {
            display_task(task);
        }
        // wire the response events 
        $(".move_task").click(move_task);
        $(".description").click(complete_task)
        $(".edit_task").click(edit_task);
        $(".save_edit").click(save_edit);
        $(".undo_edit").click(undo_edit);
        $(".delete_task").click(delete_task);
        // set all inputs to set flag
        $("input").keypress(input_keypress);
    });
}

$(document).ready(function() {
    get_current_tasks()
});
</script>
% include("footer.tpl")
