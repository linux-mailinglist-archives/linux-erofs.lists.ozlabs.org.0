Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2165444E1C5
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 07:10:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hr7Vz0ht8z2ymt
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 17:10:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636697451;
	bh=/ExuPUeRjS+qq/7blUhKqB6Ey9sGInQI+h9dhlx4xfI=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=E8gmdd8XQALCEYqNnYpoQIRLxHFoOc+ameUMcP0DI696uhabWjJRHaJ/2KXxWkO6+
	 Sdcxa/qs2MVOygqvSO3BhzzQwuRcEW/4Qt8VekhNPsGZrZiCOCa9H2hXzGPMgZ4qhn
	 2Fk0DOnb8F2bvmr/R3AzzWOTmkbDqczrzCwsBIAhiqJ+45uQeDFnEH3OuSqjGcATNd
	 p4h+RmsS5F9V7vJO7z7lF4551Rd35kG6xllYSHRC4UXLGWkRRnKcLTkDoN3TbMVM55
	 Yos9hZqkGQipwYEFX7ogV9aOHZS9zLKX6df/6XAfhxyCPMjzNVJfROPk+xqEmjHUQy
	 3q2It4W4/o86Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.255.78;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=BPcrOG/B; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2078.outbound.protection.outlook.com [40.107.255.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hr7Vq1Blcz2yNY
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 17:10:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtwR7Q/eKsu3lv63C+K3H9Pz/5Z8k81l/yLd+bpHNANL3x0kSThXBkn52lYRnw2uxBv1amNUiSjfS560Zjpq8l9Uo40NDcn89mzIbTjMm+o7BrqJ2KuvHax53GFv9BT9Neg8YSq9iDSB/2Ehbjikk7vGmn64kbGu3GYkB050GB3thJRmdEXV9Fv9S1YOoW9d4l4K2bGx/4fwJ4cdUj3FvobP6i0d5re8wNZIlFR1+6CC1bUz9Ttl4u1wnRz1+rG0CANje9m5XICy7HZ8x+LgAmIZk2GfSiEeTl2qJEmszpN4k+XLw2H9QMjbuDp88pS5Vs+kSYEm4JDQoStFEEebOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ExuPUeRjS+qq/7blUhKqB6Ey9sGInQI+h9dhlx4xfI=;
 b=bkxWeUzQ6SaBVD8vx5aTg8AvUsj7D9PqHsilCkz3qI9471d2rL4k3s9vSaxUSeAQK5Uac6NMrqZ06Hs3v1mjMdl8H3TerULyKsAZBSa4ZY4qVcQG8aY6/iK62xTtHYRDuKtn24NsDIwItAhUBtGBT3pkPOLV4+OB/XI3WTmf15ePKGtb3eG7KOXd3Kfxmwag2ugr2ngYcveCaZPw0GxgySiB2Ao7DCPpOpgTutOaDYUU8mAeyLx0KuD83NE3Hi25w5b0MVJW+APkJz0nSMzQsjw+zK3+KNzxlB0uHLmDCiporpEtffJ3f9+C8bTQJsWQGLp5NMRaMJOuTnoH1afokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2986.apcprd02.prod.outlook.com (2603:1096:4:5e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.15; Fri, 12 Nov 2021 06:10:22 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 06:10:22 +0000
Subject: Re: [PATCH] erofs-utils: mkfs: add block list support for chunked
 files
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 David Anderson <dvander@google.com>, Yue Hu <zbestahu@gmail.com>
References: <20211111053031.4002774-1-dvander@google.com>
 <YYy1Yr1cudpnqqfh@B-P7TQMD6M-0146.local>
Message-ID: <5b16c1ae-f468-6dd9-1c11-f7fb8f6331cf@oppo.com>
Date: Fri, 12 Nov 2021 14:10:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YYy1Yr1cudpnqqfh@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from [10.118.7.229] (58.252.5.73) by
 HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.19 via Frontend Transport; Fri, 12 Nov 2021 06:10:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4dd4e62-786f-4533-6b49-08d9a5a31bfc
X-MS-TrafficTypeDiagnostic: SG2PR02MB2986:
X-Microsoft-Antispam-PRVS: <SG2PR02MB29869FF410E7FDC0CCCC9F7DC3959@SG2PR02MB2986.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZJXDaA+bN8TOB7EA4hH9EHcDgW6JfHtYcbXQ7Yvp07ihY8RVmG4wuR1k9dqMDuGJE+vg7XnAQkxS3HKq9yviu+Y4g1uJ4zsN72/YQYBtB8de32n4Kp+NEQBUUPVsA/BV5sF7Z6fv8l1fMM4GxkVf+XeTDcSioNAmU+Hr2L+OmSjrOFqVfYXuaI/Oux4WEV5qL8Yy78oXLr67AXUR6icSx6W41j2oRFhZndFRXzokZqlZXnlVjf5mrmkGc+lhhoEPvZU8C3akUDOloiMtLXQ4U4UXJtYlZPt/iUbnHtxRRm0aCMAmJTBZKrINWcYAk0LzkYbMSfC+cE1dhippvdrBgrj5rXqaZadpXJ2ktxjdAka6+nSy1q2m5EyAvsZxWXYc+owpK7wPVDhp1Iiki38AtZPLxM3U33fFn0WDxOG1m/SYxHx/x5LVTsVVBoeNI+rlt85QavFVp6PgghAEr+OLENRGTJkdp1oNpQDHy+7G4WJCXMvAzmUKFQxeWpoW1E0VrlZKNTX4ax071PebDTmDLprpp9EzyTmX4jYFCjqMFnbv7TG20xiYEY0T6phzkl/Dy/IXzWAtegfK9gRdb4A4XsnmagpDx9+KBIPQ1yW1geOm7YD456hh/X8r7j4qDR6IcCi2zTiESeYRvGFvNR33ET31+Ms1Cc+M1LYlzhb5tB5KJs0RqQP6J+rBtSsxu6o2FbRIQ6cl5yvTQps+HyM7siwADe7V46QybrAjG/fOESnRmB+5N5wZIktL8v2uoysY3Aur1pid9VghXwOsO4f63pmWRZ5p/SG1kX7PmSB5pM4ZMYzEKOAODoPfD9Oel1i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(52116002)(186003)(66556008)(2906002)(26005)(36756003)(38100700002)(16576012)(66476007)(5660300002)(66946007)(316002)(83380400001)(4326008)(86362001)(38350700002)(110136005)(31696002)(31686004)(8936002)(6486002)(956004)(2616005)(508600001)(11606007)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXJ0anp1bkZLWURYdU5xRzBwMXlFS0VqTTdrM3lnY0tSTFJhaS9xdTdrTDhJ?=
 =?utf-8?B?aHgxM2xodFFRRWJIeUpsWDltcFBBblNyaXBYWC9OQlIxMXY5emk5RDdLVEh4?=
 =?utf-8?B?K2RVZ0lwUnQyZjFNMmhGTkdObFNmbFRvc2JKOG5YUU10M0hZa3JaY2laSVRz?=
 =?utf-8?B?UWFrT0MyekRXeklVd0JmLzRPZ290WlN4aC9ERm05ZTNUUkhZTTQ1blNiUUJm?=
 =?utf-8?B?VjlkMVkvKzgrcVJsL1Z3T1NrNm1ETE5Ebm5aT1g0SmVBOU9lb0RobjgxZE9J?=
 =?utf-8?B?TVkyUzNlNHFLNjNmM0ErcDB5N3FZR0hBZWMrUXBKb280V1RyOHBaR1dqQVJo?=
 =?utf-8?B?bFEvZnVUVWxkS3RqNnN1clgvN0dnRzk3MU0rcFk5TE8wMVk4N0I0dU1JMENX?=
 =?utf-8?B?ZWp2a0Y5bGVIQldRWnJiT1lLakpnQjh6bzBZWFpBTm5BUm9XNWFMYkhzcEJD?=
 =?utf-8?B?ZWZmYVZkWGNnV1N2S3k0Q08vK3kxUndyVU5lVUFLa2pRMGgrTkFkUllMQ0tE?=
 =?utf-8?B?SkgrZ0F4VHVCVy9ZTXNKR3VMaEt3blpKQzE0aU1CcFNDdHBMMW1vL3Z3b3dh?=
 =?utf-8?B?TEdhaDFqeUNadk1oWThGWS9NT2RLSkVQNDAwU01Cc3lheDczK3NDVmxlV0Z5?=
 =?utf-8?B?MjhWUDQrN0JpSm9mY2ZKRGlrUDNuV1Z2dlVwU2dOVG45SE9WVExtZ05SbFkx?=
 =?utf-8?B?UmtGNm5zaHpHVWE3aVV2TkxLY3d2OVF3Z1hlTEdRNjRGa0hXNitweHQ3R0pB?=
 =?utf-8?B?Umg4dzFILzV3dkE0L0lSWlA5NlRyajJVc3Vxbm5TZTZGcXdyQnFRSER4OHZv?=
 =?utf-8?B?MFE3ZGpUSjZXbVF3NW0wS2JzNGxkNXRmRHJCMEVFY1pSMVdJY1pPekwxa0RD?=
 =?utf-8?B?cElNSVR3N015aEtKWkFCbVBlaEFjcC9mRk1tSjhUN2xUc0hDYW5OQktPRHNj?=
 =?utf-8?B?MzJVY3U5MGJnOU9sUVEwdmRtU2M0bktLb3FMSHptQVR4V1YxNVl4WDlGL3dL?=
 =?utf-8?B?aW02cXIrTkh5Rytib09qc3NzNmR1R0JSYWpYM3kyRzFtcmhPS1BYUDBscjZE?=
 =?utf-8?B?UjZYdGQ3ZVcxRTdJMzdWR1JVcTl3d0pKRG1Ld0ZVZnhZZ0EySzhuTUEvck1l?=
 =?utf-8?B?dW9hV3dTR1B3bjlQbHBRNm5pWFdSWjNMaFM5SjM0MTZacGZqbGdNVllVa3Z1?=
 =?utf-8?B?MkVHTTBudEhuQ1Q0VC9aRVByS0wvcHdPc25EdS81RCtlbnJPWU1ERXVZKzl3?=
 =?utf-8?B?SFpwcWFFelBVS0pWN0toVmdUb0pzUStabU9nVzJLanltdnZxeEloZUNCQnVq?=
 =?utf-8?B?cXhxWjAweUFZQWJ4QUlVNjV5Ym1ERG9hbkpsRVFSTGNjVDIwb0dOZmhsVFZ5?=
 =?utf-8?B?TU43dzBYeUhWZkt6ei9kQWVML2hLUEpicnExUWtoMG5VYjk1Tk8rZTRSVHVw?=
 =?utf-8?B?Q0lqZ0tDR1RCaC9mWHVXSVd5TStrV1k2SVBWWFc0Yjl3ZjZGVVFBdXVib3VP?=
 =?utf-8?B?R21vMWI1Q3FhRWNuNUZjUUZuUW41TFFyNjh2VHpZOHd5dFNITmxjdVRrTC9t?=
 =?utf-8?B?MlIyU3BTNEM5RjRrVjdUNHJEeG9XWkp4VEZaMVJoYmlHSTdnaVdLUDFwbzZk?=
 =?utf-8?B?WHRCdk1UMjZ1ZWViWC8wSnhMSkJiMlQ0SWZuK3ZaY0hySisyWFg3b3Q2WnVn?=
 =?utf-8?B?a3dXQTlrWXM2eExpMXkzKzliRitiQVdnaXlSR0RkN3lCdi9sYTl2dmxUdzFr?=
 =?utf-8?B?dGJmMk4vVXVQR3NNOTd1UW9zdnNoblcrVXkzQk1RMFVhNUh5RGlPUHVzL3da?=
 =?utf-8?B?TEVpUmRZTHZvdkxjQUdVeE10ZExCVzlIb2JNV3B0RzZzaE90OSszWWRtY0Qz?=
 =?utf-8?B?Y3lkMysyWnBQakZqVmRqSEFORVg5SFY3TDc5aVZ1QTViQ3NpZlV6VXFyc1p2?=
 =?utf-8?B?c1Q5eXV3bmM3azd3bllNcE4xZFhaZjh3OTNDZE1GbmJFRE5scmxmcGlBQWFJ?=
 =?utf-8?B?dllGQm1halc3UDZzK3NNMDR6Z2tncTAyWXBoNVMzU2JrQmFTYk9jbTNHb3Z4?=
 =?utf-8?B?Y3BvYTMzVzlyZEk1NFk5b3VqU3lFMS9TNnlzQ0dvUWgvRVY5ZXBTTmVCU0Iz?=
 =?utf-8?B?Sjh4ZmVnbGp4Ylk0ZythU2wzOWtvNTVJR29EbU56OUsrc2NNVzUvdHJrcWx5?=
 =?utf-8?Q?+cEmpaTvkoFGsgnWnTa5fP4=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dd4e62-786f-4533-6b49-08d9a5a31bfc
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 06:10:21.9094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exIPv8L822XHVhLlhfKKzcObfrdjWQRgxIGFv18JrNqXSQiMjSzsBm4+aDdRuMZcPzi04Fuo3h9nuGONvZ6ugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2986
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2021/11/11 14:17, Gao Xiang 写道:
> Hi David,
>
> On Thu, Nov 11, 2021 at 05:30:31AM +0000, David Anderson via Linux-erofs wrote:
>> When using the --block-list-file option, add block mapping lines for
>> chunked files. The extent printing code has been slightly refactored to
>> accommodate multiple extent ranges.
>>
>> Signed-off-by: David Anderson <dvander@google.com>
> Thanks for the patch. Currently. I don't have Android environment at hand.
>
> Hi Yue and Jianan,
> Could you help check this patch in your environments as well and add
> "Tested-by:" tags on this? Many thanks!
No impact on our build.
Tested-by: Huang Jianan <huangjianan@oppo.com>

Thanks,
Jianan
> Thanks,
> Gao Xiang
>
>> ---
>>   include/erofs/block_list.h |  7 +++++++
>>   lib/blobchunk.c            | 27 ++++++++++++++++++++++++-
>>   lib/block_list.c           | 41 +++++++++++++++++++++++++++++---------
>>   3 files changed, 65 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
>> index dcc0e50..40df228 100644
>> --- a/include/erofs/block_list.h
>> +++ b/include/erofs/block_list.h
>> @@ -15,11 +15,18 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
>>   				 erofs_blk_t blk_start, erofs_blk_t nblocks);
>>   void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>>   					  erofs_blk_t blkaddr);
>> +void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
>> +					erofs_blk_t blk_start, erofs_blk_t nblocks,
>> +					bool first_extent, bool last_extent);
>>   #else
>>   static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
>>   				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
>>   static inline void
>>   erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>>   					  erofs_blk_t blkaddr) {}
>> +static inline void
>> +erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
>> +				   erofs_blk_t blk_start, erofs_blk_t nblocks,
>> +				   bool first_extent, bool last_extent) {}
>>   #endif
>>   #endif
>> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>> index 661c5d0..a2e62be 100644
>> --- a/lib/blobchunk.c
>> +++ b/lib/blobchunk.c
>> @@ -7,6 +7,7 @@
>>   #define _GNU_SOURCE
>>   #include "erofs/hashmap.h"
>>   #include "erofs/blobchunk.h"
>> +#include "erofs/block_list.h"
>>   #include "erofs/cache.h"
>>   #include "erofs/io.h"
>>   #include <unistd.h>
>> @@ -101,7 +102,10 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>>   				   erofs_off_t off)
>>   {
>>   	struct erofs_inode_chunk_index idx = {0};
>> -	unsigned int dst, src, unit;
>> +	erofs_blk_t extent_start = EROFS_NULL_ADDR;
>> +	erofs_blk_t extent_end = EROFS_NULL_ADDR;
>> +	unsigned int dst, src, unit, num_extents;
>> +	bool first_extent = true;
>>   
>>   	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
>>   		unit = sizeof(struct erofs_inode_chunk_index);
>> @@ -115,6 +119,20 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>>   		chunk = *(void **)(inode->chunkindexes + src);
>>   
>>   		idx.blkaddr = chunk->blkaddr + remapped_base;
>> +		if (extent_start != EROFS_NULL_ADDR &&
>> +		    idx.blkaddr == extent_end + 1) {
>> +			extent_end = idx.blkaddr;
>> +		} else {
>> +			if (extent_start != EROFS_NULL_ADDR) {
>> +				erofs_droid_blocklist_write_extent(inode,
>> +					extent_start,
>> +					(extent_end - extent_start) + 1,
>> +					first_extent, false);
>> +				first_extent = false;
>> +			}
>> +			extent_start = idx.blkaddr;
>> +			extent_end = idx.blkaddr;
>> +		}
>>   		if (unit == EROFS_BLOCK_MAP_ENTRY_SIZE)
>>   			memcpy(inode->chunkindexes + dst, &idx.blkaddr, unit);
>>   		else
>> @@ -122,6 +140,13 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
>>   	}
>>   	off = roundup(off, unit);
>>   
>> +	if (extent_start == EROFS_NULL_ADDR)
>> +		num_extents = 0;
>> +	else
>> +		num_extents = (extent_end - extent_start) + 1;
>> +	erofs_droid_blocklist_write_extent(inode, extent_start, num_extents,
>> +		first_extent, true);
>> +
>>   	return dev_write(inode->chunkindexes, off, inode->extent_isize);
>>   }
>>   
>> diff --git a/lib/block_list.c b/lib/block_list.c
>> index 096dc9b..87609a9 100644
>> --- a/lib/block_list.c
>> +++ b/lib/block_list.c
>> @@ -32,25 +32,48 @@ void erofs_droid_blocklist_fclose(void)
>>   }
>>   
>>   static void blocklist_write(const char *path, erofs_blk_t blk_start,
>> -			    erofs_blk_t nblocks, bool has_tail)
>> +			    erofs_blk_t nblocks, bool first_extent,
>> +			    bool last_extent)
>>   {
>>   	const char *fspath = erofs_fspath(path);
>>   
>> -	fprintf(block_list_fp, "/%s", cfg.mount_point);
>> +	if (first_extent) {
>> +		fprintf(block_list_fp, "/%s", cfg.mount_point);
>>   
>> -	if (fspath[0] != '/')
>> -		fprintf(block_list_fp, "/");
>> +		if (fspath[0] != '/')
>> +			fprintf(block_list_fp, "/");
>> +
>> +		fprintf(block_list_fp, "%s", fspath);
>> +	}
>>   
>>   	if (nblocks == 1)
>> -		fprintf(block_list_fp, "%s %u", fspath, blk_start);
>> +		fprintf(block_list_fp, " %u", blk_start);
>>   	else
>> -		fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
>> +		fprintf(block_list_fp, " %u-%u", blk_start,
>>   			blk_start + nblocks - 1);
>>   
>> -	if (!has_tail)
>> +	if (last_extent)
>>   		fprintf(block_list_fp, "\n");
>>   }
>>   
>> +void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
>> +					erofs_blk_t blk_start,
>> +					erofs_blk_t nblocks, bool first_extent,
>> +					bool last_extent)
>> +{
>> +	if (!block_list_fp || !cfg.mount_point)
>> +		return;
>> +
>> +	if (!nblocks) {
>> +		if (last_extent)
>> +			fprintf(block_list_fp, "\n");
>> +		return;
>> +	}
>> +
>> +	blocklist_write(inode->i_srcpath, blk_start, nblocks, first_extent,
>> +			last_extent);
>> +}
>> +
>>   void erofs_droid_blocklist_write(struct erofs_inode *inode,
>>   				 erofs_blk_t blk_start, erofs_blk_t nblocks)
>>   {
>> @@ -58,7 +81,7 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
>>   		return;
>>   
>>   	blocklist_write(inode->i_srcpath, blk_start, nblocks,
>> -			!!inode->idata_size);
>> +			true, !inode->idata_size);
>>   }
>>   
>>   void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>> @@ -80,6 +103,6 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>>   		return;
>>   	}
>>   	if (blkaddr != NULL_ADDR)
>> -		blocklist_write(inode->i_srcpath, blkaddr, 1, false);
>> +		blocklist_write(inode->i_srcpath, blkaddr, 1, true, true);
>>   }
>>   #endif
>> -- 
>> 2.34.0.rc0.344.g81b53c2807-goog

