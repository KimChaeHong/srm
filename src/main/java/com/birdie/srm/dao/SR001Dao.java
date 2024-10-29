package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001Dto;

@Mapper
public interface SR001Dao {

	public void insertSr(SR001Dto sr001Dto);

	public List<SR001Dto> getSrList(PagerDto pager);

	public List<SR001Dto> getSearchedSr(Map<String, Object> searchCont);


}
