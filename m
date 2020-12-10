Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E92D5123
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Dec 2020 04:09:13 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrzQt2yWXzDqv1
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Dec 2020 14:09:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.70;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=dTGhyeJn; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300070.outbound.protection.outlook.com [40.107.130.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrzQk29CQzDqs2
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Dec 2020 14:08:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVS401uX7RFSAipB8BbfPP2Q3Uu/LJRXyYRolK0KTrvOQ0ruqnuSj8FOHTlcWd41pK6q9IsvUDJDR/i+TxUdruZ6r5UC0UHlMVBRSsDs+7Svbc/hPwU0n6HcHt5CirQECXKLqwXcSlB7KYrHyqPHsE2Gm0Ecn9I6syOZYCacgCYIHgHe77b+MPHjbG7tZppcvJCcpVTcxc20knWVpVI3QYuTHLNZkS8QbwFo8IXKysQrEfSg2dref5b2LWti71zON7v4ugjH6H7bZ0A9qNQGioY8CWLvTZ4JkYkyPXHGSFb7VqAZ513Yh6D798SZJXyuFlwxI6AE5yXD+51apbj53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z509Mn9C/4jzOBj1z02gqyKjyMsAkPWhMrPrxO+kM6s=;
 b=PC8IwUFO8mqIxX9qjM5AynxMOxIsDRxFuhuUaDXT2rO/FUJafrAYxeySzuc916J1a/DuazlEgyljj19kqtJwsO6UBmMd+0TEB30imMbFQ99Z+5baLhvv3CciZQPHjXGOqIzsdofJ3CI27wjqyzh+G92erL+G/jhnxBSbCTO6qkfgEUkQ7bnQ3dEcoGwX5iSbN40VLgrehdzyCbwefSq5+R3HrAlgSb8BiVeUcJNqzSgo3UnqXnNQXaKy15CfeR7YljLDPMbqxvOk3E6qd3D474ZHjvLHSVfCW8h37jacQoeTjlaNnKPas7fQME/9jztEpKHXP2DUbbGkMHD9bE2HNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z509Mn9C/4jzOBj1z02gqyKjyMsAkPWhMrPrxO+kM6s=;
 b=dTGhyeJndLboeULNdNUDXtMTs/K0vZ39s2D169WgcRE51m9fR8xflavXmHeF2FQRQ76CfgOw6aJpK7HwcI7Zh4bRfbOO65IXWDq62S8Nj4T54D0EAVYUznKk6OTh13Wc1HuMdKo5yi3Zba7GGGr8kp4uILqRNGcQtDqTqEmHOkU=
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3561.apcprd02.prod.outlook.com (2603:1096:4:4d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.22; Thu, 10 Dec 2020 03:08:46 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 03:08:46 +0000
Subject: Re: [PATCH v5] erofs: avoid using generic_block_bmap
To: Gao Xiang <hsiangkao@redhat.com>
References: <20201209115740.18802-1-huangjianan@oppo.com>
 <20201210023612.GA247374@xiangao.remote.csb>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <efaca0e6-cd0d-e410-eb24-0ce872f7e2ea@oppo.com>
Date: Thu, 10 Dec 2020 11:08:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201210023612.GA247374@xiangao.remote.csb>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.255.79.104) by
 HK0PR03CA0119.apcprd03.prod.outlook.com (2603:1096:203:b0::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 03:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e2565c-be3f-4d73-6e4c-08d89cb8e878
X-MS-TrafficTypeDiagnostic: SG2PR02MB3561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3561B1EB16B88EE2F6C20E00C3CB0@SG2PR02MB3561.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Pta+5fgq8JOovwW9nbi0G2MGbBJs8E44XRtzxh7I30hGBpDDXfp2y3K+5/mwp/fEVN2RSW+4p7uQrv3ihXDHutLp+vWPQ//ogKn9pFa21ffUY/8GSlg3M5tlZcjZwDQaRacLXYM+gGFpiQY2wceJuSSX3U7am9qJJ4AHg0QeoBeCi8xKH7WBEhWPgn+KsgT74p9I37ZjyUgm8o3E94FBI7+NWAa0WOQ8igZSWV0BtFzDce8/48QbYwP9ykeJvndI3JAUS2VSUAxYYTZz4RyknSqU5kyqmH1HCQz327FxMyftKZ9yCrA8QIkma4w1kJywH/TF4U6sL4ZefegiPJ5Hxff6xqiQaOZfNLrSuUy+ZTfJn4bVzONkPSCdd/fEEPwOu9QYXue4ugVrmfhH0Pc/jWzCNEAUjPHHDXBykZ3O4CFov7ln3TjMkju9l8TqYIRoovyTEjVM2WoPRn/3a+OOX3IyirknEghCBCmdqDMkH9kWe84jNDP71MrpvVnFs96
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(66556008)(107886003)(508600001)(16526019)(8676002)(66476007)(83380400001)(26005)(31696002)(8936002)(186003)(4326008)(86362001)(6666004)(34490700003)(66946007)(6486002)(52116002)(5660300002)(956004)(2616005)(31686004)(16576012)(36756003)(6916009)(2906002)(41533002)(11606006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZkJKTGcvejNEMnYzelFBNnlxTm94S1ZWWHNtdndpSlp2b04wV0hZaXAxSnFD?=
 =?utf-8?B?QTh3RkVJMSt2eEFJYnNNT1VFL05oM1E0QWhLNmQ0TWxyMzBqOU9ycXoydEdn?=
 =?utf-8?B?Y2dMVnd6dE44clUwdE0rUXJWNW1LQTZ0V3R3TWg0dzBoQ2lHcEw3VThVNkdL?=
 =?utf-8?B?dWl2R0c2bTUreVlsdmh2K2RXWUltbkFoUFRnQzQwVkN2V1ZpVktNMS9ZeHp1?=
 =?utf-8?B?SGx0L24rODFzeGx6cHdDVkV0bXY1aUNlaUxwQ084TEQ0NmRTZXdHb2tLSEtE?=
 =?utf-8?B?SXlxYjRra285WHU1YVd0ckJLNGErQ0RUNi9BK01DbS9BMkVUaUh2Y09sczNs?=
 =?utf-8?B?WHduY0tObjhBYklBYUUvTEp3dVFTbXVhU3ZtZk9RdUZTWGQ4NmN1aVlobU1K?=
 =?utf-8?B?enJQVDBnRmN1UG50MGNkV1NtdmExUk9LclBxVVY5QlVnZ2JHYnUwN0RFam5j?=
 =?utf-8?B?V1RCMFlCQmNtdDZ3QitxMFRtaXNUVHNodmlxZ1VFblFUeWpSTkVnSm5QZ2V6?=
 =?utf-8?B?dldJV2lQbjZVTVRVQWxXdGpMVHpBR3VzVSs3cG9maE0yZkdISWFBWmI5UDNL?=
 =?utf-8?B?blhwQjVwTkt3MWRmc2c3QkFPcTh4WStLYnd2ZExtRHoyc3Axd3h2cFF5eUQw?=
 =?utf-8?B?Vm9TNlFoWU1kYjVFdzljRFVIWUtoaUM1WWxqSXpSUEJyTEpack8xT09ZdkI4?=
 =?utf-8?B?OTh4NkU0elltVlk4RzNFeWptUHMzKy9KUHhySnR6Z3QvU1M4aGJQSHp4ZTZF?=
 =?utf-8?B?SlRKRE5IcnJJcmZwQUVXTWg0bzQ1cmxIaHRGRE40T1hJaTZueXFLb1Z0TkFl?=
 =?utf-8?B?aFM5TmswcFM2Q29NVVZxSDlXbi84NERDVVZ6c3lnKzNTLzQwOGh1RkhNaE1M?=
 =?utf-8?B?aUFiZE1ZcVNhSjBXbHFlanN2NWtFU3hFU2FmVGVoZ082MEdPMHdyYVRFbEhM?=
 =?utf-8?B?MzJLMkhTUllYVGlCaThsbHBsVlpkV2NNWnhMaWQ3V3hwcmlPeEVEU2ZpYUJC?=
 =?utf-8?B?ZTRtMUhhOTdlRFQvR0ppaVZVQVNjWGhUQ1NDUnNKY29Fc0t6aXVvWHFuenUx?=
 =?utf-8?B?UjdtdnJxUGRRL0RTdHFwYnQvQUREdmFHUlM5M2w1aGFPbUFnZ0NQZFBqckpz?=
 =?utf-8?B?U0MxNmlYSmhKVks4RlNucGhBVnBYNEx5TnUrZG9JU1Q1SEhJWVpiZEJqUnF4?=
 =?utf-8?B?VTNwMG8xV0JrbjBmRWFtNFQzcWNZY2tJZlJacnlpcS9EUDlWdmlCTGRYSXZp?=
 =?utf-8?B?cWlqc3FLRG5FQzBJUk9MYVFNSVcxNE8rM0NGeHN3RHg1YldmYkNIOU5TcSt6?=
 =?utf-8?Q?dmkAzjdfx0xmv+8Ev/WbWWm6gE+XbJQHrQ?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 03:08:45.9208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e2565c-be3f-4d73-6e4c-08d89cb8e878
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsth3iSSH7Sl7+YJsUquWuN5OtHXqtA260KSK+w/C+XhP1p9l+JhSM87x0L9eOFRwSDzBY2hsLKN9xNgs4JBag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3561
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thanks for reminding me, I will pay attention about this next time.

在 2020/12/10 10:36, Gao Xiang 写道:
> Hi Jianan,
>
> On Wed, Dec 09, 2020 at 07:57:40PM +0800, Huang Jianan wrote:
>> iblock indicates the number of i_blkbits-sized blocks rather than
>> sectors.
>>
>> In addition, considering buffer_head limits mapped size to 32-bits,
>> should avoid using generic_block_bmap.
>>
>> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
>
> Also, I think Chao has sent his Reviewed-by in the previous reply ---
> so unless some major modification happens, it needs to be attached with
> all new versions as a common practice...
>
> I will apply it later to for-next, thanks for your patch!
>
> Thanks,
> Gao Xiang
>
>> ---
>>   fs/erofs/data.c | 26 +++++++-------------------
>>   1 file changed, 7 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 347be146884c..ea4f693bee22 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -312,27 +312,12 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>>   		submit_bio(bio);
>>   }
>>   
>> -static int erofs_get_block(struct inode *inode, sector_t iblock,
>> -			   struct buffer_head *bh, int create)
>> -{
>> -	struct erofs_map_blocks map = {
>> -		.m_la = iblock << 9,
>> -	};
>> -	int err;
>> -
>> -	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>> -	if (err)
>> -		return err;
>> -
>> -	if (map.m_flags & EROFS_MAP_MAPPED)
>> -		bh->b_blocknr = erofs_blknr(map.m_pa);
>> -
>> -	return err;
>> -}
>> -
>>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>>   {
>>   	struct inode *inode = mapping->host;
>> +	struct erofs_map_blocks map = {
>> +		.m_la = blknr_to_addr(block),
>> +	};
>>   
>>   	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
>>   		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
>> @@ -341,7 +326,10 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>>   			return 0;
>>   	}
>>   
>> -	return generic_block_bmap(mapping, block, erofs_get_block);
>> +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
>> +		return erofs_blknr(map.m_pa);
>> +
>> +	return 0;
>>   }
>>   
>>   /* for uncompressed (aligned) files and raw access for other files */
>> -- 
>> 2.25.1
>>
