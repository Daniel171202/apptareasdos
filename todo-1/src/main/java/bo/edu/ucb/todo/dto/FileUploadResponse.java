package bo.edu.ucb.todo.dto;

public class FileUploadResponse {
    private String fileName;
    private String downloadUri;
    private long size;
 
  

    // getters and setters

    public String getFileName() {
        return fileName;
    }

    public String getDownloadUri() {
        return downloadUri;
    }

    public long getSize() {
        return size;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setDownloadUri(String downloadUri) {
        this.downloadUri = downloadUri;
    }

    public void setSize(long size) {
        this.size = size;
    }


}
