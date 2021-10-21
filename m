Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D787A435DF6
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 11:29:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZhxq3L86z305Q
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Oct 2021 20:29:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1634808543;
	bh=UUbIgm1ccbdTxLbjq3RO6L/6fmau+inlTvNiaesC4pE=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=A8O2XXqkzmOsddmPRik+XSJZ8VxCLah5nnfDSqQRcEGVDpqQJov3AYcMK9l+mp3Xo
	 yRFg716KG/jiPNmuE2FTfj7sN87ULnRmqXRGyAM1QkgRVFVLL1d36JuTB4JE+oF2XS
	 BETJk1Yh03dUdd7lOVxtB1K+LXvPVWcoBpgEATrQLXQ5iYunulxKlLDrTU8pSInFD2
	 gT8yCdArEm4Z0wf7yg3tydnyFFX402VUZUCv2oozaqQHhxFIx2vRA8cY09nC5lvcnW
	 Q50CptG9ZIbfOAu5OaXgNX1hyMVBSTlcjwjBZqfdwmQ6NopmCIzB1n5pGd2huGCP5J
	 V4Az392pGLOtA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febd::626;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=NNLSshTl; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febd::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZhxg4JgVz2ymv
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Oct 2021 20:28:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArXr5KNkZDvPPqoajXJUJ+630MgkY0RvL2MzDsT77u2/n3OzaF19hTl7Evy3DyyI7RvLcj54JVZORC5AO8BYflqumovZPrhfnr1xjQkXkrq7/7rhrSjQ/lP2DfuU4byifLXOCsati2z+AmionYZNeVMm1yrPY4WavLz2BV7rIC6A0ViIA2NqN0eLanrAcfuMWeoUqct3jQIEuXg4U0BOzL/kf8Tln5CSdzOkKc7TZnyL6B73CPtweNLPBYPH8m/atqUMEqa9GWlFYXLk9eyCbPc+gVBQ968Mg1Djqd9AiqKmWpV7foSdQ/Wxp+I7NoUKpy4edVJm5qe7tOCgxUGAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUbIgm1ccbdTxLbjq3RO6L/6fmau+inlTvNiaesC4pE=;
 b=nPgBL4Zk2RXALTfBUN69l4MUCIG40/pqcLWD04CODQLQqlGkcGEfUPIgj+4UKaoUwduJ8QjXauaso/sxaOSPekmP9enX2M/OcBpChc8n8LJeERaczsInohwMDjikTP6wEoyhjaI+oYIss1NskK6WySYC0uV37wQqk8C5kmgBcZvWIcVJNZAxNkADoN8JDqck0L6GlMPjJiVlg2iHSFqkv1cgJizUCiEPCfapf/J9QoLXN8yciUwLrcHhOvtJshEWJzOHW7dbv58QfV6ArCzd8Lf5JvfMsofi5n4c2w1V4kBSYsJei/GP+fUFbCRfxMX8u+Mo58NMvntDeHgrMAiRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2384.apcprd02.prod.outlook.com (2603:1096:3:1f::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Thu, 21 Oct 2021 09:28:27 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::8062:2651:e9c8:ddc6]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::8062:2651:e9c8:ddc6%6]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 09:28:27 +0000
Subject: Re: [PATCH] erofs-utils: sort shared xattr
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211021025847.1136-1-huangjianan@oppo.com>
 <20211021025847.1136-2-huangjianan@oppo.com>
 <YXEV/e/lGn4S5fym@B-P7TQMD6M-0146.local>
Message-ID: <e88f1baf-b82f-cea8-d75b-b13fb2e33849@oppo.com>
Date: Thu, 21 Oct 2021 17:28:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YXEV/e/lGn4S5fym@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0043.apcprd04.prod.outlook.com
 (2603:1096:202:14::11) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from [10.118.7.229] (58.252.5.73) by
 HK2PR04CA0043.apcprd04.prod.outlook.com (2603:1096:202:14::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 09:28:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 839209b7-6258-41b1-9664-08d99475230d
X-MS-TrafficTypeDiagnostic: SG2PR02MB2384:
X-Microsoft-Antispam-PRVS: <SG2PR02MB23848B15D1959D643EFE5C1FC3BF9@SG2PR02MB2384.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lajuX5hnzbP3IitIzcOYIU1GEcKOVVTNrIhhPTAXzLFEGYLtwS1vCv5wZI0hjvMc8+NO1IXQZbRYmeWCtEYxe50wJcq4DiItcTssTZkQhfNZ7B3z0p2jVJu+DiYaaPs/mDV1/gRBg3i5j4hAsbxZaOSwWqvFwS2Hftv0aWzDZTUIaxqA521XvllI8LPyDodeRwL7wuGGY80yr18L4NltYjI8+4plcJ+zh7g06bo9WJkRg92B6ysfTf2WFtIuUjWHR+jJzl8m2Je8YuR9dG79ZgtJkEdrrOx7Ktlzh1A8y+ZiR1MC62C4kFwsmS0IGESTemXl9BhV7QHJd0tz60oQKUV0eYKd0W5YQzYgjpUtow6BTnlX3cgRH3gE0ZebwQbo/He+IH4Xqs9TwvuAq65pxgwg3M+2Hzptndv6okizJrU8VePzWwRkvreiEpVJedpOE2vFCGmbdzqFLWlY1NHc9b9hc/d20YxKB6+JUbTsBPcMmJs5wMCnsvjq8lRjNPNJEQ9273A/HyLiqFO9DB9V6ODvPZ0EfkTCdBjUatQXRKpreRZ1QHst5icla6HZ5X5aqbJnhLye2APiHsuOZ7hL3IGwNXVJfAbkzK5hE3A5r5a6oZtwzpl5BCQoE9WByeCC9RqZbc7GOfhpdgNAuN1AAFqomBfaiir0YGT1EadjqpiOlJhp+rphdO0xAYhgeQjAx5nEwTSgOXuo92ClZa67U8ly4mFrwhnTAPnTXp+mae17mf2J0hM/p6D+9SZcWVnM58uR00E7qUsa99r8qm9XfMXv9JiMowrxxgryRwRX0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66556008)(956004)(5660300002)(6916009)(16576012)(2616005)(316002)(508600001)(31686004)(107886003)(83380400001)(66476007)(31696002)(8936002)(2906002)(4326008)(6486002)(26005)(52116002)(36756003)(38350700002)(38100700002)(8676002)(186003)(86362001)(11606007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRuWWk0ZlZMRXg0RFRvc2VoRUpscHZGT01Sa1R1dlc3a2RxY3FoVDk1eVVn?=
 =?utf-8?B?ZmRrbjVVRzl6c1ovMi9tUGZkNUpNcEFTVlFWeWtON1VlMFdweXUyMC9oZDdZ?=
 =?utf-8?B?Z3NCa1d3Y3gxbmNQMHdldGFIT3FoakRkMis3T2RtWUtuQnJHNFloRDVpd2hR?=
 =?utf-8?B?clFFUithS0t0YWE2dmZGeHVJdWFheHVDTXpKMDAyUkRJMEdadUdyQTQwYkYz?=
 =?utf-8?B?bFQzbEVxZVBCMENhVUlDVHNaU0taeUIvekxMTmtSaUZaeXpaaDA4dnN0a2pw?=
 =?utf-8?B?WkhvQ3JsV2FZdXFzRzZXRW9EelFlVnlLUWVLT09VODFCRU85ZjNKS3hKUzlT?=
 =?utf-8?B?TmU3em93c1g4NTUya0ZNRWxDSjNQR01uWisraStPQmRmWStFczNGTERHTXRO?=
 =?utf-8?B?M2piY0tZcFZ4Qm94dStsZ2dHMzA0WmQxNEkvQjFzenNaall3RlVuVlhHdjJT?=
 =?utf-8?B?c1R1UFNENFVBWTFyMGR1OHYrckk2Tk5uU1JwendiZ3c0YTZYMTBOeEJsTHE2?=
 =?utf-8?B?TFB1OC9YZXB3bzVtTW1CNFFwOCs1RFNNN1dVVG5ZbEc5RkVlZUxPZEJIZllF?=
 =?utf-8?B?ODYweDljWm11M25IbEd0L3UrRzVBVUZyU25wZEtES1BnY3prYjRnRVNkaHhh?=
 =?utf-8?B?dTBVc1FDeVJreUhIWjA5MmZXQW5nQUJERVFvVDlXOWN6VUNSeUcralcwNEdh?=
 =?utf-8?B?M3BsaG9rSTNXY0FZNzNSRGxoRVl0ZEpJUGoxbDE3T1hwVWRTOGR4aks1QUdo?=
 =?utf-8?B?QlY0b1pvMldvRUNxdGJVYy9KNGFYQ3BKZmJreWp2MUhrd1NwL2dMSk5GeDB6?=
 =?utf-8?B?aDljc3RDUzF2UUx4ek5DUWZKaXc2dDZncUxlTFZEa0toaFRjeXVzL0JmNU1h?=
 =?utf-8?B?VmozYlpzMytvUHFBNEdPRHdlMGJmM0pZR2I1ZGFCSTdOak9jSFJOWXNudXdU?=
 =?utf-8?B?bnBVcm5lTXlSV2FhTDhsRHRhajJhMSt3RDQ1eml6UmxVL1R2cUNYNVp1RlhE?=
 =?utf-8?B?YVdGazEvRzhWQ3lqcG1WQUtxVjVlT2J2R01wa1QxRlYxRjhJakRoRnVaTXBB?=
 =?utf-8?B?anVrMmt5QU9RMzYyeE5vM2V0Z0p3K2pRUjB1SVVqTDJldEhzV3dNS0IrNmRX?=
 =?utf-8?B?Z2sxRy9NaDM0b21SYVZBTFBQSUJ4MENUWmh0aVJLM2NRQ0NGblZ3b0Q3VS82?=
 =?utf-8?B?QjM1WFZ5M3FvK2p3QS93bFZ6MUs4ZE5HSkxYK3FrM2cvOXBsTDZKZ0tVRUJK?=
 =?utf-8?B?NXU4enBha0VjdG9yUjJzdWFYMHBvRy94Uk9id1ZkYkJmbWlHQmlrTHNualMr?=
 =?utf-8?B?UDMzMXRZdUpGblMwSjBXOHJzeG10NUJndXQyc0xGalBTelk3c2l2enlyTHNK?=
 =?utf-8?B?UnVJclRnckZmUUUrSjhtL29abmNFdjljTnJrdDN2UnJBK283VHNwN2JWTUt2?=
 =?utf-8?B?ZFhzK2d2emtnT0NhTFl1ZzlBdXpPWkRBdFB0cThuTXI4MjBKVVBteGlvM2Iw?=
 =?utf-8?B?ZGJqeElBandpRmdHVllQa2V1eTFIQUtEeTNJVVhNa1VoUWphZ2tlQmpuSVVD?=
 =?utf-8?B?eTRLN09NcEFpNG5vblpaSmM0VXZPZlc3Ny9tNzZWVzRhUVhWUFZVaEZYWE10?=
 =?utf-8?B?ejVXbEhPaGVqSTUzdEtFSHplTWJhQlhMbVNwYWdBcHJUdWp0L0FrYWdyRlM4?=
 =?utf-8?B?YkhGdmc2amd1VkN6UkxwblY3UExlNEZZUWxIZmpIZGpKazRpTkFwZnllblFR?=
 =?utf-8?Q?W4iNAY6VJggdoMaCnJ2Y+6tDISE0zNK/hTLA2s9?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839209b7-6258-41b1-9664-08d99475230d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 09:28:27.1792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huangjianan@oppo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2384
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: yh@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2021/10/21 15:25, Gao Xiang 写道:
> Hi Jianan,
>
> On Thu, Oct 21, 2021 at 10:58:47AM +0800, Huang Jianan via Linux-erofs wrote:
>> Sort shared xattr before writing to disk to ensure the consistency
>> of reproducible builds.
> How about adding it as an option?

Can we consider turning on this by default abd add some test cases to 
ensure that xattr
functionality?  It seems that this part of the modification has no 
effect on the overall
function.

>> ---
>>   lib/xattr.c | 34 ++++++++++++++++++++++++++++++----
>>   1 file changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/xattr.c b/lib/xattr.c
>> index 196133a..f17e57e 100644
>> --- a/lib/xattr.c
>> +++ b/lib/xattr.c
>> @@ -171,7 +171,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
>>   	/* allocate key-value buffer */
>>   	len[0] = keylen - prefixlen;
>>   
>> -	kvbuf = malloc(len[0] + len[1]);
>> +	kvbuf = malloc(len[0] + len[1] + 1);
>>   	if (!kvbuf)
>>   		return ERR_PTR(-ENOMEM);
>>   	memcpy(kvbuf, key + prefixlen, len[0]);
>> @@ -196,6 +196,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
>>   			len[1] = ret;
>>   		}
>>   	}
>> +	kvbuf[len[0] + len[1]] = '\0';
>>   	return get_xattritem(prefix, kvbuf, len);
>>   }
>>   
>> @@ -398,7 +399,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
>>   	len[0] = sizeof("capability") - 1;
>>   	len[1] = sizeof(caps);
>>   
>> -	kvbuf = malloc(len[0] + len[1]);
>> +	kvbuf = malloc(len[0] + len[1] + 1);
>>   	if (!kvbuf)
>>   		return -ENOMEM;
>>   
>> @@ -409,6 +410,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
>>   	caps.data[1].permitted = (u32) (capabilities >> 32);
>>   	caps.data[1].inheritable = 0;
>>   	memcpy(kvbuf + len[0], &caps, len[1]);
>> +	kvbuf[len[0] + len[1]] = '\0';
>>   
>>   	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
>>   	if (IS_ERR(item))
>> @@ -562,13 +564,23 @@ static struct erofs_bhops erofs_write_shared_xattrs_bhops = {
>>   	.flush = erofs_bh_flush_write_shared_xattrs,
>>   };
>>   
>> +static int comp_xattr_item(const void *a, const void *b)
>> +{
>> +	const struct xattr_item *ia, *ib;
>> +
>> +	ia = (*((const struct inode_xattr_node **)a))->item;
>> +	ib = (*((const struct inode_xattr_node **)b))->item;
>> +
>> +	return strcmp(ia->kvbuf, ib->kvbuf);
> could we use strncmp (len[0] + len[1]) instead?

It seems that strncmp can't guarantee the order since ia and ib has 
different len. We
have ensure kvbuf[len[0] + len[1]] = '\0', Is there anything else to 
consider?

Thanks,
Jianan

> Thanks,
> Gao Xiang

