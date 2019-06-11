package com.sven.common.words.filter.result;

public class FilteredResult {
    //敏感词登记
    private Double level;
    //过滤后的内容
    private String filteredContent;
    //敏感词
    private String badWords;
    //非敏感词
    private String goodWords;
    //原内容
    private String originalContent;
    private Boolean hasSensiviWords = Boolean.valueOf(false);


    public String getBadWords() {
        return this.badWords;
    }


    public void setBadWords(String badWords) {
        this.badWords = badWords;
    }


    public FilteredResult() {
    }


    public FilteredResult(String originalContent, String filteredContent, Double level, String badWords) {
        this.originalContent = originalContent;
        this.filteredContent = filteredContent;
        this.level = level;
        this.badWords = badWords;
    }


    public Double getLevel() {
        return this.level;
    }


    public void setLevel(Double level) {
        this.level = level;
    }


    public String getFilteredContent() {
        return this.filteredContent;
    }


    public void setFilteredContent(String filteredContent) {
        this.filteredContent = filteredContent;
    }


    public String getOriginalContent() {
        return this.originalContent;
    }


    public void setOriginalContent(String originalContent) {
        this.originalContent = originalContent;
    }


    public String getGoodWords() {
        return this.goodWords;
    }


    public void setGoodWords(String goodWords) {
        this.goodWords = goodWords;
    }


    public Boolean getHasSensiviWords() {
        return this.hasSensiviWords;
    }


    public void setHasSensiviWords(Boolean hasSensiviWords) {
        this.hasSensiviWords = hasSensiviWords;
    }
}
