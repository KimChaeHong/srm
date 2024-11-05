package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR004NT;

@Mapper
public interface SR004NTDao {

	int selectAttachOrder(String srId);

	void insertAttachment(SR004NT sr004nt);

	List<SR004NT> selectAttachList(String srId);

	SR004NT selectAttach(String attachId);

	int deleteAttach(String attachId);

}
