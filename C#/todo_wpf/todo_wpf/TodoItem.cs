using System;

namespace todo_wpf;

public class ToDoItem 
{
    public string Description { get; set; } = "";

    public bool IsCompleted { get; set; } = false;

    public DateTime Created { get; set; } = DateTime.Now;

    public override string ToString()
    {
        return $"{Created:yyMMddHHmmss} {Description}";
    }
}