package kr.co.aura.aurastay.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

public class ReservationUtil {
    public static int getCheckDay(String checkin, String checkout) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Date intDate = null;
        Date outDate = null;

        try {
            intDate = new Date(dateFormat.parse(checkin).getTime());
            outDate = new Date(dateFormat.parse(checkout).getTime());
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

        long calculate = outDate.getTime() - intDate.getTime(); // out - int
        int countDay = (int) (calculate / ( 24*60*60*1000));

//        System.out.println("countDay: " + countDay);
        return countDay;
    }

    public static HashMap<String, Object> getRoomCheck(String checkin, int accommodationNo, int roomNo, int i) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date rsrvDate = null;
        try {
            rsrvDate = dateFormat.parse(checkin);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        Calendar cal = Calendar.getInstance();
        cal.setTime(rsrvDate);

        cal.add(Calendar.DAY_OF_MONTH, i);
        // 결과 날짜를 포맷 형식에 맞게 변환합니다.
        String getDate = dateFormat.format(cal.getTime());

        HashMap<String, Object> rsrvMap = new HashMap<>();
        rsrvMap.put("accommodationNo", accommodationNo);
        rsrvMap.put("roomNo", roomNo);
        rsrvMap.put("getDate", getDate);

        return rsrvMap;
    }
}
