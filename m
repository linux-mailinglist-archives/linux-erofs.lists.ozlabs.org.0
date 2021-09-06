Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EB14018FE
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Sep 2021 11:39:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H33JV5rRXz2yJJ
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Sep 2021 19:39:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1630921162;
	bh=yQTntR63WrlJCVqx3YAxB9nodHWfZWc8uQ4hwYyhjcs=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=FHLr+BVBbwTbyQT3+2DBwn4uoREVlFqFhI7UeAeGVHrKmsUfGOuS2wKhxla2q0IqN
	 K4+CjlKREwoDbrn6FKDrogVcX0p2P5dwkuTEoTv6rjjU3SANO3uMKYM6vw+Jg7Lhh3
	 mgKbBvupW3z8sWkrpa8gCC5lvjvtK4TtFB+a0snMHyTdH/3RGGrgcndur4BjhM5nmi
	 fMxxYFqP6iJiQesqZxqxHqO6WGpSxaRBquB3b2Kf1C0KAfHp4v67EF0HXw36D+HzqC
	 GNx1DxJBSGaZOM/Zu+Ms2g0keqgyViEkQ4BDSe2l59j4NRyxJo3RnMx8taSIpXNnWd
	 9AGSq2Ny5sKDw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.51;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=fyuTBUeP; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320051.outbound.protection.outlook.com [40.107.132.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H33JF4vd8z2xrr
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 Sep 2021 19:39:08 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHbSsL7YV8n8p4mEmqqwlahNgnIQG77pX6dvV5km6W3OouyW1kaaQuHWt8WWJDABWVfEFrFQ7d1+b7rx1aXuwUOKsNFazqKkXy1JCziHUUy52IPI6l6CcmCsaEbpq+vVyEvhzMd1eymxD/ocSbMlSSscqbPW6CaU+K/u14x7afu49gF+/nHUlkLlQ5Cp9zHIfrxr/KwJZfnAjUl8OQd8WOnjTY1a9RsW3MHQMj3RBw42pLfWCzqTnxqFyAA4L70jD6PBXEvqNI8+S+cFzn7IaeBgYvYnA2L9RkiHoydacVc/Wp1PBtra9ZaEQjnXAREMsLLQHOrZGCuBc2dbZyMIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=yQTntR63WrlJCVqx3YAxB9nodHWfZWc8uQ4hwYyhjcs=;
 b=Sa47dD5eb0Uc8rcf2/Q8ofDxFB9F+3CEwl1a1ZbDfEMHrv4/JoPdbtWL9r1/SJ/J4zOHhGRBnLws0RT/VzDIxNrLp7wm33QS0IKYXFbrc4x9NBHwfbMMab/mB1AKTKoQ70wFIYIB1FOkqwY7bu2puDnpKSTTl9V8yPQXZpmOAGm2ybQJ7PTg3znm+1nOyX5OWaK3TN5B995+OWU8MuI/aVV0/3t91rvSGwWuiY1mGOyppuBgB9Dd+M237PZWW/KBxRbRGhUFyunncIFLhxfXtSS/DXqbM2AM8IJ1s/9M/NThs+H+Kq1CvoYFjF+cWXAcCH8b2olP7NQRRkpRZilOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3274.apcprd02.prod.outlook.com (2603:1096:4:4f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.25; Mon, 6 Sep 2021 09:38:46 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4478.025; Mon, 6 Sep 2021
 09:38:46 +0000
Subject: Re: [PATCH v3] erofs-utils: support per-inode compress pcluster
To: linux-erofs@lists.ozlabs.org, yh@oppo.com, kevin.liw@oppo.com,
 guoweichao@oppo.com, guanyuwei@oppo.com
References: <20210818042715.24416-1-huangjianan@oppo.com>
 <20210825033523.20058-1-huangjianan@oppo.com>
 <20210905175919.GA24755@hsiangkao-HP-ZHAN-66-Pro-G1>
Message-ID: <c234da57-dc77-e1c9-d17e-41e4e873834e@oppo.com>
Date: Mon, 6 Sep 2021 17:38:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210905175919.GA24755@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.255.79.105) by
 HK2PR02CA0181.apcprd02.prod.outlook.com (2603:1096:201:21::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Mon, 6 Sep 2021 09:38:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9472c2-b970-4ada-be42-08d9711a1f57
X-MS-TrafficTypeDiagnostic: SG2PR02MB3274:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3274246B334631550A7DF52EC3D29@SG2PR02MB3274.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1H/oNR00GWjZE7JHK77IvCmcE5qLl23GIOdpF+pux9rFqQbi20CbPjM2VgDOMAX/Quxbe73JpKYgxl85jCXen3UXEHeJd5iK1BHyc/0i7FURulXC2GR/cJa9ZCADe9anNY6QAETrLc5F89Dk+vtB6a3I9GwxJu1fK0NF3pGfoXzfhRVEkLHcus/XCdDCFMK43w0mnxcq5LsMrt3Yg40yDU8JyBs6s9iKiyE4NWKcYkbYEs3wHvmpexqQqFkM7OlFvoYH3sVtGnkt0llkBObCIC/nt1NwiZrecEf6YSlWmW7hF/te7ef1HmgU3yp13Z9BzCOjKhUs6lQXIxy4svhPpx4LdrDkZ3tG0K228++aNrmQeoUE6uMrPtQSabvV4tE0c7/LNi2R2YO1spQP2c/wDUIO4FI60uE4K82/IwR5OO6zTZkNI1r9oMXW4ZyqAMXj6Eyq/Djd4bPikV9pJjvwVfJojXF89FYW2xRCg2iRAsxW9J4SrNmAIbkblp7w7fB6nDdlUYWr13SGsmflgJf9HUwBtoUSEQDj09Cfc3cvRHIXotP0hBtps8SnXkJPMkQDeQioubhyYSyaPxo2acuMj3ZX3EBaDkWUzVWXEcYuCEHxLDyq9H2LF+AAo1hg7eAXB6a9Jysp4HrVXknRe3z+u56Hn4EVdXbzQzhwym0dIlgg84nD43LXrgOjZhCNnkPUiMQnnYay2W4PE4XAv1m6OWi+j3V2DJFUM6oRe2ZFsDojLrOte2MvuhHNJrB6EjBq6J8ZNAkb5///I40KJwj8ivKm+GCZScCngLnYiiVYUAAkJ9nIsncSofzlAxLrEFl+iR6J1liYHl3qZYNQS+hFVAtzVMCa6cFn+eqU8A2E5bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(30864003)(316002)(5660300002)(2906002)(36756003)(8936002)(52116002)(956004)(2616005)(66556008)(186003)(8676002)(66476007)(31696002)(86362001)(16576012)(31686004)(66946007)(6636002)(38350700002)(53546011)(83380400001)(6486002)(26005)(478600001)(38100700002)(11606007)(21314003)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FqdWwzMWJqMElPWDhpYno3Q2J5cmNtck1ZVExNNHRGYmM0L09pK3lqTXJk?=
 =?utf-8?B?aHhqZGN2b1c1WUlSanJXTDNUZFB1TTJRVmVvWk1wYjZaR2VPRjY2VC92eWxl?=
 =?utf-8?B?WThNNXVoc05NUXBKMWZLMXRHa3QxL1ZacWR5SldMTHVOdVJ3QjlLdDJGOVJx?=
 =?utf-8?B?VXMxVGx0aytKaVNaUEhlZE5rVUV0SHh2L1MxRUdaeGlTek5Hd0FXT3BlRmUz?=
 =?utf-8?B?Nm4xRWVQZlAxYXd6M3pLdDFPMk9zOWRCcDd3dUVwZE5DeXh0Wm1MYUhJaEwv?=
 =?utf-8?B?elR3anltK3NIZXhNOFZSV25tOGRBM1BqeWVNSS94TStsdU0xbTc3YUU2cGE0?=
 =?utf-8?B?dkNHSVZNMFgzZkJGSC8vMStjVnJtcXRtaXlBWFNkd0k4KytkOHhFN1JpQ1lT?=
 =?utf-8?B?WGZ3cUg1K21CTDQ3SGoxWEVFRzZWVWhLWUhZUC9GRWFXUjYwdkpqYzN1Tlk2?=
 =?utf-8?B?ZGw1QWpiTjVFeldMY3BJMmNaUE5KZFFWeit3c1ZvaXhzZ0UySi8zWGJFem1N?=
 =?utf-8?B?cWZhT3lvUUx6WTJCSUVuMlVlQVBtQmJwZnZ5QUp3MXczcTBSQVdGZlo0RTBj?=
 =?utf-8?B?VVBnMis0UmZDWEtaN0drencvQW1aQ2VBYnpSVU83Zk1MK1NvZTdqMmpPZWk3?=
 =?utf-8?B?WlM1L0tNYzl5bHUwdHpQb2phWWFHMG5PdVhQcTJxdHFBN1hIMlBkR1RaWFhT?=
 =?utf-8?B?RHJLdTQyb3ZsaHRDWThjb2FuWkNHNlROc3BhdWthNm84Rll3YlFmekt4WjAx?=
 =?utf-8?B?MHdYSWVsZzB5UFc4UEFrUUptUmU4NVdiQW40MjF6Y0t4TUx1cHNxMDdYeEVV?=
 =?utf-8?B?SWZVeXJyVzBxOHlDekhCSldPTXVsYkhhdlNMNU9UbmxZeDBKcFlydXpObXBY?=
 =?utf-8?B?eVAxZVlxdU9MeGlvS1FWdW9IN3NLOUxYNkdCUS9TQ2MxWjhUODgwVTZ1dk45?=
 =?utf-8?B?VHoreUFFMUZqRGpyWDYxUjRlU1d3M2djT2J2RDc3Q2diU3lFdHlVcHVpdld5?=
 =?utf-8?B?cU1iZGFOUTFvSzNod2FFUGpwcTMyU09BakYzS0huMTJHTGtoUFpPczRQWVM3?=
 =?utf-8?B?WUFFOThzTFJKY2ZmUGFkM0VqdlJpcGhsSHRtcHBXdjNmUytPelJQWmp4UVYy?=
 =?utf-8?B?UEpWT29YTDBSNUFyeXFTZitwSFR5ejdyenc4TDF3Z0VJc0kxMzB5L3ZiYWFM?=
 =?utf-8?B?eURCTTJ3SWFzLytWVy9yYTRrWjNLY01IY0JnZzVGUTVpWFZYUEphRWxNd0Yx?=
 =?utf-8?B?cERoRGNsblJlcUlUdkloZXFJZjdUUUFqZjZUSlcvZnlUZUpUY2hmOENGajRn?=
 =?utf-8?B?MzU4RHJ2Z3Z2TWc2eTViNkxid1lDTWRYbW1HUU81bHVmeVUvYlV2aTB5VVNU?=
 =?utf-8?B?MEVCemJxL1JxRXFmUm44NWJkUlduYkRweHB4N3Q3eEFocE9aampVRjVBNlY0?=
 =?utf-8?B?WFZnWUR5clZWSGtNTlhaUnY2WHl0MVZPajBObXVQbnZrSDVSVUk3KzBsWDdj?=
 =?utf-8?B?VkovSU5KSHZHa0lySlpnbVdGaEkzMEQvSE4vRWdWRy9OWFF5U1ZFY0dZNmxy?=
 =?utf-8?B?anU4azZZS2RlVkV6OHBDUWd3aTI0MFRHN250aTNpTWxzSXdLVHc5OCs1bi9M?=
 =?utf-8?B?cklUTndiMUlNWndka0lGSDBkLytqUkQ5MVgxeGVNTjhVL2doMFVoR3htRkgz?=
 =?utf-8?B?QXBkREYxSXhNQk41eDFPWG54MC8zNjJMeCs5dGNqY1JDQmJ4MWdPOERyMzR0?=
 =?utf-8?Q?kpZVwjMGNOgu+MazvsLa+4Lxdnegd+4hziB84Tc?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9472c2-b970-4ada-be42-08d9711a1f57
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2021 09:38:46.2346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVlEBpALcUoA7033gSRyD/s/+A1m0rYu07GB0Ryiw8PepwXlHmxr2Ep+Go1LYYEsgERYuhOBBrL4w+tE6egZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3274
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2021/9/6 1:59, Gao Xiang 写道:
> On Wed, Aug 25, 2021 at 11:35:23AM +0800, Huang Jianan via Linux-erofs wrote:
>> Add an option to configure per-inode compression strategy. Each line
>> of the file should be in the following form:
>>
>> <Regular-expression> <pcluster-in-bytes>
>>
>> When pcluster is 0, it means that the file shouldn't be compressed.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>> changes since v2:
>>   - change compress_rule to compress_hints for better understanding. (Gao Xiang)
>>   - use default "-C" value when input physical clustersize is invalid. (Gao Xiang)
>>   - change the val of WITH_ANDROID option to a separated patch. (Gao Xiang)
>>
>> changes since v1:
>>   - rename c_pclusterblks to c_physical_clusterblks and place it in union.
>>   - change cfg.c_physical_clusterblks > 1 to erofs_sb_has_big_pcluster() since
>>     it's per-inode compression strategy.
>>
> Hi Jianan,
>
> I sorted out a version this weekend (e.g. bump up max pclustersize if
> needed and update the man page), would you mind confirm on your side
> as well?
Hi Xiang,

Thanks for your modification, looks good to me.
> Also, it'd be better to add some functionality testcases to cover this
> if you have extra time:
Ok, should I use the experimental-tests branch now?

Thanks,
Jianan
> Thanks,
> Gao Xiang
>
>  From 0e675d679c8732bd39699e5a9b1b6d9d742fb728 Mon Sep 17 00:00:00 2001
> From: Huang Jianan <huangjianan@oppo.com>
> Date: Wed, 25 Aug 2021 11:35:23 +0800
> Subject: [PATCH v4] erofs-utils: support per-inode compress pcluster
>
> Add an option to configure per-inode compression strategy.
>
> Each line of the file should be in the following form:
> <pcluster-in-bytes> <match-pattern>
>
> Note that <match-pattern> can be as a regular expression.
> If pcluster size is 0, it means that files shouldn't be compressed.
>
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Gao Xiang <xiang@kernel.org>
> ---
>   include/erofs/compress_hints.h |  23 ++++++
>   include/erofs/config.h         |   3 +-
>   include/erofs/internal.h       |   1 +
>   lib/Makefile.am                |   5 +-
>   lib/compress.c                 |  24 ++++---
>   lib/compress_hints.c           | 128 +++++++++++++++++++++++++++++++++
>   lib/config.c                   |   3 +-
>   lib/inode.c                    |   4 ++
>   man/mkfs.erofs.1               |  11 +++
>   mkfs/main.c                    |  19 ++++-
>   10 files changed, 205 insertions(+), 16 deletions(-)
>   create mode 100644 include/erofs/compress_hints.h
>   create mode 100644 lib/compress_hints.c
>
> diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.h
> new file mode 100644
> index 000000000000..a5772c72b1c4
> --- /dev/null
> +++ b/include/erofs/compress_hints.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
> + * Created by Huang Jianan <huangjianan@oppo.com>
> + */
> +#ifndef __EROFS_COMPRESS_HINTS_H
> +#define __EROFS_COMPRESS_HINTS_H
> +
> +#include "erofs/internal.h"
> +#include <sys/types.h>
> +#include <regex.h>
> +
> +struct erofs_compress_hints {
> +	struct list_head list;
> +
> +	regex_t reg;
> +	unsigned int physical_clusterblks;
> +};
> +
> +bool z_erofs_apply_compress_hints(struct erofs_inode *inode);
> +void erofs_cleanup_compress_hints(void);
> +int erofs_load_compress_hints(void);
> +#endif
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 95fc23e79e26..d5d9b5a751c0 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -50,13 +50,14 @@ struct erofs_configure {
>   	/* related arguments for mkfs.erofs */
>   	char *c_img_path;
>   	char *c_src_path;
> +	char *c_compress_hints_file;
>   	char *c_compr_alg_master;
>   	int c_compr_level_master;
>   	int c_force_inodeversion;
>   	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
>   	int c_inline_xattr_tolerance;
>   
> -	u32 c_physical_clusterblks;
> +	u32 c_pclusterblks_max, c_pclusterblks_def;
>   	u32 c_max_decompressed_extent_bytes;
>   	u64 c_unix_timestamp;
>   	u32 c_uid, c_gid;
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index b939155ac951..f5eacea5d4d7 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -164,6 +164,7 @@ struct erofs_inode {
>   			uint16_t z_advise;
>   			uint8_t  z_algorithmtype[2];
>   			uint8_t  z_logical_clusterbits;
> +			uint8_t  z_physical_clusterblks;
>   		};
>   	};
>   #ifdef WITH_ANDROID
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index b5127c439e43..5a33e297c194 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -16,11 +16,12 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>         $(top_srcdir)/include/erofs/list.h \
>         $(top_srcdir)/include/erofs/print.h \
>         $(top_srcdir)/include/erofs/trace.h \
> -      $(top_srcdir)/include/erofs/xattr.h
> +      $(top_srcdir)/include/erofs/xattr.h \
> +      $(top_srcdir)/include/erofs/compress_hints.h
>   
>   noinst_HEADERS += compressor.h
>   liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
> -		      namei.c data.c compress.c compressor.c zmap.c decompress.c
> +		      namei.c data.c compress.c compressor.c zmap.c decompress.c compress_hints.c
>   liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
>   if ENABLE_LZ4
>   liberofs_la_CFLAGS += ${LZ4_CFLAGS}
> diff --git a/lib/compress.c b/lib/compress.c
> index 6df30ea564a3..2806a7edfcb6 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -17,6 +17,7 @@
>   #include "erofs/compress.h"
>   #include "compressor.h"
>   #include "erofs/block_list.h"
> +#include "erofs/compress_hints.h"
>   
>   static struct erofs_compress compresshandle;
>   static int compressionlevel;
> @@ -89,8 +90,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
>   	}
>   
>   	do {
> -		/* XXX: big pcluster feature should be per-inode */
> -		if (d0 == 1 && cfg.c_physical_clusterblks > 1) {
> +		if (d0 == 1 && erofs_sb_has_big_pcluster()) {
>   			type = Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
>   			di.di_u.delta[0] = cpu_to_le16(ctx->compressedblks |
>   					Z_EROFS_VLE_DI_D0_CBLKCNT);
> @@ -149,14 +149,18 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
>   	return count;
>   }
>   
> -/* TODO: apply per-(sub)file strategies here */
>   static unsigned int z_erofs_get_max_pclusterblks(struct erofs_inode *inode)
>   {
>   #ifndef NDEBUG
>   	if (cfg.c_random_pclusterblks)
> -		return 1 + rand() % cfg.c_physical_clusterblks;
> +		return 1 + rand() % cfg.c_pclusterblks_max;
>   #endif
> -	return cfg.c_physical_clusterblks;
> +	if (cfg.c_compress_hints_file) {
> +		z_erofs_apply_compress_hints(inode);
> +		DBG_BUGON(!inode->z_physical_clusterblks);
> +		return inode->z_physical_clusterblks;
> +	}
> +	return cfg.c_pclusterblks_def;
>   }
>   
>   static int vle_compress_one(struct erofs_inode *inode,
> @@ -493,7 +497,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>   		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
>   	}
>   
> -	if (cfg.c_physical_clusterblks > 1) {
> +	if (erofs_sb_has_big_pcluster()) {
>   		inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_1;
>   		if (inode->datalayout == EROFS_INODE_FLAT_COMPRESSION)
>   			inode->z_advise |= Z_EROFS_ADVISE_BIG_PCLUSTER_2;
> @@ -603,7 +607,7 @@ int z_erofs_build_compr_cfgs(struct erofs_buffer_head *sb_bh)
>   			.lz4 = {
>   				.max_distance =
>   					cpu_to_le16(sbi.lz4_max_distance),
> -				.max_pclusterblks = cfg.c_physical_clusterblks,
> +				.max_pclusterblks = cfg.c_pclusterblks_max,
>   			}
>   		};
>   
> @@ -655,11 +659,11 @@ int z_erofs_compress_init(struct erofs_buffer_head *sb_bh)
>   	 * if big pcluster is enabled, an extra CBLKCNT lcluster index needs
>   	 * to be loaded in order to get those compressed block counts.
>   	 */
> -	if (cfg.c_physical_clusterblks > 1) {
> -		if (cfg.c_physical_clusterblks >
> +	if (cfg.c_pclusterblks_max > 1) {
> +		if (cfg.c_pclusterblks_max >
>   		    Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
>   			erofs_err("unsupported clusterblks %u (too large)",
> -				  cfg.c_physical_clusterblks);
> +				  cfg.c_pclusterblks_max);
>   			return -EINVAL;
>   		}
>   		erofs_sb_set_big_pcluster();
> diff --git a/lib/compress_hints.c b/lib/compress_hints.c
> new file mode 100644
> index 000000000000..81a8ac9ef04f
> --- /dev/null
> +++ b/lib/compress_hints.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C), 2008-2021, OPPO Mobile Comm Corp., Ltd.
> + * Created by Huang Jianan <huangjianan@oppo.com>
> + */
> +#include <string.h>
> +#include <stdlib.h>
> +#include "erofs/err.h"
> +#include "erofs/list.h"
> +#include "erofs/print.h"
> +#include "erofs/compress_hints.h"
> +
> +static LIST_HEAD(compress_hints_head);
> +
> +static void dump_regerror(int errcode, const char *s, const regex_t *preg)
> +{
> +	char str[512];
> +
> +	regerror(errcode, preg, str, sizeof(str));
> +	erofs_err("invalid regex %s (%s)\n", s, str);
> +}
> +
> +static int erofs_insert_compress_hints(const char *s, unsigned int blks)
> +{
> +	struct erofs_compress_hints *r;
> +	int ret;
> +
> +	r = malloc(sizeof(struct erofs_compress_hints));
> +	if (!r)
> +		return -ENOMEM;
> +
> +	ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
> +	if (ret) {
> +		dump_regerror(ret, s, &r->reg);
> +		goto err_out;
> +	}
> +	r->physical_clusterblks = blks;
> +
> +	list_add_tail(&r->list, &compress_hints_head);
> +	erofs_info("compress hint %s (%u) is inserted", s, blks);
> +	return ret;
> +
> +err_out:
> +	free(r);
> +	return ret;
> +}
> +
> +bool z_erofs_apply_compress_hints(struct erofs_inode *inode)
> +{
> +	const char *s;
> +	struct erofs_compress_hints *r;
> +	unsigned int pclusterblks;
> +
> +	if (inode->z_physical_clusterblks)
> +		return true;
> +
> +	s = erofs_fspath(inode->i_srcpath);
> +	pclusterblks = cfg.c_pclusterblks_def;
> +
> +	list_for_each_entry(r, &compress_hints_head, list) {
> +		int ret = regexec(&r->reg, s, (size_t)0, NULL, 0);
> +
> +		if (!ret) {
> +			pclusterblks = r->physical_clusterblks;
> +			break;
> +		}
> +		if (ret != REG_NOMATCH)
> +			dump_regerror(ret, s, &r->reg);
> +	}
> +	inode->z_physical_clusterblks = pclusterblks;
> +
> +	/* pclusterblks is 0 means this file shouldn't be compressed */
> +	return !!pclusterblks;
> +}
> +
> +void erofs_cleanup_compress_hints(void)
> +{
> +	struct erofs_compress_hints *r, *n;
> +
> +	list_for_each_entry_safe(r, n, &compress_hints_head, list) {
> +		list_del(&r->list);
> +		free(r);
> +	}
> +}
> +
> +int erofs_load_compress_hints(void)
> +{
> +	char buf[PATH_MAX + 100];
> +	FILE *f;
> +	unsigned int line, max_pclustersize = 0;
> +
> +	if (!cfg.c_compress_hints_file)
> +		return 0;
> +
> +	f = fopen(cfg.c_compress_hints_file, "r");
> +	if (!f)
> +		return -errno;
> +
> +	for (line = 1; fgets(buf, sizeof(buf), f); ++line) {
> +		unsigned int pclustersize;
> +		char *pattern;
> +
> +		pclustersize = atoi(strtok(buf, "\t "));
> +		pattern = strtok(NULL, "\n");
> +		if (!pattern || *pattern == '\0') {
> +			erofs_err("cannot find a match pattern at line %u",
> +				  line);
> +			return -EINVAL;
> +		}
> +		if (pclustersize % EROFS_BLKSIZ) {
> +			erofs_warn("invalid physical clustersize %u, "
> +				   "use default pclusterblks %u",
> +				   pclustersize, cfg.c_pclusterblks_def);
> +			continue;
> +		}
> +		erofs_insert_compress_hints(pattern,
> +					    pclustersize / EROFS_BLKSIZ);
> +
> +		if (pclustersize > max_pclustersize)
> +			max_pclustersize = pclustersize;
> +	}
> +	fclose(f);
> +	if (cfg.c_pclusterblks_max * EROFS_BLKSIZ < max_pclustersize) {
> +		cfg.c_pclusterblks_max = max_pclustersize / EROFS_BLKSIZ;
> +		erofs_warn("update max pclusterblks to %u", cfg.c_pclusterblks_max);
> +	}
> +	return 0;
> +}
> diff --git a/lib/config.c b/lib/config.c
> index 4757dbbfdd4c..cc2aa7d0112f 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -24,7 +24,8 @@ void erofs_init_configure(void)
>   	cfg.c_unix_timestamp = -1;
>   	cfg.c_uid = -1;
>   	cfg.c_gid = -1;
> -	cfg.c_physical_clusterblks = 1;
> +	cfg.c_pclusterblks_max = 1;
> +	cfg.c_pclusterblks_def = 1;
>   	cfg.c_max_decompressed_extent_bytes = -1;
>   }
>   
> diff --git a/lib/inode.c b/lib/inode.c
> index 6024e8c593dd..5bad75e1c550 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -23,6 +23,7 @@
>   #include "erofs/xattr.h"
>   #include "erofs/exclude.h"
>   #include "erofs/block_list.h"
> +#include "erofs/compress_hints.h"
>   
>   #define S_SHIFT                 12
>   static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
> @@ -327,6 +328,8 @@ static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
>   /* rules to decide whether a file could be compressed or not */
>   static bool erofs_file_is_compressible(struct erofs_inode *inode)
>   {
> +	if (cfg.c_compress_hints_file)
> +		return z_erofs_apply_compress_hints(inode);
>   	return true;
>   }
>   
> @@ -849,6 +852,7 @@ static struct erofs_inode *erofs_new_inode(void)
>   
>   	inode->bh = inode->bh_inline = inode->bh_data = NULL;
>   	inode->idata = NULL;
> +	inode->z_physical_clusterblks = 0;
>   	return inode;
>   }
>   
> diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
> index bc0a10be72a1..1446cb56db30 100644
> --- a/man/mkfs.erofs.1
> +++ b/man/mkfs.erofs.1
> @@ -88,6 +88,17 @@ Display this help and exit.
>   .TP
>   .B \-\-max-extent-bytes #
>   Specify maximum decompressed extent size # in bytes.
> +.TP
> +.BI "\-\-compress-hints " file
> +If the optional
> +.BI "\-\-compress-hints " file
> +argument is given,
> +.B mkfs.erofs
> +uses it to apply the per-file compression strategy. Each line is defined by
> +tokens separated by spaces in the following form:
> +.RS 1.2i
> +<pcluster-in-bytes> <match-pattern>
> +.RE
>   .SH AUTHOR
>   This version of \fBmkfs.erofs\fR is written by Li Guifu <blucerlee@gmail.com>,
>   Miao Xie <miaoxie@huawei.com> and Gao Xiang <xiang@kernel.org> with
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 40ca94ff8db9..addefcefea38 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -21,6 +21,7 @@
>   #include "erofs/xattr.h"
>   #include "erofs/exclude.h"
>   #include "erofs/block_list.h"
> +#include "erofs/compress_hints.h"
>   
>   #ifdef HAVE_LIBUUID
>   #include <uuid.h>
> @@ -42,6 +43,7 @@ static struct option long_options[] = {
>   	{"random-pclusterblks", no_argument, NULL, 8},
>   #endif
>   	{"max-extent-bytes", required_argument, NULL, 9},
> +	{"compress-hints", required_argument, NULL, 10},
>   #ifdef WITH_ANDROID
>   	{"mount-point", required_argument, NULL, 512},
>   	{"product-out", required_argument, NULL, 513},
> @@ -87,6 +89,7 @@ static void usage(void)
>   	      " --all-root            make all files owned by root\n"
>   	      " --help                display this help and exit\n"
>   	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
> +	      " --compress-hints=X    specify a file to configure per-file compression strategy\n"
>   #ifndef NDEBUG
>   	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
>   #endif
> @@ -95,7 +98,7 @@ static void usage(void)
>   	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
>   	      " --product-out=X       X=product_out directory\n"
>   	      " --fs-config-file=X    X=fs_config file\n"
> -	      " --block-list-file=X    X=block_list file\n"
> +	      " --block-list-file=X   X=block_list file\n"
>   #endif
>   	      "\nAvailable compressors are: ", stderr);
>   	print_available_compressors(stderr, ", ");
> @@ -286,6 +289,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   				return -EINVAL;
>   			}
>   			break;
> +		case 10:
> +			cfg.c_compress_hints_file = optarg;
> +			break;
>   #ifdef WITH_ANDROID
>   		case 512:
>   			cfg.mount_point = optarg;
> @@ -312,7 +318,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   					  optarg);
>   				return -EINVAL;
>   			}
> -			cfg.c_physical_clusterblks = i / EROFS_BLKSIZ;
> +			cfg.c_pclusterblks_max = i / EROFS_BLKSIZ;
> +			cfg.c_pclusterblks_def = cfg.c_pclusterblks_max;
>   			break;
>   
>   		case 1:
> @@ -578,6 +585,13 @@ int main(int argc, char **argv)
>   		goto exit;
>   	}
>   
> +	err = erofs_load_compress_hints();
> +	if (err) {
> +		erofs_err("Failed to load compress hints %s",
> +			  cfg.c_compress_hints_file);
> +		goto exit;
> +	}
> +
>   	err = z_erofs_compress_init(sb_bh);
>   	if (err) {
>   		erofs_err("Failed to initialize compressor: %s",
> @@ -626,6 +640,7 @@ exit:
>   	erofs_droid_blocklist_fclose();
>   #endif
>   	dev_close();
> +	erofs_cleanup_compress_hints();
>   	erofs_cleanup_exclude_rules();
>   	erofs_exit_configure();
>   

