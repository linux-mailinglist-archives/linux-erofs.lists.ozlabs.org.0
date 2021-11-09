Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812E44A7C4
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 08:43:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpKjS06H2z2yPW
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 18:43:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636443820;
	bh=9JdE2ZBtNj0S4npA8iFstWw6QHus87geSkOYZDmLmdA=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MHkD5aDrcn+AAdBy3/mPB4rFcGu7t+rFRoYM/MzO7+rfgi2oGpK29awDgb+R5Npn2
	 JWEq28pSXVd34CazgcAbpqzLHrPT9if0pzryFDk8XmTsE+0Gh4S9McK60K5DeeNtmZ
	 17qdc8g9HflYjj6KwvRxf6gnfAIfWzpK58bRBnSuEzCBTjgWQeYavga10TV+Ht0dho
	 n/2zFkHmSZmGEQaFn6n6XMISdA+SRGmiPAW62SQvchoJX+sT72LgscEdvNsHtu8zLl
	 zNUz16FEZhHPawF4hDAeUQmeU1Mi972FVj1Lre6sbuCelJLliAcUdxUg1Hto9rQhfD
	 vXtPWVlixoObA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febd::618;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=lor4fU5x; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febd::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpKjH42nwz2y7M
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 18:43:30 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWOgkh/HFaSCqCXNszdcDYJ1h9gMzppr8g8HxcDKeth5dUqXBEy7j39grtfJaMftXVOHfmON2c77kWUHPMotZKZZSDpZ6BJ8dd3VZ+/nLOaM6W8785o7tIgmnkEUCtQZma7K+lbi56/7mDEfCrzUatCSx86AdGTvxrHFB6SP6557kjEdPfUujrKj5zvUFyHKr7sKkeUXXf/cs0rovaOB9epv53+ZmXRGq4aXVj0kIjcCsgKUil8VQnNz1AooZjMsLIQ1Kjsnox15nr4kGdaKEhgFEBKOJowIpvFbQXYJ7JvwdWuFCdXSvQet4zVbVUMC7RImdWCmgqI25qLTK6zwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JdE2ZBtNj0S4npA8iFstWw6QHus87geSkOYZDmLmdA=;
 b=IdqcDtvnlOKKJ6qIW0/X3+cFfzgPoRUnOSH6KP7XNfVAZHgkeghss2mCGp68lg8eDXG9natOvFkqoaaKDobtyt13LlvVg88tQLhPk0O9DJolfKcY4dmpAy+LcLedFsoaQ6BwqR1Sc44JDG2wAhoR8dZ/jGHt96QGUOyn53KbW6woFkEXWRba3Z+SFDy0jGdWWqbnEH44bsVbDSpovTsxi7Onxwy5btA/cIQPri9JjtoP5j3MbIvUdxHQ42qy0iA+YXJoGbRv/JSaMY/j098tc9BQmizhS+nPHjk7kf9Cm4Ud9qAsh8iX3rhgMCoyl02nvhQBDPZCPS/cb4xBG/pr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4024.apcprd02.prod.outlook.com (2603:1096:4:89::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10; Tue, 9 Nov 2021 07:43:09 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:43:09 +0000
Subject: Re: [PATCH 2/2] erofs: add sysfs node to control sync decompression
 strategy
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211109025445.12427-1-huangjianan@oppo.com>
 <20211109025445.12427-2-huangjianan@oppo.com>
 <YYnoHw+boVFtcyfv@B-P7TQMD6M-0146.local>
Message-ID: <82f7c99e-b83f-90b7-fceb-b8436da94339@oppo.com>
Date: Tue, 9 Nov 2021 15:43:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YYnoHw+boVFtcyfv@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR0601CA0014.apcprd06.prod.outlook.com (2603:1096:3::24)
 To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from [10.118.7.229] (58.255.79.105) by
 SG2PR0601CA0014.apcprd06.prod.outlook.com (2603:1096:3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 07:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a82acf49-6d42-414a-ffc9-08d9a3549334
X-MS-TrafficTypeDiagnostic: SG2PR02MB4024:
X-Microsoft-Antispam-PRVS: <SG2PR02MB4024A363735E4ED058F5CB1CC3929@SG2PR02MB4024.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVhJjrH2sOwbkGHrY0GdgsYSuafpaslHU1TfWPIWMIU0RHD9UL6jmW8PF/jCHCofPOezTSkLVlxzcykkI+C+EDs9HY/mevQwI+sv/mD3aQe4YWayIjuSoF4VwpTQQDqpjlqp8h9ogyqMfQwSPuiA4Mgw4D5SWo9AISRb1SskY7upXqaS2ShY9/UJjejN3345i+NRW2g+sBzgo+6zPxLXiyEZAUDy2514xSkADHvAnCCYr7+vuB5Q4/lN+2GwMC5aW7LAKaNqh5z7iCR6Ma75nX6b3Y6JO8AyQvl93tJXF/OEdb4iukUEya/YlNohvN76P4yJ+Xj7FU5AHBrqDLyMC0WNlluMw62TEoGDsFnGpYWKSkQyPL1Ej1Wkc/Mc22F4ee6+/Ezzsd/ZpafmjvO7Pz3bCJ9+boYGJfSrY5We9To2db5BAyHvP+NnxuaVLkhDYFhHgwhKJqrJcxQBPjkIlCvPFX6CbEOaS4IVbHcaHRyTiTKh8TIzSOtqoaqFuGJ7U4SALMM43f+GhEPhJi6NXU+/kJXCtgU3rM/UZ/aYVr4gF+vrcsWgrzxcBcLFC8IdGbuipYQD1kMFnjEuri3rELiHXmbBwwja6m1XXUSfy2r9whmR3hH+VcMJQ0qdmqUU8LqSAkWoBTgFXFSe9AjMY0FpXFwAI9ugWVHQObNog3SMHBHBC2iEN2nE9gF4Ha+xKMgWt6szB7SbK6fip0TF6DO4quUNYglzVe0GLFqzDFpDgCCw1h96hPWhvmI30KPmxhTBnBzNrica+Xvpd42Pbl/4BZPFHdwccfQhtq2XnEHPij/ZH8b6YvqxOeKhVhVbjiJLsnaigP6o8j+z64ZAh6hq2I0RwDGngxrzJmqL8YbFERfMYqQinWYaYPrOXFpm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(107886003)(316002)(6486002)(38100700002)(38350700002)(6916009)(2616005)(186003)(508600001)(956004)(16576012)(66556008)(26005)(83380400001)(52116002)(86362001)(31696002)(36756003)(66946007)(2906002)(8936002)(31686004)(8676002)(966005)(66476007)(5660300002)(4326008)(11606007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldCR0dLc1JOcG1sNWpkMzlyamVLbmxxcnFJZVlQOWNHT1N3MjZlVDU5VE5E?=
 =?utf-8?B?UHRQWWtCZXovaXZuRFlyWFI2bUdGb0lTc09LKytiRDJIbzdUSFQrWHZSUjc3?=
 =?utf-8?B?MEZOYU9hSVBrRkwxYndGMFdyQ1pIWnpVYjhRazNIaHB1OEtwQzZZaGsrVGZQ?=
 =?utf-8?B?REI4eStlcVZjYzFRYlJyNGxaVXc4VkhVTlNrODZDaHdjSFV1amlTYi9vRTVI?=
 =?utf-8?B?UmRpWkh6MzNDc2VnOWowSnlha0pXMVBYd0F2OTJGUUs5blF0Nld2YWlWbjgv?=
 =?utf-8?B?VVJydnAyQTFaR3EzRk9KcUhPUnQxZThNQXlFZDFkSGJpdHFGZEEreVJ5STha?=
 =?utf-8?B?bnppUnpYMVJDam93QktaTHd4UjNFR0JTNThpZTBPWlJCVURjS0pDdXlwN3FQ?=
 =?utf-8?B?Y2RHUUNHaDRKZmNSSEhvN094Yjc2elY5aC8vM2tnZno4WjlJSHRxOFY3WVBk?=
 =?utf-8?B?MWl1TXJGbFk0NE05OFhVTXNNT2JJWVhtdXU2Nmw0dHJkVm11NDNCKytUazho?=
 =?utf-8?B?LzJGSDkyZ3JSbE1hOE03eThNV1BZTDB2YnAzeVZwejQrMmVDN0ZoSFBYZlpB?=
 =?utf-8?B?cVhIQzhIUGNBMHUrUVdqQ05mc2VlYlhhdUlzam9PaWo3ZmFJOTYvRWR5M0ho?=
 =?utf-8?B?aDNabjFOaFphdVA0V1VLdXRhbVpTdnhoR0Q0WCs4KzR1Q3pScXRBWDA3ajM1?=
 =?utf-8?B?U1NGVlRFZC9nWGowNTlmaTM1Qy9VQVVxMEVXK203S2NUdUg4YlN4Ymo5eXJp?=
 =?utf-8?B?a2ZJRERoRmtVS3BRb1FLOFBiS3BHTFQ5ekhZbGpBSnl2ak10YU5kZ2JJRzVr?=
 =?utf-8?B?eDhhWjlRRTZ4elJsVVlmV3pJRzBuM3VtYXE4L3R5ZW1qLzJONzkwVEZubmQz?=
 =?utf-8?B?cGNTTEdKeEg1MGpmWitGWmRlaVhnaEhDaUE5NEx2UGIyYnZ2WE5KTUc2TnBN?=
 =?utf-8?B?Rm8wTWZLLzlDK1luRXRFSU1VYk5tNm5BN0tqTFpmeklwbERBNDA3bVJJclFF?=
 =?utf-8?B?N2tMSGp2bGZUb3QxWC93T2VGaUpUOFpDOUc1UmRTWFBQSVFyNWlnWDhRWmFR?=
 =?utf-8?B?eURNbGhQdWxra2xWeGZqWjE4YXgxSk82Qm4rd1h0ODZsRUs5enhaZ3RnelNI?=
 =?utf-8?B?QXVyLzgwUmdJR1N3b1p4bTU1c1J5SkRpZlNWdW9JdTdxY0tQUlRhNzVWczd0?=
 =?utf-8?B?dm1zRlNRd1NaYVdybmdYMlYxcm5sOGg0WTg0dTZsbmh2U0RtZHlpS0hZempL?=
 =?utf-8?B?N2JqUGFPZjM3WmlWWnF0d0puV01vdXRCUTJ1YmtiOUFGL2pydUpjc2QzajVv?=
 =?utf-8?B?OGtUWWxBNTJ3SGxHeHU5bmwrcUlVdVZiZXJlL0hEWVVTRkRqQ2UzUDgvZlBs?=
 =?utf-8?B?ZDhVZVUybWFLbENFRE9ldTNlaXpDRFMwaHdXWnI4WXlQNDFBSzhTR3UwRjkv?=
 =?utf-8?B?clM4c04yM1gzamxBMTBJT2ZBd1R1QXFMaWhtcjRVWnhoSDlUNWxYVzZsMFMw?=
 =?utf-8?B?VG8yMU1HUjVkTUwvanFLYkRXOWdEbzZnZVdrM1Z1cmY3VStLbVZHTFZaRTJ2?=
 =?utf-8?B?SGY0a2NMREFwdWROMFd2aGpNVDUrQTdIT2VzZEw4MERwa1pvMGNDVUM3SmdJ?=
 =?utf-8?B?RU5zc214TEJxTUhmQ29XZnNOdDZSKzJ3R0dka3Nxa3lqKzNmRFI0M1hkZXNo?=
 =?utf-8?B?alEycGtXNkw3U2xucC9PMHJJWVp2bXNPMWpMZFIvRWlrSUsySzFBVXhLbVIz?=
 =?utf-8?B?OGk5V3pZcGlaRk9HTFVEQTlsM2h4a3JnOEtDcjBSdUlEYk9GNWsrUk12dVV5?=
 =?utf-8?B?ZlA1ZW1DM3UzZVd6UERkQzdUbGkzbTkxTisvaERodklHckEreThRUlI3WHNT?=
 =?utf-8?B?aTJjZ3ZVSUNwZHlwRkFPNFZ4Q2pOU1lIUm9EVEl0VDl3RzZsUERvQnJLYmh4?=
 =?utf-8?B?OGVxNlhPekdSSkVQQ08wUHJhRG9rR2hZbGt4eHRqbFVrYTBjMlBVLzVjMmYw?=
 =?utf-8?B?MFZnS2RKbzlaU1RIbG5JTVVGeldIS3dBcTh1dXYydmI5aTh2cVBhWHdDVkpL?=
 =?utf-8?B?K3NxT2IrWUxGQ3B2amVZTG9kenRBR0oyVUJESHV3T3FvMURiZHlsS3M3ekRM?=
 =?utf-8?B?RkxmRzBNRmN6bVYwYzVWZi93UmZVS0duVlBQd3NHZUVRZTEwYkora0EwMXVo?=
 =?utf-8?Q?w0s5EBAlVHlo0OAtconWeZQ=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82acf49-6d42-414a-ffc9-08d9a3549334
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:43:09.2819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGIItg4I9tTVhHzoeaaZEwZC9OiG7XNaCmKNtEpGC1I+Biq0BtNEbGhT7gG70SAsDCTjVES95zEkh2eKZ6joIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4024
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

在 2021/11/9 11:16, Gao Xiang 写道:
> On Tue, Nov 09, 2021 at 10:54:45AM +0800, Huang Jianan via Linux-erofs wrote:
>> Although readpage is a synchronous path, there will be no additional
>> kworker scheduling overhead in non-atomic contexts. So we can add a
>> sysfs node to allow disable sync decompression.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>>   fs/erofs/internal.h | 2 +-
>>   fs/erofs/super.c    | 2 +-
>>   fs/erofs/sysfs.c    | 6 ++++++
>>   fs/erofs/zdata.c    | 9 ++++-----
>>   4 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index d0cd712dc222..1ab96878009d 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -60,7 +60,7 @@ struct erofs_mount_opts {
>>   #ifdef CONFIG_EROFS_FS_ZIP
>>   	/* current strategy of how to use managed cache */
>>   	unsigned char cache_strategy;
>> -	/* strategy of sync decompression (false - auto, true - force on) */
>> +	/* strategy of sync decompression (false - disable, true - force on) */
> Please leave false - auto.
Agree.
>>   	bool readahead_sync_decompress;
>>   
>>   	/* threshold for decompression synchronously */
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index abc1da5d1719..26585d865503 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
>>   #ifdef CONFIG_EROFS_FS_ZIP
>>   	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
>>   	ctx->opt.max_sync_decompress_pages = 3;
>> -	ctx->opt.readahead_sync_decompress = false;
>> +	ctx->opt.readahead_sync_decompress = true;
> Please leave readahead_sync_decompress = false 'auto' by default.
>
> I don't like .readpage() applies async decompression since it's
> actually a sync way, otherwise, it will cause more scheduling
> overhead, see:
> https://lore.kernel.org/r/20201016160443.18685-1-willy@infradead.org
> https://lore.kernel.org/r/20201102184312.25926-16-willy@infradead.org

Maybe consider adding a disbale strategy? And then we will have:
0 - auto, 1 - force on, 2 - disable
I will try this in the next version.

for .readpage(), If the decompression can be done in a non-atomic context,
there will be no additional scheduling overhead? In this case, we can 
turn off
the syncdecompression.

Thanks,
Jianan

> Thanks,
> Gao Xiang

