//
//  ChineseJudge.m
//  MBSMapSample
//
//  Created by sunyifei on 11/15/12.
//
//

#import "ChineseJudge.h"

@implementation ChineseJudge

static int GB_SP_DIFF = 160;
// 存放国标一级汉字不同读音的起始区位码
static int secPosValueList[] = { 1601, 1637, 1833, 2078, 2274, 2302, 2433, 2594, 2787, 3106, 3212,
    3472, 3635, 3722, 3730, 3858, 4027, 4086, 4390, 4558, 4684, 4925, 5249, 5590 };

// 存放所有国标二级汉字读音


// 存放国标一级汉字不同读音的起始区位码对应读音
static unichar firstLetter[] = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'w', 'x', 'y', 'z' };
//static unichar firstLetter[] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z' };

// 存放所有国标二级汉字读音
static char ls_SecondSecTable[] = "cjwgnspgcgne[z[btzzzdxzkzgt[jnnjqmbsgzsczjszz[pgkbzgz[zwjkgkljzwkpjqhz[w[dzlsgmrzpzwwcckznkzzgttnjjnzkkzztcjnmczlqlzpzqfqrpzslwbtgkjfzxjwzltbncxjjjjtxdttsqzzcdxxhgck[phffss[zbgxlppbzll[hlxs[zm[jhsojnghdzqzklgjhsgqzhxqgkezzwzscscjxzezxadzpmdssmzjzqjzzc[j[wqjbzzpxgznzcpwhkxhqkmwfbpbzdtjzzkqhzlzgxfptzjzzzpszlfchmqshgmxxsxj[[dcsbbqbefsjzhxwgzkpzlqbgldlcctnmazddkssngzcsgxlzzazbnptsdkdzlhgzmzlcxpz[jndqjwxqxfzzfjlejpzrxccqwqqsbnkzmgplbmjrqcflnzmzqmsqzrbcjthztqfrxqhxmjjcjlxqgjmshzkbswzemzltxfszdswlzcjqxsjnqbsctzhbftdczzdjwzghqfrxwckqkxebptlpxjzsrmebwhjlbjslzzsmdxlclqkxlhxjrzjmfqhxhwzwsbhtrxxglhqhfnm[zkldzxzpzlgg[mtcfpajjzzljtzanjgbjplqgdzzqzaxbkzsecjsznslzzhsxlzcghpxzhznztdsbcjkdlzazfmzdlebbgqzzkxgldndnzskjshdlzxbcghxzpkdjmmzngmmclgwzszxzjfznmlzzthcszdbdllscddnlkjzkjszcjlkwhqasdknhcsganhdaashtcplcpqzbsdmpjlpzjoqlcdhjjzsprchn[nnlhlzzqzhwzptczgwwmzffjqqqqzxaclbhkdjxdgmmzdjxzllszgxgkjrzwzwzclzmssjzldbzd[fcxzhlxchzzjq[[qagmnzxpfrkssbjlzxzszglnscmhzwwmnzjjlxxhchsz[[ttxrzczxbzhcsmxjsznpwgpxxtazbgajcxlz[dccwzocwkccsbnhcpdzznfczztzckxkzbsqkkztqqxfcwchczkelzqbsqzjqcclmthszwhmktlkjlzcxwheqqhtqh[pq[qscfzmndmgbwhwlgsllzsdlmlxpthmjhwljzzhzjxhtxjlhxrswlwzjcbxmhzqxsdzpmgfcsglsxzmjshxpjxwmzqksmzplrthbxftpmhzxlchlhlzzlxgsssstclsldclrpbhzhxzzfhb[gdmzcnqqwlqhjj[zwjzzejjdhpblqxtqkwhlchqxagtlxljxmsl[htzkzjecxjcjnmfbz[sfzwzbjzgnzsdzsqzrsljpclpwxsdwejbjcbcnaztwgmpapclzqpclzxsbnmsggfnzjjbzsfzzndxhplqkzczwalsbccjx[zzgwkzpsgxfzfcdkhjgxdlqfsgdslqwzkxtmhsbgzmjzrglzjbpmlmsxlzjqqhzzjczzdjwbmzklddpmjegxzhzlxhlqzqhkzcwcjmzzxnatjhzccxzpcqlbzwwztwbqcmlpmzrjcccxfpznzzljplxxzztzlgdldcklzrzzgqtgjhhgjljaxfgfjzslcfdqzlclgjdjcsnzlljpjqdcclcjxmzzftsxgcgsbrzxjqqctzhgzqtjqqlzxjzlzlbczamcstzlpdjbzregklzzzhlzszqlznwczcllwjqjjjkdgjzolbbzppglghtgzxzghzmzcnqszczhbhgxkamtxzxnbskzzzgjzlqjdfcjxdzgjqjjpmgwgjjjpkqsbgbmmcjssclpqpdxcdzzkz[cjddzzgzwrhjrtgznzqldkljszzgzqzjgdzkshpzmtlcpwnjafzzdjcnmwesczglbtzcgmssllzxqsxsbsjsbbsgghfjlzpmzjnlzzwdqshzxtzzwhmzzhzwdbxbtlmszzzfsxjc[dxxlhjhf[sxzqhfzmzcztqcxzxrttdjhnnzzqqmnqdmmg[zdxmjgdhcdzzbffallztdltfxmxqzdngwqdbdczjdxbzgsqqddjcmbkzffxmkdmdszzszcmljdsznsbrskmkmpcklgdbqtfzswtfgglzplljzhgj[gzpzltcsmcnbtjbqfkthbzzgkpbbzmtdssxtbnpdklezcjnzddzkzddhqhsdzsctarlltkzlgecllkjlqjaqnbdkkghpjtzqksecshalqfmmgjnlzjbbtmlzzxdcjpldlpcqdhzzcbzsczbzmsljflkrzjsnfrgjhxpdhzjzbzgdlqcsezgxlblgzxtwmabchecmwzjzzlljjzhlg[djlslzgkdzpzxjzzzlwcxszfgwzzdlzhcljscmbjhblzzlzcblzdpdqzsxqzbztdkzxjz[cnrjmpdjgklcljbctbjddbblblczqrppxjcjlzcshltoljnmdddlngkaqhqhjgzkheznmshrp[qqjchgmfprxhjgdzchghlzrzqlczqjnzsqtkqjzmszswlcfqqqxzfggzptqwlmcrnfkkfszzlqbmqammmzxctpshcptxxzzsmphpshmclmldqfzqxszzzdzjzzhqpdszglstjbckbxzqzjsgpsxqzqzrqtbdkzxzkhhgflbcsmdldgdzdblzzzcxnncszbzbfglzzxswmsccmqnjqsbdqsjtxxmbltxzclzshzcxrqjgjzlxzfjphzmzqqzdfqjjlzznzjcdgzzgctxmzzsctlkphtxhtlbjxjlxscdqxcbbtjfqzfsltjbtkqbxxjjljchczdbzjdczjdcprnpqcjpfczlclzxzdmxmphjsgzgszzqlzlwtjpfszasmcjbtzkzcwmztcsjjljcqlwzmalbxzfbpnlsfhtgjwejjxxglljstgshjqlzfkcgnnnszfdeqfhbsaqtgzlbxmmzgszldzdqmjjrgbjtkgdhgkblqkbdmbzlxwcxzttzbkmrtjzxqjbhlmhmjjzmqasldczxzqdlqcafzwzxqhz";


//return if the original string contains Chinese characters
+ (BOOL)stringHasChinese:(NSString*)oriString andConvertTo:(NSMutableString *)outString {
//    NSLog(@"check if stringHasChinese +++++ oriString = %@ length = %d", oriString, [oriString length]);
    
    int length = [oriString length];
//    NSLog(@"length = %d", length);
    BOOL fResult = false;
    for(int i=0; i < length; i++){
        unichar ch = [oriString characterAtIndex:i];
//        NSLog(@"check if stringHasChinese..... ch = %C", ch);
        
        //判断是否为汉字，如果右移7位为0就不是汉字，否则是汉字
        if((ch>>7) == 0){

        } else {
            fResult = true;
            unichar firstChar = [ChineseJudge getFirstChineseLetter:ch];
            if (firstChar) {
                [outString appendFormat:@"%C", firstChar];
            }
        }
    }
    
    if (!fResult) {
        //            //不是汉字，把字符统一转化为小写
        [outString setString:[oriString lowercaseString]];
    }
    
    return fResult;
}

+ (unichar)getFirstChineseLetter:(unichar) ch {
    
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
//    NSLog(@"getFirstChineseLetter ...ch = %C", ch);
    NSString *strCharacter = [NSString stringWithCharacters:&ch length:1];
//    NSLog(@"getFirstChineseLetter ...strCharacter = %@", strCharacter);
    
    char *bytes = [strCharacter cStringUsingEncoding:encode];
//    NSLog(@"getFirstLetter ...bytes[0] = %x, bytes[1] = %x", bytes[0], bytes[1]);
    
    if (bytes[0] < 128 && bytes[0] > 0) { // 非汉字
//        NSLog(@"getFirstChineseLetter ...not chinese...");
        return 0;
    } else {
        return [ChineseJudge convert:bytes];
    }
}

/**
 * 获取一个汉字的拼音首字母。 GB码两个字节分别减去160，转换成10进制码组合就可以得到区位码
 * 例如汉字“你”的GB码是0xC4/0xE3，分别减去0xA0（160）就是0x24/0x43
 * 0x24转成10进制就是36，0x43是67，那么它的区位码就是3667，在对照表中读音为‘n’
 */

+ (unichar)convert:(char*) bytes {
    unichar result = '-';
    
    int secPosValue = 0;
    bytes[0] -= GB_SP_DIFF;
    bytes[1] -= GB_SP_DIFF;
    
//    NSLog(@"bytes[0] =  %d, bytes[1] = %d", bytes[0], bytes[1]);
    
    secPosValue = bytes[0] * 100 + bytes[1];
    
    if((secPosValue > 1600) && (secPosValue < 5590) && (secPosValue % 100 < 95)) {
        for (int i = 0; i < 23; i++) {
            if (secPosValue >= secPosValueList[i] && secPosValue < secPosValueList[i + 1]) {
                result = firstLetter[i];
                break;
            }
        }
    } else if ((secPosValue > 5590) && (secPosValue < 8795) && (secPosValue % 100 < 95)) {
        int ioffset = (bytes[0] - 56) * 94 + bytes[1] - 1;
        if (ioffset >= 0 && ioffset <= 3007) {
            result = ls_SecondSecTable[ioffset];
        }
    }
    return result;
    
}
@end
