package com.hds.model;

public class Job {
    private int jobId;
    private String jobName;
    private String description;
    
    public Job(int jobId, String jobName, String description) {
        this.jobId = jobId;
        this.jobName = jobName;
        this.description = description;
    }
    
    public int getJobId() {
        return jobId;
    }
    
    public String getJobName() {
        return jobName;
    }
    
    public String getDescription() {
        return description;
    }
}

