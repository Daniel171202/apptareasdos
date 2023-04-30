package bo.edu.ucb.todo.dto;

import java.util.*;

public class TaskDto {
    private Integer taskId;
    private String description;
    private String date;
    private String labelName;
    private boolean done;
    public TaskDto() {
    }


    public Integer getTaskId() {
        return this.taskId;
    }

    public void setTaskId(Integer taskId) {
        this.taskId = taskId;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDate() {
        return this.date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getLabel() {
        return this.labelName;
    }

    public void setLabel(String label) {
        this.labelName = label;
    }
    public boolean getDone() {
        return this.done;
    }
    public void setDone(boolean done) {
        this.done = done;
    }

    @Override
    public String toString() {
        return "{" +
            " taskId='" + getTaskId() + "'" +
            ", description='" + getDescription() + "'" +
            ", date='" + getDate() + "'" +
            ", label='" + getLabel() + "'" +
            ", done='" + getDone() + "'" +
            "}";
    }


}