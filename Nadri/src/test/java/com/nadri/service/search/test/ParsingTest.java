package com.nadri.service.search.test;

import java.util.List;

import org.snu.ids.ha.ma.MExpression;
import org.snu.ids.ha.ma.MorphemeAnalyzer;
import org.snu.ids.ha.ma.Sentence;
import org.snu.ids.ha.util.Timer;
import org.snu.ids.ha.index.Keyword;
import org.snu.ids.ha.index.KeywordExtractor;
import org.snu.ids.ha.index.KeywordList;

public class ParsingTest {

	public static void main(String[] args) {
		//test2()는 파싱, test3()은 추출
		test2();
		test3();
	}
		
		public static void test2() {
			String str = "그가방은 내겁니다. 건들지 마세요.";
			try {
                MorphemeAnalyzer ma = new MorphemeAnalyzer();
                ma.createLogger(null);
                Timer timer = new Timer();
                timer.start();
                List<MExpression> ret = ma.analyze(str);
                timer.stop();
                timer.printMsg("Time");
                
                ret = ma.postProcess(ret);
                ret = ma.leaveJustBest(ret);
                
                List<Sentence> stl = ma.divideToSentences(ret);
                
                for( int i = 0; i < stl.size(); i++ ) {
                      Sentence st = stl.get(i);
                      System.out.println("=============================================  " + st.getSentence());
                      for( int j = 0; j < st.size(); j++ ) {
                            System.out.println(st.get(j));
                      }
                }
                ma.closeLogger();
          } catch (Exception e) {
                e.printStackTrace();
          }
		}
		
		public static void test3() {
			String strToExtrtKwrd = "이것도분석하는게가능한부분인가요오지고지리고돌리고인정?어인정";
			// init KeywordExtractor
			KeywordExtractor ke = new KeywordExtractor();
			
			// extract keywords
			KeywordList kl = ke.extractKeyword(strToExtrtKwrd, true);
			
			// print result
			for( int i = 0; i < kl.size(); i++ ) {
			    Keyword kwrd = kl.get(i);
			    System.out.println(kwrd.getString() + "\t" + kwrd.getCnt());
			}
		}
}
