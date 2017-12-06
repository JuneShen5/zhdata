package com.govmade.zhdata.common.persistence;

public interface Function<T,E> {

    public T callback(E e);
}
