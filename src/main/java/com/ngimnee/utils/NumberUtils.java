package com.ngimnee.utils;

public class NumberUtils {
	public static boolean isLong(String value) {
		if(value == null) return false;
		try { 
			Long number = Long.parseLong(value);
		}
		catch(NumberFormatException e) {
			return false;
		}
		return true;
	}

    public static boolean isInteger(String value) {
        if(value == null) return false;
        try {
            Long number = Long.parseLong(value);
        }
        catch(NumberFormatException e) {
            return false;
        }
        return true;
    }

    public static boolean isNumber(Long number)
    {
        return number != null && !number.toString().isEmpty();
    }
}
