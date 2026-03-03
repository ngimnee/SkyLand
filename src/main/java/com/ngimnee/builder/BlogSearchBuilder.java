package com.ngimnee.builder;

public class BlogSearchBuilder {
    private Long id;
    private String title;
    private String content;
    private String status;


    public BlogSearchBuilder(BlogSearchBuilder.Builder builder) {
        this.id = builder.id;
        this.title = builder.title;
        this.content = builder.content;
        this.status = builder.status;
    }

    public Long getId() {
        return id;
    }
    public String getTitle() {
        return title;
    }
    public String getContent() {
        return content;
    }
    public String getStatus() {
        return status;
    }


    public static class Builder {
        private Long id;
        private String title;
        private String content;
        private String status;

        public BlogSearchBuilder.Builder setId(Long id) {
            this.id = id;
            return this;
        }

        public BlogSearchBuilder.Builder setTitle(String title) {
            this.title = title;
            return this;
        }
        public BlogSearchBuilder.Builder setContent(String content) {
            this.content = content;
            return this;
        }
        public BlogSearchBuilder.Builder setStatus(String status) {
            this.status = status;
            return this;
        }

        public BlogSearchBuilder build() {
            return new BlogSearchBuilder(this);
        }
    }
}
