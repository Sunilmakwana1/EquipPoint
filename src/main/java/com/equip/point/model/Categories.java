package com.equip.point.model;

import com.equip.point.util.CommonDateTimeAndDeleted;
import com.equip.point.util.Type;

import java.time.ZonedDateTime;

public class Categories extends CommonDateTimeAndDeleted {

    private Long id;

    private String name;

    private String description;

    private String image;

    private String imageUri;

    private Type type;


    public Categories() {
    }

    public Categories(Long id, String name, String description, String image) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
    }

    public Categories(Long id, String name, String description, String image, ZonedDateTime createdAt, ZonedDateTime updatedAt, Boolean isDeleted) {
        super(createdAt, updatedAt, isDeleted);
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
    }

    public Categories(String name, String description, String image) {
        this.name = name;
        this.description = description;
        this.image = image;
    }

    public Categories(String name, String description, String image, ZonedDateTime createdAt, ZonedDateTime updatedAt, Boolean isDeleted) {
        super(createdAt, updatedAt, isDeleted);
        this.name = name;
        this.description = description;
        this.image = image;
    }

    public Categories(Long id, String name, String description, String image, ZonedDateTime createdAt, ZonedDateTime updatedAt, Boolean isDeleted, String imageUri) {
        this(id, name, description, image, createdAt, updatedAt, isDeleted);
        this.imageUri = imageUri;
    }

    public Categories(String name, String description, String image , Type type) {
       this(name, description, image);
         this.type = type;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getImageUri() {
        return imageUri;
    }

    public void setImageUri(String imageUri) {
        this.imageUri = imageUri;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Categories{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", image='" + image + '\'' +
                ", imageUri='" + imageUri + '\'' +
                '}';
    }
}
