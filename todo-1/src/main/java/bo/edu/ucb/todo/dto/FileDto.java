package bo.edu.ucb.todo.dto;

public class FileDto {

    private Integer fileId;
    private String name;
    private String type;
    private String url;
    private Integer size;
    private byte[] content;

    public FileDto() {

    }
    public FileDto(Integer fileId, String name, String type, String url, Integer size, byte[] content) {
        this.fileId = fileId;
        this.name = name;
        this.type = type;
        this.url = url;
        this.size = size;
        this.content = content;
    }
    // getters and setters
    
    public byte[] getContent() {
        return content;
    }

    public void setContent(byte[] content) {
        this.content = content;
    }

    public Integer getFileId() {
        return fileId;
    }

    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }
}