Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 58752322403
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 03:04:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dl2Rj1h2Nz3cGv
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 13:04:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614045873;
	bh=IomwmDQy/iueeu6n8WCqpXPkNGxbg92Rzc5f9xSEIec=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kBX2O/EiVD5BIAJvc1cieGEh1JM2kJsb80vy85vk3Tn12f313e5Y6vg7XZa6ZKXKp
	 bOWLsSdE0Cp4jqF+ibDclN/SMyaO6NJiLx+91lPJ06ALXgWJjdBmOmiy2hAXuwU3sA
	 R/xJaDwRFkYvIrWT4SBuEtcaeFsWAAFS2HRKtUydeK21UCy+y69UqRqX62e6213w8T
	 vzBR0zJDbdo3ygB9VEnHmLvxfKIfMO0xtgz9vivtiF5oYuS3tdJ2i9t9aD8M8kriIo
	 TV3VzmfxUFKYyesKUdWhsFwQjVG92+lHvYbbs6Yu2T7E1WxmPQEC/6Tm88ZLzvkt7h
	 g6Jomn6zCPjtQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.55;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=pgwT6maf; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320055.outbound.protection.outlook.com [40.107.132.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dl2Rb5fKnz30Qx
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 13:04:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htnIcd4dHN6oDNpmr9bW+EfA52wI5lmFYdHgybzMp54USRRAYCxrLEzey5n894soM37wpY83X6uWR2Zqp+DRz7FkAyJDVpHZgoq2HcoF4ipaY8zwIQXxl0HxnLQUhplZ2yBBIYFJmkK2YP7wdQWJA2ZRNwUcuH6QP7gp49PYY7+sviytfKlAulqvpz7EkUwO+TF15IxkWMNOl3zCoZ73Lc6s92acg9gEiu7o7lwJnpoUnBpWWi90FqlOE8hhNq9ELYG2pds6JiSqzT/bKugNGlXSOymOxQjxQCS4P6qUt3pTqvt5+L0CjdvlOnrDGPynEU5SIuHL49cXd2Pc1xxf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IomwmDQy/iueeu6n8WCqpXPkNGxbg92Rzc5f9xSEIec=;
 b=XkkyZ9wHt5v439O81uGJ9w/asLV3bqX8Mb+Vt5DvnmsxUB7CaThl+1aOuVz4zMRALqQVU7E10znVOpG25WClEwAB/2njJp/AevHrSZEHWiS96qj6HLbPjzVH4aqzHhZDB4iFu+UEmu3VSCChGK7YZZXU+Rfj3wq2G56hfdOEBrU6RfVsxS8VSjEg7Z3G4XUonIaSG/EAZfN2Sav0n7XEHfSQVR5CbGh9gj2+iVl/NTFZ0uFpqCw89kG2e9sP8KT9/+VAb4/eRVKSL3nO0LrL42o/euUhwmePJXqgdIHRN20wuSgOSvsXa8cpUvEDxMCFRyHpZZAhR1m1TLXGUd9F7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2095.apcprd02.prod.outlook.com (2603:1096:3:4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27; Tue, 23 Feb 2021 02:04:06 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 02:04:06 +0000
Subject: Re: [PATCH] erofs: support adjust lz4 history window size
To: Gao Xiang <hsiangkao@redhat.com>
References: <20210218120049.17265-1-huangjianan@oppo.com>
 <20210222044410.GA1038521@xiangao.remote.csb>
Message-ID: <11afa9f6-109a-c660-1664-7a596d6836b6@oppo.com>
Date: Tue, 23 Feb 2021 10:03:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210222044410.GA1038521@xiangao.remote.csb>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK0PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:203:b0::26) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.255.79.104) by
 HK0PR03CA0110.apcprd03.prod.outlook.com (2603:1096:203:b0::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 02:04:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbf04914-b4c8-493b-d2e3-08d8d79f4c60
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB20959FD1A07F8B56F40FAA97C3809@SG2PR0201MB2095.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjQyV4J15Jy0Quo1dJtgL0+/6/2ynaSFaGemxkWxwSOiQLEHOyn6pXCVW8ajHjWKm1s9YuSKT8jLCmNgFO6dM4HnrQ2EqKfrIKP6VxrwkhHfqcEzvchPiQ/1hp2dDTGC6rzf8KFk+Hi99npagKf5OmrLmQrbIBIuXZs4DtTtpXIm7cziNEWBQoyJreh1/VmsJkbKBlpCpvi2UHk/2RCWLZ4T/+R9/OfWVy6Pmy0ddLsyDXsgggwm/Duii7WFWb5HyKMuYBBu/T3x27lnU6rl0VMVdrmYw1lGZ/zmDGAUiHkQTQndtTPfdWxp+CvwN8gLeB22FXvraOYrI/tRy0LFUxU7TCed/ruyzPXVAz65ABvTDjGgchDGLTWofc5o5NpEmWbrJoPWkz2GN9ZdwFt2C9USLNtsk6efIaIOO7opP9RuoFlE6Zq3YheqsOh0JSrtNIp6qgOzzoXOUgnZBG2TfwkduyuEO/u6f6imyrMvTkB4GMFP3xp2rQNUHid3GTr1WZDanuSVuh+myrKMitOXQ+BQMIWQ4fC5hDGIXY+MbcaRaZSH8eGn1S4zG41AQgLQVcDmYd4x+QCSD7PWysx/FoGyJPsux8+xAfVP3u1L622o6mtaQMIP+sLAloCTdMna
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(31686004)(66946007)(86362001)(107886003)(66556008)(26005)(6666004)(16576012)(53546011)(31696002)(8676002)(6916009)(6486002)(2906002)(956004)(4326008)(2616005)(83380400001)(8936002)(5660300002)(16526019)(52116002)(316002)(66476007)(36756003)(478600001)(186003)(11606007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkU0SThjaFlKemtDMXlaQzJIUEZhNGJJVDYxL2poamdtOERENGdJRGMvS3hS?=
 =?utf-8?B?MFBQQ0ZocTYzQzFGNjQrUTVsUGtHVzJqWTBESTdKdTVHK01wMldtekRxL0li?=
 =?utf-8?B?WWlGM1RMd2FMbmpyQ3J3MWo3SW41M0VHUVZVVW1Mdnl2VmQ3ZW1BWi82ZGJX?=
 =?utf-8?B?Y3B6ZXUrNkg1UUM3bjEvMVlGNlNxaW1LM3k2TmszazVPd0RWeGlHcnNVRU55?=
 =?utf-8?B?cVVlbTZnMWtqU0RiMEJQeG9pUWRSWThkR3R0UFE2NFF2aTRpSFE3dUhJOW5O?=
 =?utf-8?B?VUptRVZSRFdPSVBrNFVMbG1ML08zQnJWTWdGdjRaWk5GQ1gvTEwxQzU1aElT?=
 =?utf-8?B?RHJNYkRKcDVWRWM2dWxNa0F5NURMU2p1WFgvTkFMK0dvYXFKanF5TmNNaWVl?=
 =?utf-8?B?WmJwUUlWZnArSUtuL3VvMlF3TjJxMkIvT20zVEp3RnJDOCtjNTR6ODI0QjFW?=
 =?utf-8?B?YUdNUGlSZmFYZW85MU9MWXUyalBCakE5Q3ZVQlVwWUk4bUZNY1pyWWowbGVw?=
 =?utf-8?B?MWdJMFJMazFTRGdDaFMwS0NOV0ZUMmFrK0NlLzhEaUdhaUJRRUhTclVIY2po?=
 =?utf-8?B?ZUdFRStZTFNLMC8wMjA2R0l6Y1M5MGJuK2hSR2xwYlIwRDdPR1pCUmxyQk0x?=
 =?utf-8?B?dTdVSTV5T1QvY2pPRnlVQ2J6ZlI3bDNGaEJySCs2clIvMko1QnlhRFlYdytz?=
 =?utf-8?B?YW9pMDNDR0FMdC9UTmRvMXE4N0RrN0k0VmgzdUZFTHZmQmdyZTNZaEdSQ1p3?=
 =?utf-8?B?bmVLcmVkT2dEeDc5aVN2ekY0c2NNWmlJb1hQVW45cEV5dWZ2RHJvTXhSSkFO?=
 =?utf-8?B?Rm9ROW51NU9Ma2FFbDZ4VUtlTVhsbEZWMnQ4U0MrcTN4emxBVHB6RTYvYjhC?=
 =?utf-8?B?Nlo3Z2tKdGZ2R01iWmgrenJyblhVVHVqODFHejZYVzZEZTVPbWx0UlFnMU40?=
 =?utf-8?B?WXRqWTNROEJNb3hNZEZYa2x2SW85dktFMEZDZXJINVNlZXZLVE1WREthTTRL?=
 =?utf-8?B?SU5Fb21jNjZhL05DVS9lMDR0WWFMODE4M2xJU09RakpxdTB1MlFTRWxjdndH?=
 =?utf-8?B?ZFhBWjFiL3RDNzZrT1ZnU1VXUys5TmZ6YStyTi9CTTBEaGVGV2RDVldTajZm?=
 =?utf-8?B?Smw5THpRemhqS1J6Ukp2U20yZVU2UkhBUERTa0IydnJwVW8zVlFGU0FzYkdi?=
 =?utf-8?B?SkcvcURxNVpkL3Z5TFVDVnBSalVLamVtMnF1V3Q2bmRmQTViMmtvT2xSZEFU?=
 =?utf-8?B?MnFUdnBGZUQ4bXNMZ3Nkd2UxTmROdkF5ZTh5SVJnd0RCR09sWi9yYWRMa2NC?=
 =?utf-8?B?UUY2MXNjZ2dvdWJPNWZVVktJUTRLak43c3ZsRFpCWDdTb0J6SnlXa3g0eEhr?=
 =?utf-8?B?WlRLMGsxUEd1VmVMMEI0VzhoTm5TeldVaUh2ekZWT2Q5VWkzTURZMEZubnhm?=
 =?utf-8?B?SFN4TmVXeWlnMElCb2d6UFVLRE1xazltTUFjL2REa3l4SS9TRTFuRmErK2ZZ?=
 =?utf-8?B?MXAveFl6YUF3NzU5TVFHeWd3WDZLTnpNTUI5eEo5U0I0cW1OcFdTLzA1cGto?=
 =?utf-8?B?K3hlSjdrVlNBSUYraVN2c0F3Mkw2SVliZmJOaG1peWJXUEpnU2ZhRW50cnBt?=
 =?utf-8?B?ekJUbWFocHV3S1F5c2JrbmxmK2RKaDlabFBUQlhUSDFpZ1JrTVYxZHF3VzZC?=
 =?utf-8?B?QmRYdkJwUE9pVkpTdmluZnFvbUQ3RUd6aERrSUtkaG9PVzBPMVlaNHhKaXJs?=
 =?utf-8?Q?axXd04Y0KsJhD5NtHD2uXrxnGOyxzsPxaT4Gv0U?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf04914-b4c8-493b-d2e3-08d8d79f4c60
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 02:04:06.1616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NIsZ9cqXtmqgVEE0Y1Pmd9oTu7DXu2TCS2Qe9rgzp+PV0oqNwZmI3QAwFUYldAD2lu+00SncgOSTbvbfphjtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0201MB2095
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On 2021/2/22 12:44, Gao Xiang wrote:
> Hi Jianan,
>
> On Thu, Feb 18, 2021 at 08:00:49PM +0800, Huang Jianan via Linux-erofs wrote:
>> From: huangjianan <huangjianan@oppo.com>
>>
>> lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
>> using rolling decompression, a block with a higher compression
>> ratio will cause a larger memory allocation (up to 64k). It may
>> cause a large resource burden in extreme cases on devices with
>> small memory and a large number of concurrent IOs. So appropriately
>> reducing this value can improve performance.
>>
>> Decreasing this value will reduce the compression ratio (except
>> when input_size <LZ4_DISTANCE_MAX). But considering that erofs
>> currently only supports 4k output, reducing this value will not
>> significantly reduce the compression benefits.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
>> ---
>>   fs/erofs/decompressor.c | 13 +++++++++----
>>   fs/erofs/erofs_fs.h     |  3 ++-
>>   fs/erofs/internal.h     |  3 +++
>>   fs/erofs/super.c        |  3 +++
>>   4 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
>> index 1cb1ffd10569..94ae56b3ff71 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -36,22 +36,27 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>>   	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
>>   	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
>>   					   BITS_PER_LONG)] = { 0 };
>> +	unsigned int lz4_distance_pages = LZ4_MAX_DISTANCE_PAGES;
>>   	void *kaddr = NULL;
>>   	unsigned int i, j, top;
>>   
>> +	if (EROFS_SB(rq->sb)->compr_alg)
>> +		lz4_distance_pages = DIV_ROUND_UP(EROFS_SB(rq->sb)->compr_alg,
>> +						  PAGE_SIZE) + 1;
>> +
> Thanks for your patch, I agree that will reduce runtime memory
> footpoint. and keep max sliding window ondisk in bytes (rather
> than in blocks) is better., but could we calculate lz4_distance_pages
> ahead when reading super_block?
Thanks for suggestion, i will update it soon.
> Also, in the next cycle, I'd like to introduce a bitmap for available
> algorithms (maximum 16-bit) for the next LZMA algorithm, and for each
> available algorithm introduces an on-disk variable-array like below:
> bitmap(16-bit)    2       1       0
>                  ...     LZMA    LZ4
> __le16		compr_opt_off;      /* get the opt array start offset
>                                         (I think also in 4-byte) */
>
> compr alg 0 (lz4)	__le16	alg_opt_size;
> 	/* next opt off = roundup(off + alg_opt_size, 4); */
> 			__le16	lz4_max_distance;
>
> /* 4-byte aligned */
> compr alg x (if available)	u8	alg_opt_size;
> 				...
>
> ...
>
> When reading sb, first, it scans the whole bitmap, and get all the
> available algorithms in the image at once. And then read such compr
> opts one-by-one.
>
> Do you have some interest and extra time to implement it? :) That
> makes me work less since I'm debugging mbpcluster compression now...

Sounds good, I will try to do this part of the work.

Thanks,

Jianan

> Thanks,
> Gao Xiang
>
