package com.MeokZzang.recipe.vo;

import java.util.Map;

import com.MeokZzang.recipe.util.Ut;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class ResultData<DT> {
	private String resultCode;
	private String msg;
	private DT data1;
	private String data1Name;
	private Object data2;
	private String data2Name;
	private Map<String, Object> body;

	public ResultData(String resultCode, String msg, Object... args) {
		this.resultCode = resultCode;
		this.msg = msg;
		this.body = Ut.mapOf(args);
	}

	public static <DT> ResultData<DT> from(String resultCode, String msg) {
		return from(resultCode, msg, null, null);
	}

	public static <DT> ResultData<DT> from(String resultCode, String msg, String data1Name, DT data1) {
		ResultData<DT> rd = new ResultData<DT>();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1Name = data1Name;
		rd.data1 = data1;

		return rd;
	}

	public boolean isSuccess() {
		return resultCode.startsWith("S-");
	}

	public boolean isFail() {
		return isSuccess() == false;
	}

	public static <DT> ResultData<DT> newData(ResultData Rd, String data1Name, DT data1) {
		return from(Rd.getResultCode(), Rd.getMsg(), data1Name, data1);
	}

	public void setData2(String dataName, Object data) {
		data2Name = dataName;
		data2 = data;
	}

}
