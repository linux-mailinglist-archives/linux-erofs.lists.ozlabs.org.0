Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DD0402256
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 04:55:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3VHy6366z2yHJ
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 12:55:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1630983326;
	bh=c8cwH20QFNfGg+62imD9GTGxsvuwV0EPiLuMhGbUlwU=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dYJ0O9y3cxd6e6Vw17RsKnK+uzO2wwZ/eKvzPoFXtZQc2eK1zBeOv3PgbYWdxOOrC
	 eAfCU2Kd0vNKQax91IHELEigRdhCJHtT+qGWsvNqp1c4UlU2hUwkRtmVpLDSsy6j39
	 pB+8ESpXh0RlqRT7Vq4CQXgHHCBBxYreN7DdK1mHB/y3NjFizFjMGGPZk0+EkQ1OrU
	 92JrpJhNpNHedtF48y899Bj91ldhUltNoiHUvCnnBlXA4l7DqxnO0Odh/S4iFy02Ch
	 Me08UyuQVuTXwWIOOtVom3AzwATNfiX7wv7aLp+u8v3gJmdI+ULUmaPOgc55nOzvJ8
	 QB4DZTbST6BHQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.78;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=Wg8S7hMX; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310078.outbound.protection.outlook.com [40.107.131.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H3VHm31y5z2xfP
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Sep 2021 12:55:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrX7rq4VRcCBsQtgUlX8ZiRNaMCwT3/69o3WIYwMT3DtXXKBm6UwbG2FFh5ZrhsindwVdd96SW42CUlDrktU+2RAjTgN/bFbx6/w3G2C3trnK1FtMjmJ+XbHwHyWkHgImDYm8ViSz4rocjL8fxSg1bWj785Q9NIfdEbGHYG9gkdgx2coRPXVo7ApvxlcmF68txre7pv8lb2HtfkNV1Si464AOR/nWXIH/UJ3SonEaw83etGg7ZcVS+QQ30gqRwYTfNE8/3+IBZewy9nKaaRzoWOhabfl1tjhdZdywAPMWvJOzHNYYYIcdmuVLELPCf3TFvZ1KeDVggreL6g4C0nlSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=c8cwH20QFNfGg+62imD9GTGxsvuwV0EPiLuMhGbUlwU=;
 b=QPlswNz95+bTg1/sdQhSpI0ZNMfqMCTxB0eFCuUvsPrnCeSz/ZfVF/Aq6nncGfoqtaUxwswzSF6grhIIOxxYaJsa/me8q+QxEkw2cNMUtoqOt/wS4W2PZ6t3wafdbPW+ygd9IrnpXfa3rWypL2vNuI1ebnkMh+E4AeJfJVy7KCOEZnKeoJUrYJb0jJEoFyyYaNVnnwJ8hRw75I9u+O7qZw0oauMfXcKeDnGkcRaF0mJbXe6LPQ1OsnEUfft3inUnnIQ1X6r/jE3XxI8ycj8YS3cbi8Z8SkkCgz9ySNVODKNti02EgHY0g+01AcaIG84Rd4vsUwgDgQ9KcJve0KixeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR0201MB2095.apcprd02.prod.outlook.com (2603:1096:3:4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19; Tue, 7 Sep 2021 02:54:53 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 02:54:53 +0000
Subject: Re: [PATCH] uerofs-utils: fix random data for block-aligned
 uncompressed file
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20210906081359.17440-1-huangjianan@oppo.com>
 <20210906081359.17440-2-huangjianan@oppo.com>
 <20210907001038.GC23541@hsiangkao-HP-ZHAN-66-Pro-G1>
 <YTa2YLuTBwvHCSAf@B-P7TQMD6M-0146.local>
Message-ID: <ca78e376-b4f2-d5d2-89f2-36218beccbd3@oppo.com>
Date: Tue, 7 Sep 2021 10:54:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YTa2YLuTBwvHCSAf@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.252.5.73) by
 HK2PR03CA0054.apcprd03.prod.outlook.com (2603:1096:202:17::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Tue, 7 Sep 2021 02:54:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d820b758-4011-4a49-9280-08d971aaddbb
X-MS-TrafficTypeDiagnostic: SG2PR0201MB2095:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0201MB209568E03505364FF957856CC3D39@SG2PR0201MB2095.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7r6ydPlx2pgRBxRyCYD0l+VBsI65nOe9Bc/GCn7tI5nMmbCsLlKIaqCMa9MEwN4JjyhKZgCpQZ8y2B1XCrNEPQ+TUtJdqACsCKRdV/MqzA/ICceP9ptd6X6bsVAv0x79S3OnLUxjnz/Hign0LarXQA59i/7qtUFB/biGcI+dWZpfAkDX+eAuhx81fXwmWhTVjNbu07tZ8rygdJcYbBc+lX4vugYHuwkD2TRHR/yrQb1HGwprKFGQjklHk5UD9vhxWK9X3efiy2Vt7RNpPs3sfi+Ja6xUU5cZfk8km6axAkbCeE3y7K/rnKkbpq45xUTBfdT7vIv6R6EcfOj5YjpPOelhvhoMRiVh822i3HRhc8Pe5Zn8yXYYLaGEfpSF1uc0pu0lzq6PR/1AOEHMuHhayVc+1+gjRRccBGY/gC9/BKIkZIpRdRE21hhBevIF/4kG6rIX62xYfn929NWdENsD6svzgVT5usabx3h55177tRjG4O6NYpJbjnegdaQn+Z8AwHtqyL7z+pF132T8NdtrPXg94fzW5Q54atZoAWrUgxptko4GFBVazYd2Moj56s8wxVl+/xNBv14hUGt/FH7A8xJ8MDAPYnO1VPpq0zNfVTfgupsAgrgre8OuT0w+HMk5No+GB4w/ReEjwwPR1R8PWoUC0og0+KQlrrfgc4UO0HEv+yKAraQ9IILayxmTlz9sKqCKDIEJ9++HET8qIc74yu6QSqVaNxW7fcZYqOrreKT/7y5z9CIswGFsRhMwUZTnIycR/ZQnY7aLQCPf2gy4TneH1J1hd/wIk9OXebGFthI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(38100700002)(8936002)(38350700002)(478600001)(26005)(2906002)(31686004)(36756003)(66946007)(8676002)(31696002)(86362001)(52116002)(66556008)(6916009)(66476007)(2616005)(107886003)(4326008)(83380400001)(956004)(5660300002)(16576012)(6486002)(186003)(316002)(11606007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clhLdEhiYTZzMVJmT3RtK1pPaTRvUTArNURVb2VnVEhQcGs2TWNFZGthLzUw?=
 =?utf-8?B?RTNRN3BFMklxdzA3MzU4Rkk2RGE1ZHNvQXBQMVNHNXk4UXEwelI2dUJYeEdm?=
 =?utf-8?B?aDd1cjI1WmNtWURqSEtlQ0ZaSms2MXVOSkxIN0ZBZUhZKzhOanA5MVc0T1pZ?=
 =?utf-8?B?OS9VOWs4NlZUcVhqTWYwQTc4R0YzY0c4b3hZVWl2ZlRSZm5udDdCU2twSGVG?=
 =?utf-8?B?Q2NWajNPbmQyYnU4WlRyM29rcXdTSElSaWhhSElub1JiaGFyeUlTUDhBTklx?=
 =?utf-8?B?UVNSNzJQYlQxZCtPbWt4WVpQNjA5SnZ1bFJNWG1KSVd3c01pdUhpM3hWZWZ3?=
 =?utf-8?B?Z0dDUm9hUUJ3RU5KZ3ZTMUVNR093emFQU3FZdllkVDJqVGI0Q0lQYjFQS1d1?=
 =?utf-8?B?YkE2Y2lQSTNuNGtQaThCalZBNEVWd1h5a0pYM3llSkpzdE5lekcxaEYwdld0?=
 =?utf-8?B?aEZXdnRTUVNxOE9mZURrbmJKL3ZQMkl0biszdEFWeWczZ2ZYb1BKdG02WDJn?=
 =?utf-8?B?bDkvcGlMK3ZIbm1qbERCWkIwN2trOFN0dWFMRzErL242UlJqaXpnRENzeGJE?=
 =?utf-8?B?aVZUcWJpaHN5U1RiK3Rvb1BIMU5GUk9ScmkzemlCS3F4bWZrSkQ4Rkdubld2?=
 =?utf-8?B?ei9PMUFId1ZEL2xhN0xseDBkQ0wzY2xZWVZsWGdabmRaZGF1S2ZBQ2ZqN0Jt?=
 =?utf-8?B?VW90VjIyZ1FsdnhzamJZSGp4NXFZWnFtTjRoV29FaTFnUFlzSmJaTFdmMHV1?=
 =?utf-8?B?cU9vOVBVQ2xDc3Bad0VCSFMxVUtkeGk0S01MUTVPMG1mcGxwaXYrNkNjT3I3?=
 =?utf-8?B?ZXJrcE81WjJNZXdHNzUySHZtVXBKQ2VucmRpcVMvcXJvQjRlR1M1OC9acm5L?=
 =?utf-8?B?RGtBYUlUZXhhamg4eGJGU1FzblVlamdSOEN2enplYmVXM1gweFhKNmFGNTha?=
 =?utf-8?B?YlpSQkJYNDVZb2xnY2lvOVVMNWoyRStBc1UvNXp3bDRnTEdXOUV5L2RBYk13?=
 =?utf-8?B?SnR6eXFkbjMzRGxOZ1VyeEJrZWFsZzRadmdBV09FaEo5TVhhN21SbFFoOFF4?=
 =?utf-8?B?bE1VaUVVdWx2ejYzUjJGbkkydGh2c3V5RVVvSFNyM0wxZGhHSmdWMW1Pd21C?=
 =?utf-8?B?TUx3dFBlYWxUeGhXYmc1U3dXS3A1Vy9kQTNDaWVYL3RXTjA3RkFYM2VJL1dv?=
 =?utf-8?B?UURDQy9JbFAzSG96bGxSK0dXREJwRFVWRGIwN0ZQYVg1ZSs1ZkxZRUlwVFVY?=
 =?utf-8?B?TW9WL29Zc3liLzZyYmxua1NzdDY3ZERPdlBXb2oyZnpqSktiSFFXYys2Q0Rt?=
 =?utf-8?B?cldMQTQ0eWNYVjI1eHB4QzVUMzhoSW1lYjVYZVdTSitvZ1FoYytXRUtZbVFi?=
 =?utf-8?B?VzZlTllKdUQ3R0JWaVAzV1htZlI1d2hEWGhtbWNycjd1MWtYQS9nSnExODZT?=
 =?utf-8?B?UGJldm1NT1pqRDkzK0NJalBxRkk0Q0kzWGliMEhUall4STBOOUI5bkJia3cy?=
 =?utf-8?B?SkVOdUlhRE1vMXJlc3UvUlU5R2oyelVBM2U5N2ZScW9haUoxZWNOQS9TVWpo?=
 =?utf-8?B?MDBYZ3FONUt1TkhSNVpsMkxGb1U3d1Z5Y1hHSEFRYVBJdURFNzY3SXRqdDVq?=
 =?utf-8?B?Yml5b211NUw1SFV2TFNNZzdZTnk4ZkZXUFd6TTkwQlQxbzFISFBxZ21TdnN6?=
 =?utf-8?B?dkRJK2R4ZGRrZm4vTm9zS0xzb3d2QTc0T2I3b1VWOURTV3UwMjFPdnQzbHZs?=
 =?utf-8?Q?ir0dt4vAdB1yXHYHZ6ES658AM9sIyF16Cm/cO9V?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d820b758-4011-4a49-9280-08d971aaddbb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 02:54:53.4188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhyjyoZalfw+0x3ctKAkLM6B1fPMEGKHjEsg6dBjgf5QDFfmGbdkpt5A2siDul2VXlXPqOtzEJzEyyqPSlwdpQ==
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2021/9/7 8:46, Gao Xiang 写道:
> On Tue, Sep 07, 2021 at 08:10:45AM +0800, Gao Xiang wrote:
>> On Mon, Sep 06, 2021 at 04:13:59PM +0800, Huang Jianan via Linux-erofs wrote:
>>> If the file size is block-aligned for uncompressed files, i_u is
>>> meaningless for erofs_inode on disk, but it's not cleared when
>>> datalayout is seted in erofs_prepare_inode_buffer. Clear the entire
>>> erofs_inode to zero to fix this.
>>>
>>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>>> ---
>>>   lib/inode.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/inode.c b/lib/inode.c
>>> index 0ad703d..1397cc5 100644
>>> --- a/lib/inode.c
>>> +++ b/lib/inode.c
>>> @@ -834,7 +834,7 @@ static struct erofs_inode *erofs_new_inode(void)
>>>   	static unsigned int counter;
>>>   	struct erofs_inode *inode;
>>>   
>>> -	inode = malloc(sizeof(struct erofs_inode));
>>> +	inode = calloc(1, sizeof(struct erofs_inode));
>> If we decide to do this, how about removing all
>> 	inode->idata_size = 0;
>> 	inode->xattr_isize = 0;
>> 	inode->extent_isize = 0;
>>
>> 	inode->bh = inode->bh_inline = inode->bh_data = NULL;
>> 	inode->idata = NULL;
> Please also add a note that this only impacts OTA packages in the
> commit message about the background since it has some impact to
> the reproducible builds.
I think this won't impact ota packages, mainly it will affect the 
reproducible
builds.

Thanks,
Jianan
> Thanks,
> Gao Xiang
>
>> ?
>>
>> Thanks,
>> Gao Xiang
>>
>>>   	if (!inode)
>>>   		return ERR_PTR(-ENOMEM);
>>>   
>>> -- 
>>> 2.25.1
>>>

