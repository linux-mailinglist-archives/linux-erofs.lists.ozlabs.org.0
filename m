Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA94C0D27
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Feb 2022 08:20:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K3S9f5svQz3bT0
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Feb 2022 18:20:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1645600822;
	bh=rHuaBvZHxpqkMReOCqXFVP1eevoT6i+dVG1hGDV84Cs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LNK+rYHfwits3fnNI8sKCRLmyceXqdb67keGByRmuayD1ToPnznD2Q+dDnJMEFX75
	 QK7ATJMteBiwHjuzJLDUNRBklUYXC/mrNO0XJwDNzLTWbc/zLqYof2xAKZkV5RbQOw
	 dLEgdNz8SJVDvrZ3GZwIimDt8oy4PXhrYf9MP+SP2J73WehEPZaa6Brxv45vZkAvMX
	 svLIo5PtUnvVuhAZIYYVyVLKEueTAUZsrXCr7LfParOvPo+br/ocWkVPxPtRMp2PVk
	 6tNIKIPOqBP1mD5XQLWoRsPJDaC8tNSBK0LAs3baQTSPwkurdjVAc4AD+KFI3+jSwW
	 1FLrhESnXow7A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febc::601;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=rM6mjYpF; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01on0601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febc::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K3S9c0C1cz2xrc
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Feb 2022 18:20:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdlCgUWmIliP9AawC2fOscvmD06U3aPdWvcs3VGRI2Hbrp/0GSP6cL8GD+jzwNM1gu9tjruWyHoujxu0qYNVxotWcX1qykNXjNBEG0S6g06IEnYgkyLiZ6U6wu0XvsVA67hY9+Xqfa9hCPc3EZvNEl2M/jQSoVlD3xYWp12GlkX6aLPbeORTn3M/qXE0L0xdDH7ShL/otVVhiwh4+3rcIf++YGDcHo+PElH6Je30YIH7p1yxTIuKYXoqVa4Cdsn8/10lFhUWeE+mTLOp/NpYOIW9kd0f5/81GdGECr5q8wRDTn0uW6E4I2aMpb0RqBftG02PhzeAXND/wlFE5paTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHuaBvZHxpqkMReOCqXFVP1eevoT6i+dVG1hGDV84Cs=;
 b=ZHfsE3MMz6jyD4Z6oghPS10hUDLACSCoepH63jSdCXSQa4T2+UGvoEGTzIYhTEWmqoOGWmlg/61veDu/m8SgD8iQgjSQF6fzk30CScy9mvwMjLOG/036uUTT2vSoflCWwJIlOooKoAWMY/5c60qIYHBhqM9BTiOFsPUC2FVzPqWtA5k2bcS2bo9wt9N54Gy6GB7I6xUmnS9qjB88Vn06RYuNNhjI6b+YuUzXItmrlv3dEAPjOnqUSNPD7QFv+ENBTT/vg+wGGgGox+Qi8D2CeXZLpUe8dkqHIIcdZgT+KiS8JMrTCzDRsmNjKhFsvJDQg42dTe8VcbMEcpThffTVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from HK2PR02MB4097.apcprd02.prod.outlook.com (2603:1096:202:2f::14)
 by HK2PR02MB4260.apcprd02.prod.outlook.com (2603:1096:202:30::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 07:20:01 +0000
Received: from HK2PR02MB4097.apcprd02.prod.outlook.com
 ([fe80::6c6b:1529:6aa3:6a75]) by HK2PR02MB4097.apcprd02.prod.outlook.com
 ([fe80::6c6b:1529:6aa3:6a75%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 07:20:01 +0000
Message-ID: <ac3a3fc4-c163-fa22-0946-298d030b7419@oppo.com>
Date: Wed, 23 Feb 2022 15:19:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] erofs-utils: fix some style problems
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220218031137.18716-1-huangjianan@oppo.com>
 <20220218031137.18716-3-huangjianan@oppo.com>
 <Yg86r7PmIk0ppU5X@B-P7TQMD6M-0146.local>
In-Reply-To: <Yg86r7PmIk0ppU5X@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To HK2PR02MB4097.apcprd02.prod.outlook.com
 (2603:1096:202:2f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1e4b790-d7f2-49c9-fb7e-08d9f69ce784
X-MS-TrafficTypeDiagnostic: HK2PR02MB4260:EE_
X-Microsoft-Antispam-PRVS: <HK2PR02MB4260117C98DD240EB5AD0ACDC33C9@HK2PR02MB4260.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pQs5eCz0whYkfa3Erv4rPYEuvcz2o/OTZzTtaLj8ubwWLMlp+wRvnyFllTNMgyr6/VvxMqOQTudlt2UCbSyCWDJy040b8Wq78wy4fGqoxDrfY8J9fKqyt8jL2bFmaoYJPknxW7x0UmsIERhUUC01/WUc8vSFROePCb8Y8Z+FnmA8797sZWXPHqBZsZZpBu4pSnhVPikdnt0TzGN2gdYsdmKH1GGckQoUVHZGNQx6Aws7ORfEotneeykIpl6ZNzuvAfC65JzO2Ovwy6iuuzcu/3FQtjC8WQ/W6ZOM94pR97gJBXIg0EKMxWBf/ObHg0WQFI+5qP789pPfapa20dG5owV6jYSkf/LNMY+H1tZiJ7T5rEYQltlhnvZpzMUKj2qB/OrU0DnoGk9qtuqZvnja8I8+9qtwVJnQYAIe/6zWnzZKHnz3akqZ/Jx4OLKma8FR1Q+iApjeMgFQHYOZzjLycv1R3htaGUaU5qh8UfOY8Q7sbUYLvX0FmZ0hgQS8ALDbQ+liIdFQTGb+kpXuj0/55r+slNp57uXk8dRD92nmQFXTFr2QlfpjaK2E/Cqtm0t188GnzQWOJj/7j/Ez/7/2o1s2fvQ2/Li0gJ5YhSvvFJz85Xzpk6j4lCMZSes3BnPdbZLRU6Q0cJ/dPZVU63OAi/UbujrBYH6PdEM0TFZDUduVNk8j39xA7MdpSp9m6qIBgBkBGioSxwpSTmtPLbyIPBclO6H1pHT0/57Jp3y6JHqQRwW8BTVoIhZbkvh2pDQwlwIx7ZdFivA9m2Gdb+GfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK2PR02MB4097.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(5660300002)(6916009)(38100700002)(31686004)(316002)(36756003)(83380400001)(8676002)(66556008)(66476007)(66946007)(4326008)(6486002)(52116002)(508600001)(6512007)(107886003)(31696002)(2616005)(86362001)(2906002)(8936002)(38350700002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1TaUxrRWVlUERGMityODBXeHRDeEJKNGpFajFiNTI5MnJVNUsvUmNDUWN3?=
 =?utf-8?B?SHkwWHdOdmtNL1A3T0RkMTI1L2VRaXRad0VSRCtzL05tS2dLdnF2V3ZIcFc5?=
 =?utf-8?B?YmxORHpobWVqUE00Z2kwellSSTB1VHF2TlNBNEg1bEk5Vlg1TXpxbStHWDdN?=
 =?utf-8?B?MXFWOEVCZVZ4Wk5jaG1RczNEaS9ITG5oa0tFWGVQc2JNSmg4NzM0WnR1VXZM?=
 =?utf-8?B?MUFlYktabTlrd28yQmdoY1BmM3hnTzZ4aWQwSThRVmk2aTRyT1Y0Rm5lWGZP?=
 =?utf-8?B?U2drcG8rMDJHU0NOT0FtNnNxZFh1aDRIRWRqZUdmeGwyWTc4ME9jR1lBQ1Mr?=
 =?utf-8?B?Vk1JUVBNZjB6TDA3Qml1SEtLb3ZFczhvanFrSGtnTDl0UTB6RnBnRVhmd0ZU?=
 =?utf-8?B?WjVVejU4clNmR2MxSmRWalk2ZStqUG9xUW5HUlF6Vkg2Mi83Mit0R1g0T1RC?=
 =?utf-8?B?cU1yYzZZR01Ic0tONFhiVjI4aFZGQXhIV0hpU3owS2tMWmVySVJaMHFBbVRm?=
 =?utf-8?B?OFJ1aWJKU1h5bWFySS9GYk5xV25iaDFvTktwVExSU29hbWVscUtoQVdtTFh1?=
 =?utf-8?B?SGNVYmpRQktxOU9NcUxZaUtTUmpCUW5ScWo2V09lcjVGN21pNXp2Q3VrcFNN?=
 =?utf-8?B?TWlEWFhKWmdCL0dRczZwN0dZbElPWDQyOTBDY1dFK2h0eUxJYVg4OGtTcThP?=
 =?utf-8?B?T21SSE9aMlhvdFc3L2hoeUFMZ3k0YjdIcURKMlNzY3NBTkg2MWRRNVRSQmtr?=
 =?utf-8?B?dDFQSldOKzNoTVVFUE90UEh4cCs3eTduWmY5aGhaRmZhcDhUSEdKUmQvcCt2?=
 =?utf-8?B?T1duKzZWOW16MjZpUEJHYWZXbEpQNXZJNFphZy9uWkN5NjduSlBVVGlCeVYw?=
 =?utf-8?B?d3hIVHRkenJyRGpvN29wVXMxN0pGd1NlbDZxZW45MkxIQ094M2VueDZ5Tlpk?=
 =?utf-8?B?TURzOEtqU3JMYWM1UDVKVHREdlpLaDRkNm1iR3BrS3Z2ZmZWYXJHZXJXTlBY?=
 =?utf-8?B?empXZjV1RStWM1ZLZDRSQWxLcURzWVovNVNXaGZHVlEyREZPeEhJSFgwNjRL?=
 =?utf-8?B?dkJ6dEl6SUc1ZGJtNWZiVG1KSGZ5Sk10b0lpSU9EUGJRU1Z5dmRjdzVpS0pY?=
 =?utf-8?B?K2dxTUxnZVQrYTkrNllDRTAwMTJmc0s0T0RucHY4YXdEWVRORGNwUEJjU1p6?=
 =?utf-8?B?Z1MwbXBXdGl5cnc0UjI3L3FHejFUSXdrNm5kOFg5TDZ3UVF2NWhVQ0J1SkE0?=
 =?utf-8?B?eGYwd3d3OUlZY0w4b0FkQ2FCUDhaOG5SWGdkKytER2ZSbTc5bElNa3FkTTVY?=
 =?utf-8?B?T3R2eHlHKzJaeGVrV1FhWGNNcUlXeUdzYm9tZWhHdkd6WDJXUHNwa2h5blFz?=
 =?utf-8?B?NGZmN2RTWlNZbHFYNTNvRVZwTVV0a1VtbXhHWmlkQXdUUkxxeWdZZXFFOHBM?=
 =?utf-8?B?RzN3VG1WZU9aSDB6NHdLYTZrVy9DZlZ5UTlvUGI3NnU1WlJCNUMyRlNDVlQ5?=
 =?utf-8?B?UE03L1hQUmJPQ255RzBEaGVWZXBXWDhkTzJ2bFVPeElITlJoTEJXVVU3ci9H?=
 =?utf-8?B?MnBabjVFL2dqcWQxLzlRZkJYWlh4SGNmVEtyajdnWEY2SWdtWjVlOXlQeUty?=
 =?utf-8?B?ZHMwSkxTMGljb3hHMG5RZFZxUmRsaHk2b0Npd0ZiVHZ4dW5XenZyQWMrNGg3?=
 =?utf-8?B?aTNCYVFFZTg2dzVXMzBlcG14UzdCZkpHWkl0aEZJQ1g0V3YyZjNiMmRFa2U3?=
 =?utf-8?B?TjFVTzREVmVZUjlHVWtwVXVSKzJiVXFHSzJ6UENhbnI4OHlTNTBkN1BYZWQv?=
 =?utf-8?B?cVl3YmNFV1dsQ2tRdG0rdUx3MlZ6MEljRmkydGdqRWpNZnNmZlFMY3hiYXZx?=
 =?utf-8?B?RGZZTjY5aElSV1NBMUtubXpBbTUyeWpGR1g0RDN4Q3NCenNUcXRwNXQ1SUVv?=
 =?utf-8?B?YVVKLzBHeTFwR2xlOW1xZE51eWpIYk5tRmJET3FBbzVJY0lQR1JVN3hYMFRH?=
 =?utf-8?B?ZG55NFFTSUZobFVjdU1nKzN2T2xLSUZ0aE1SS1BucG02OEFtNEVGQVFqQkR5?=
 =?utf-8?B?U0xXU005QmhOem1lU2VmL3Z3YlQwc0JGeHhyR1VtVnBwc29kUVdzUnVuVDRt?=
 =?utf-8?B?SjBVeWRBcHdtUVFuM1paME15NjB4THRQQUJ4b1FOcnVFZTJtNGlENmFtNm5I?=
 =?utf-8?Q?su261wLnNbb+ZK5pa82X4SI=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e4b790-d7f2-49c9-fb7e-08d9f69ce784
X-MS-Exchange-CrossTenant-AuthSource: HK2PR02MB4097.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:20:01.0781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUfeKvlYV5y5kjxbTnV+vfHipqvdjm/14hCl49aKGJxAcm8kSwTg6yfq7d/apP7g4NBjI6bAhfVNHc5vfqa7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR02MB4260
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2022/2/18 14:20, Gao Xiang 写道:
> Hi Jianan,
>
> On Fri, Feb 18, 2022 at 11:11:37AM +0800, Huang Jianan via Linux-erofs wrote:
>> Fix some minor issues, including:
>>    - Align with the left parenthesis;
>>    - Spelling mistakes;
>>    - Remove redundant spaces and parenthesis;
>>    - clean up file headers;
>>    - Match parameters with format parameters.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>>   dump/main.c                | 53 +++++++++++++++++++-------------------
>>   fsck/main.c                |  4 +--
>>   fuse/main.c                |  1 -
>>   include/erofs/block_list.h |  4 +--
>>   include/erofs/defs.h       |  1 -
>>   include/erofs/dir.h        |  2 +-
>>   include/erofs/internal.h   |  2 +-
>>   include/erofs/list.h       |  1 -
>>   lib/blobchunk.c            |  2 +-
>>   lib/cache.c                |  1 -
>>   lib/compress.c             |  2 +-
>>   lib/compress_hints.c       |  2 +-
>>   lib/compressor_liblzma.c   |  5 ++--
>>   lib/data.c                 |  2 +-
>>   lib/dir.c                  |  2 +-
>>   lib/exclude.c              |  2 +-
>>   lib/inode.c                |  2 +-
>>   lib/io.c                   |  2 +-
>>   lib/liberofs_private.h     |  2 +-
>>   lib/namei.c                |  1 -
>>   lib/super.c                |  4 +--
>>   lib/xattr.c                |  4 +--
>>   mkfs/main.c                |  2 +-
>>   23 files changed, 48 insertions(+), 55 deletions(-)
>>
>> diff --git a/dump/main.c b/dump/main.c
>> index e6198a0..3f8c2f2 100644
>> --- a/dump/main.c
>> +++ b/dump/main.c
>> @@ -179,7 +179,7 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>>   }
>>   
>>   static int erofsdump_get_occupied_size(struct erofs_inode *inode,
>> -		erofs_off_t *size)
>> +				       erofs_off_t *size)
> There are two acceptable style (which follows kernel code style),
> 1) the one is aligned with the parentheses in the previous line;
> 2) the other is just using two indentations.
>
> So here we actually don't need to update... btw, was it reported
> by checkpatch.pl?

It was reported by checkpatch.pl with --strict. If these are unnecessary,
I can remove this type of modification from this patch, since there are
some other modifications.

Thanks,
Jianan

> Thanks,
> Gao Xiang

