@module external styles: {..} = "./styles/todoList.css"

module Item = {
    type t = {
        id: int,
        title: string,
        checked: bool
    }

    let make = (id, title) => {
        id,
        title,
        checked: false
    }

    let check = (item) => {
        ...item, checked: true
    }

    let uncheck = (item) => {
        ...item, checked: false
    }
};


type action = 
    | Add(string)
    | Check(int, bool)
    | Delete(int)
    | Change(string)
    ;

type state = {
    items: array<Item.t>,
    input: string
}

let addItem = (items:array<Item.t>, title) => {
    let i = items
        ->Array.get(Array.length(items) - 1)
        ->Option.map(item => item.id)
        ->Option.getWithDefault(0);

    let id = i + 1;
    
    Array.concat(items, [Item.make(id, title)]);
}

let checkItem = (items:array<Item.t>, id) => {
    Array.map(items, (item) => item.id == id ? Item.check(item) : item);
}

let uncheckItem = (items:array<Item.t>, id) => {
    Array.map(items, (item) => item.id == id ? Item.uncheck(item) : item);
}

let deleteItem = (items:array<Item.t>, id) => {
    Array.keep(items, (item) => item.id != id);
}

@react.component
let make = () => {
    let (state, send) = React.useReducer(
        (prevState, act: action) => switch act {
            | Add(title) => {items: addItem(prevState.items, title), input: ""}
            | Check(id, checked) => {
                    items: checked ? checkItem(prevState.items, id) : uncheckItem(prevState.items, id), 
                    input: prevState.input
                }
            | Delete(id) => {items: deleteItem(prevState.items, id), input: prevState.input}
            | Change(input) => {...prevState, input}
        },{
            items: [],
            input: ""
        }
    );

    let onInputChange = e => {
        //ReactEvent.Form.preventDefault(e);
        let value = ReactEvent.Form.target(e)["value"];
        send(Change(value));
    }

    let onCheckboxChange = (e, id) => {
       // ReactEvent.Form.preventDefault(e);
        let value = ReactEvent.Form.target(e)["checked"];
        send(Check(id, value));
    }

    let (completed, todos) = Array.partition(state.items, item => item.checked);

    <div>
        <h1>{"ToDo list"->React.string}</h1>
        <div>
            {"Add a new ToDo"->React.string}
            <input onChange={onInputChange} value={state.input} />
            <button onClick={(_) => send(Add(state.input))}>{"Add"->React.string}</button>
        </div>
        <div>
            <div className="checked-todos">
                <h3>{"ToDo:"->React.string}</h3>
                <ul>
                    {
                        todos
                        ->Array.map(item => 
                            <li key={string_of_int(item.id)}>
                                <input type_="checkbox" checked={item.checked} onChange={(e) => onCheckboxChange(e, item.id)} />
                                {React.string(item.title)}
                                <button onClick={(_) => send(Delete(item.id))}>{"Delete"->React.string}</button>
                            </li>)
                        ->React.array
                    }
                </ul>
            </div>
            <div className="unchecked-todos">
                <h3>{"Done:"->React.string}</h3>
                <ul>
                    {
                        completed
                        ->Array.map(item =>
                            <li key={string_of_int(item.id)}>
                                <input type_="checkbox" checked={item.checked} onChange={(e) => onCheckboxChange(e, item.id)} />
                                {React.string(item.title)}
                                <button onClick={(_) => send(Delete(item.id))}>{"Delete"->React.string}</button>
                            </li>)
                        ->React.array
                    }
                </ul>
            </div>
        </div>
    </div>
}