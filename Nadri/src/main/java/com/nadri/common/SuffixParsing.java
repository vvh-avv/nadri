package com.nadri.common;

import java.util.ArrayList;

public class SuffixParsing {
   public SuffixParsing() {
      
   }
   
   public ArrayList<String> parsing(String sentence) {
      ArrayList<String> temp = new ArrayList<String>() ;
      int index = 0 ;
      while( true ) {
         
         if( sentence.indexOf("으 ") != -1 ) {
            
            index = sentence.indexOf("으") ;
//            System.out.println("으");
         }
         else if( sentence.indexOf("로 ") != -1 ) {
            
            index = sentence.indexOf("로") ;
//            System.out.println("로");
         } 
         else if( sentence.indexOf("에서 ") != -1 ) {
            
            index = sentence.indexOf("에서") ;
//            System.out.println("에서");
         } 
         else if( sentence.indexOf("에게서 ") != -1 ) {
            
            index = sentence.indexOf("에게서") ;
//            System.out.println("에게서");
         }
         else if( sentence.indexOf("부터 ") != -1 ) {
            
            index = sentence.indexOf("부터") ;
//            System.out.println("부터");
         }  
         else if( sentence.indexOf("까지 ") != -1 ) {
            
            index = sentence.indexOf("까지") ;
//            System.out.println("까지");
         }  
         else if( sentence.indexOf("에게 ") != -1 ) {
            
            index = sentence.indexOf("에게") ;
//            System.out.println("에게");
         } 
         else if( sentence.indexOf("한테 ") != -1 ) {
            
            index = sentence.indexOf("한테") ;
//            System.out.println("한테");
         } 
         else if( sentence.indexOf("께 ") != -1 ) {
            
            index = sentence.indexOf("께") ;
//            System.out.println("께");
         } 
         else if( sentence.indexOf("와 ") != -1 ) {
            
            index = sentence.indexOf("와") ;
//            System.out.println("와");
         } 
         else if( sentence.indexOf("과 ") != -1 ) {
            
            index = sentence.indexOf("과") ;
//            System.out.println("과");
         } 
         else if( sentence.indexOf("에서 ") != -1 ) {
            
            index = sentence.indexOf("에서") ;
//            System.out.println("에서");
         } 
         else if( sentence.indexOf("을 ") != -1 ) {
            
            index = sentence.indexOf("을")  ;
//            System.out.println("을");
         } 
         else if( sentence.indexOf("를 ") != -1 ) {
         
            index = sentence.indexOf("를 ") ;
//            System.out.println("를");
         } 
         else if( sentence.indexOf("의 ") != -1 ) {
         
            index = sentence.indexOf("의") ;
//            System.out.println("의");
         } 
         else if( sentence.indexOf("로서 ") != -1 ) {
            
            index = sentence.indexOf("로서") ;
//            System.out.println("로서");
         } 
         else if( sentence.indexOf("으로 ") != -1 ) {
            
            index = sentence.indexOf("으로 ") ;
//            System.out.println("으로");
         } 
         else if( sentence.indexOf(".") != -1 ) {
            
            index = sentence.indexOf(".") ;
//            System.out.println(".");
         }
         else if( sentence.indexOf("에 ") != -1 ) {
            
            index = sentence.indexOf("에 ") ;
//            System.out.println("에 ");
         } 
         else if( sentence.indexOf("은 ") != -1) {
            
            index = -1 ;
//            System.out.println("은 ");
         } 
         else if( sentence.indexOf("는 ") != -1) {
            
            index = -1 ;
//            System.out.println("는 ");
         } 
         else if( sentence.indexOf("이 ") != -1) {
            
            index = -1 ;
//            System.out.println("이 ");
         } 
         else if( sentence.indexOf("가 ") != -1) {
            
            index = -1 ;
//            System.out.println("가 ");
         }
         //공백 위치는 여기 fix
         else if( sentence.indexOf(" ") != -1 ) {
            
            index = sentence.indexOf(" ") ;
//            System.out.println("공백");
         }
         
         //마무리 조사
         else if( sentence.indexOf("요?") != -1) {
            
            index = -1 ;
//            System.out.println("요? 첫번째 조건");
         }
         else if( sentence.indexOf("세요") != -1) {
            
            index = -1 ;
//            System.out.println("세요");
         }
         
         else if( sentence.indexOf("다") != -1) {
   
               index = -1 ;
//               System.out.println("다 ");
         }
         else if( sentence.indexOf("다.") != -1) {
            
            index = -1 ;
//            System.out.println("다 ");
         }
         //한 단어만 검색 시
         else {
            if( !sentence.trim().equals("") ) {
               temp.add(sentence) ;
            }
            break ;
         }
         
         
         
         if( index == 0 ) {
            break ;
         } else if( index == -1 ) {
            if( sentence.indexOf("은 ") != -1) {
               
               index = sentence.indexOf("은") ;
//               System.out.println("은 ");
            } 
            else if( sentence.indexOf("는 ") != -1) {
               
               index = sentence.indexOf("는") ;
//               System.out.println("는 ");
            } 
            else if( sentence.indexOf("이 ") != -1) {
               
               index = sentence.indexOf("이") ;
//               System.out.println("이 ");
            } 
            else if( sentence.indexOf("가 ") != -1) {
               
               index = sentence.indexOf("가") ;
//               System.out.println("가 ");
            }
            else if( sentence.indexOf("요?") != -1) {
               
               index = sentence.indexOf("요?") + 1 ;
//               System.out.println("요?") ;
            }
            else if( sentence.indexOf("세요") != -1) {
               
               index = sentence.indexOf("세요") + 1;
//               System.out.println("세요");
            }
            else if( sentence.indexOf("다.") != -1) {
               
               index = sentence.indexOf("다.") + 1;
//               System.out.println("다 ");
            }
            else if( sentence.indexOf("다") != -1) {
   
               index = sentence.indexOf("다") ;
//               System.out.println("다 ");
            }
            
            sentence = sentence.substring( index + 1 , sentence.length()).trim() ;
            index = 0 ;
         }
         
         else {
            if( sentence.substring( 0 , index ) != "" && sentence != "") {
//               System.out.println("실행 ");
               temp.add( sentence.substring( 0 , index )) ;
//               System.out.println("들어간 값 : " + sentence.substring( 0 , index )) ;
            }
            sentence = sentence.substring( index + 1 , sentence.length()).trim() ;
//            System.out.println("남은 값 : " + sentence) ;
            index = 0 ;
         }
      }
      return temp ;
   }
}