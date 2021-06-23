Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8BF3B1823
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Jun 2021 12:33:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G902z3HkVz304G
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Jun 2021 20:32:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1624444379;
	bh=Ail6zmYFaDutZaQS2pbxaGQHAOfnuV/enVPpVd2yiL0=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YNIDaneSOPBEXddiDERIXKDZenFiHL7Dwx2uvozX/IFo37ghDaD6dgHLrPuu1CJkN
	 dUZivumWXKWCDmbr1tzZ04O3ZqEL7UdCg2BJn041iH9Fh0wMujHaXAkjvfI1VB+cZC
	 aRoCrz+iBEracd/nSsMFYtez6aPs0xOZ1nvcI2QvaEMboKuu2Bp86Zqf1dhBYo0Fdt
	 kkX+uuLyCUz9McbasQSy45JCkY29a0ta65OW/l0KsItQodw1FML9h9eokk3jJAc/SY
	 T0gMjXr2Qoxq/V4hYI33Kjt3WUfUMX13A3esaD7qhmqFTV/ggKcW2x0UgNIFqDDO2Z
	 6bDG6Y7+6Qj1A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.73;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=PUNhEh+8; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320073.outbound.protection.outlook.com [40.107.132.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G902s3QHmz2yR7
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Jun 2021 20:32:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSuPq6N7460Q9tWjmyfgHnSMzpz9BKchEN9wxLv11doQHA/BhEBl4Q4gJ1DpCLRQTwL/EXGciizML6mGd58Qcwy09SdHbM1SGe35HdOUXH2ToH1Fuk/pnSourTCg7tGTxYPfltpdVm2xp3wr9gC/uLxf2HnPLfm1IRAOeha63JgBhi5UsgJY6oFUT3alseIOfvHGFjzkayFOs5fxsQcu5cP1g2k6o1Jg65/7BQt9/9LRWnpQKlHQ1BWARl/G1mBEDYkN64ScqJVpdZZkpBAvxWxSRssmGZ7duOL+R8eonqojbV/uk4ZZnfDOR/xExYL6xSxZpYJRu43hot2ajMcIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ail6zmYFaDutZaQS2pbxaGQHAOfnuV/enVPpVd2yiL0=;
 b=VvEsLbL8FTizQLV89CwnTwF70nGfYRX79sysVPIBtsr15oMriOpIiwfTCcNzEW9IAXcU/UcRmCJxfwlV+eFgVOQrNxFH2nvAd2/KhUfwyebQoGSFcESEmSI+rblx0QMvrG6hNMwFmAv6GhB4q5HdK1URNnKuZjpeDXulMZu5P6IYO6ng/jp8kzrBMP4Xgs6JiwTQKfwnApDiz6YuLk9FycOgO/PSTIaEgoU6aZrPtZ+JmqZF3NZ/q0dmwT7s/k8HB2I0mO0uV8Fj3Qlpr+TEluSCHCJRo2UHbDwICCZJQwrgfFfrs5CpVz+6AhN43hejlhIemyHiF3+EhiDqQwY63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3942.apcprd02.prod.outlook.com (2603:1096:4:89::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Wed, 23 Jun 2021 10:32:42 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::d984:518:d39c:9de5]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::d984:518:d39c:9de5%3]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 10:32:41 +0000
Subject: Re: [PATCH] AOSP: erofs-utils: add block list support
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org, xiang@kernel.org
References: <20210622030232.1176-1-zbestahu@gmail.com>
Message-ID: <a4be377d-50b7-319d-403b-b2a27fa40049@oppo.com>
Date: Wed, 23 Jun 2021 18:32:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210622030232.1176-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.255.79.105]
X-ClientProxiedBy: HK2PR02CA0150.apcprd02.prod.outlook.com
 (2603:1096:202:16::34) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.7.229] (58.255.79.105) by
 HK2PR02CA0150.apcprd02.prod.outlook.com (2603:1096:202:16::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 10:32:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2b69f10-b23d-444b-e180-08d9363239f8
X-MS-TrafficTypeDiagnostic: SG2PR02MB3942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB39421E4EF22E7E3BD23333F2C3089@SG2PR02MB3942.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0PXw4JU7puet2FQBhTi7LPnP/PAiSCDTBct2KmmSJeVFRiS5Ms2v9gxvFKqs1CRZuyYfHkK5Aef2FEnbhjZ2hNZhR8JPHDcAghqPBA7s8jZvoruzjMPlvJfbMspVSopHnqKU3hwEQ/LcMvl8koUQVC/+ITYEnb+yvbDbASRrv3v+011t7CwfaTif5t2CXS7KpW+mc+JwoqJ3P3vIzdK2QQ4VMYCCxcJ0qaxzPZ9NwOR0SC859E/8qe4EHJpY53JXvXo7THP/HbniOM7RPjaXR4y4kncBez7Rk3igIEWmla/dkTvlB7Sl7C8VMj1fFarU4xlC3TZTylFWpBJCs3W0OpPs+6g/RMwQ/ndnnoU0b+HsizfEDS0aA6+gM7PGYWmFkeSgF1hR4ZXedRgMmRGSrnFQWMOX4xk0m+X4DMFf2uHD84ujoLqubYgY/C39kozqgQwLuHOGQ1NTdPqAXwhJ4tLwiryCN3AS5lYuBEXUoiu9g+CoxGv+TKQ0rtLj+DHLI/eVmReKR9dMnDuC0iYRbBUYblD6ru52+rXEx+kBZnmGHahu6lIqu3MmZUwA4wt0Hb6v/iTZCWWfNohh6fCeNsZteHmlHaM7sS2Um+y2yWhVe7Jcls73E/fFLRipWBYeSvHcN1cEqRnDEwxeG/RUoq6qjUQ7xg+gKQTaJtwCGcGr2AT+VNcYKcOvCUpS1E/4oBBAlUqzuu/WSolrwopKxD2GhDP2B8EFhFr1BAy/kE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(346002)(396003)(376002)(136003)(956004)(4326008)(66946007)(52116002)(2616005)(316002)(2906002)(8676002)(16576012)(6486002)(66476007)(53546011)(31686004)(31696002)(107886003)(66556008)(38350700002)(38100700002)(26005)(83380400001)(478600001)(186003)(36756003)(16526019)(54906003)(8936002)(5660300002)(86362001)(11606007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2JncUI0RXNTaHI3Z1B2U2RuWS9QS05HM29DSTgyTlNsTlZYTG5FSVpod2F4?=
 =?utf-8?B?NEhlSElqMmdseGVVSjhPeEpsajA3QWd4N2VJbEFobkNsWEhXYVNpMit4MUZG?=
 =?utf-8?B?K3JkblpySEhmcDMvek1USU0xSmxGb0dJd09Eb3V1TFBDa0UvTTgwQVFNKzZD?=
 =?utf-8?B?bnhYU2FNNlgxN0NpYW1KNWdwQnhWb3Baa0Z4VnRleE9zNXNKNnR4UGFNSk9Q?=
 =?utf-8?B?V3F4ZnBtUzFTQ09lMlVQY3h4ZDJMSkcvTjZISkxFd1BBK2t0TUhJY1VWN2hR?=
 =?utf-8?B?UElmNkZ5QmhscUtvM3U1a2xocytUZXROelZSN0FIQkJLK3ZuekdBSis0Mk56?=
 =?utf-8?B?bWxaVm11ZUg1WGpFWk1ZQ0xhQUFPWW90NFBlNXhqMnVTN2E3Z0UzMkc0Y0Zt?=
 =?utf-8?B?MzNqV2xIV01WVFl1bGxjU2tYTFJhUE9QSXRIZWhHRG1ZeHZSeVdMaXhHTGFE?=
 =?utf-8?B?Z21EZld3N3czT2RqZDE3SWg4alUvTlVmTWRndFBvU1FxcXFiZWI1cmVzYkNh?=
 =?utf-8?B?L3JycmpXdWlZdkdjTGROdnhYUFF5c3I0RFhmelVCMW44MnVsTDlEOFQ1OHVB?=
 =?utf-8?B?ZnJuVE5vU1dZb01tRmc0NTVLOUUvTHNFTjgySUhXQXZGRjlwRTVRWk9BMVAv?=
 =?utf-8?B?amoxWUgyUmdESndZNTR0OTBITVhDWEJ3R1FLbGlQT2NwbDhNSDM2K1lONzRS?=
 =?utf-8?B?aTBXdkhnM3BIVGVLSGpoMjZxbWVCd0wzTkU2UjNwbGxaZ2hjdUI2UWVrU1c2?=
 =?utf-8?B?bFdEeURpQmE0TUowMlhmcVNsMkFmK0FpM2tLZ0JVZTZPcU53T0pSNHNBeTZN?=
 =?utf-8?B?UU53dnFwU3dNeWljbzYvbG15d0Fmc0Y5UWxHUFdVZ3Q1eURUTW5CNDd1SEw1?=
 =?utf-8?B?dWVpWGhlVTBFS2hLRlpSTklaaHZERXk0ajQ0MWh4RFVvWkphUFQ1c0h1Mk1r?=
 =?utf-8?B?TGlwYm5zeGVvQXBFNlBEZVpITmRYVDVvbkN5Qm1TMGZDdU1DYk1IRmtiRTNU?=
 =?utf-8?B?NUFCOFd5aTUvSmpWL2hrME5STGNrSXlxL2trM3I5dExHNW9QMnBNc3dXRzZF?=
 =?utf-8?B?MTRGTjd2NlhSdnpiQkJlNUxiMUlYcWh0dDRrK29UYW1sMlExcHUrckNLZzdp?=
 =?utf-8?B?SXNPaHZBMzFyU2VYN3ltSjRpOEtadlR5OHJZNkQwZXd0Vm9haW9yelJ3YzVp?=
 =?utf-8?B?d05JMXhhb0VDcXZkL0pQTXJXK09KQ09LUlhqbWZQUFUyT2FQOXc2akZpbVB2?=
 =?utf-8?B?NEs1Z3dMUUZFbVVJNDFKYlFWZ1NPczVxN1JOVC96R0dzc0VTSTlaZkF4bmVo?=
 =?utf-8?B?OUhMNkllelUzNFkycHNhVXZMbSszV3ZCWHpRdyt2bnJLRktuQnorbXVFdnVu?=
 =?utf-8?B?NlpPMVlZZzA2QzJqQzBXQmY5bUJUcE5yZFp1eVhGOW9DdHY5RW1wTHAvVjVv?=
 =?utf-8?B?MFRYOXJpS3M3ZEdqTHdUL3g5ZmhhY2x6VW9EYVRKWkEzb0txaUtIUnAzNFc5?=
 =?utf-8?B?WndwVUNvKy8wanEwMFc4T3czODYrVGkxTzBPaEZldDgzUmtEbDY4eE94V0hw?=
 =?utf-8?B?V2t3QUJQTUVkOGZRUVdvclZPY3VwdzVDTDZ2WVRaUmVQODY2VkdCbEFDbWdW?=
 =?utf-8?B?YUNoNG9uL3RraXlieW1jNFJDcmVMd1BYNXdrejZXbThUUFRkQitVUk13Z0d2?=
 =?utf-8?B?T0pBWWp6c3IvRVlnMFlrTWFWcmNkeVBseTg3UTZqTDgzNWQzVktsL2h0MGJ1?=
 =?utf-8?Q?V/S1fEWCjNfyXa5lvoFzmctMhiL0we3w2aY21Ty?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b69f10-b23d-444b-e180-08d9363239f8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 10:32:41.6532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaxLTKJlnKKhuskPKRmX7482gtzR6LKqbCd9Bc3JzrxchRBiK2jLuULgsGM0JgN6yGdlxM2KZAb452P1CccYJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3942
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
Cc: "yh@oppo.com" <yh@oppo.com>, huyue2@yulong.com,
 Weichao Guo <guoweichao@oppo.com>, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

This patch works well for us.

Tested-by: Huang Jianan <huangjianan@oppo.com>

Thanks,

Jianan

On 2021/6/22 11:02, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
>
> Android update engine will treat EROFS filesystem image as one single
> file. Let's add block list support to optimize OTA size.
>
> Change-Id: I21d6177dff0ee65d3c57023b102e991d40873f0d
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>   include/erofs/block_list.h | 19 ++++++++++
>   include/erofs/config.h     |  1 +
>   lib/block_list.c           | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>   lib/compress.c             |  8 +++++
>   lib/inode.c                | 21 ++++++++++-
>   mkfs/main.c                | 17 +++++++++
>   6 files changed, 151 insertions(+), 1 deletion(-)
>   create mode 100644 include/erofs/block_list.h
>   create mode 100644 lib/block_list.c
>
> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> new file mode 100644
> index 0000000..cbf1050
> --- /dev/null
> +++ b/include/erofs/block_list.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * erofs-utils/include/erofs/block_list.h
> + *
> + * Copyright (C), 2021, Coolpad Group Limited.
> + * Created by Yue Hu <huyue2@yulong.com>
> + */
> +#ifndef __EROFS_BLOCK_LIST_H
> +#define __EROFS_BLOCK_LIST_H
> +
> +#include "internal.h"
> +
> +int block_list_fopen(void);
> +void block_list_fclose(void);
> +void write_block_list(const char *path, erofs_blk_t blk_start,
> +                      erofs_blk_t nblocks, bool has_tail);
> +void write_block_list_tail_end(const char *path, erofs_blk_t nblocks,
> +                               bool inline_data, erofs_blk_t blkaddr);
> +#endif
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index d140a73..67e7a0f 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -65,6 +65,7 @@ struct erofs_configure {
>   	char *mount_point;
>   	char *target_out_path;
>   	char *fs_config_file;
> +	char *block_list_file;
>   #endif
>   };
>   
> diff --git a/lib/block_list.c b/lib/block_list.c
> new file mode 100644
> index 0000000..6ebe0f9
> --- /dev/null
> +++ b/lib/block_list.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * erofs-utils/lib/block_list.c
> + *
> + * Copyright (C), 2021, Coolpad Group Limited.
> + * Created by Yue Hu <huyue2@yulong.com>
> + */
> +#ifdef WITH_ANDROID
> +#include <stdio.h>
> +
> +#include "erofs/block_list.h"
> +
> +#define pr_fmt(fmt) "EROFS block_list: " FUNC_LINE_FMT fmt "\n"
> +#include "erofs/print.h"
> +
> +static FILE *block_list_fp = NULL;
> +
> +int block_list_fopen(void)
> +{
> +	if (block_list_fp)
> +		return 0;
> +
> +	block_list_fp = fopen(cfg.block_list_file, "w");
> +
> +	if (block_list_fp == NULL)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +void block_list_fclose(void)
> +{
> +	if (block_list_fp) {
> +		fclose(block_list_fp);
> +		block_list_fp = NULL;
> +	}
> +}
> +
> +void write_block_list(const char *path, erofs_blk_t blk_start,
> +		      erofs_blk_t nblocks, bool has_tail)
> +{
> +	const char *fspath = erofs_fspath(path);
> +
> +	if (!block_list_fp || !cfg.mount_point)
> +		return;
> +
> +	/* only tail-end data */
> +	if (!nblocks)
> +		return;
> +
> +	fprintf(block_list_fp, "/%s", cfg.mount_point);
> +
> +	if (fspath[0] != '/')
> +		fprintf(block_list_fp, "/");
> +
> +	if (nblocks == 1) {
> +		fprintf(block_list_fp, "%s %u", fspath, blk_start);
> +	} else {
> +		fprintf(block_list_fp, "%s %u-%u", fspath, blk_start,
> +			blk_start + nblocks - 1);
> +	}
> +
> +	if (!has_tail)
> +		fprintf(block_list_fp, "\n");
> +}
> +
> +void write_block_list_tail_end(const char *path, erofs_blk_t nblocks,
> +			       bool inline_data, erofs_blk_t blkaddr)
> +{
> +	if (!block_list_fp || !cfg.mount_point)
> +		return;
> +
> +	if (!nblocks && !inline_data) {
> +		erofs_dbg("%s : only tail-end non-inline data", path);
> +		write_block_list(path, blkaddr, 1, false);
> +		return;
> +	}
> +
> +	if (nblocks) {
> +		if (!inline_data)
> +			fprintf(block_list_fp, " %u", blkaddr);
> +
> +		fprintf(block_list_fp, "\n");
> +	}
> +}
> +#endif
> diff --git a/lib/compress.c b/lib/compress.c
> index 2093bfd..5dec0c3 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -19,6 +19,10 @@
>   #include "erofs/compress.h"
>   #include "compressor.h"
>   
> +#ifdef WITH_ANDROID
> +#include "erofs/block_list.h"
> +#endif
> +
>   static struct erofs_compress compresshandle;
>   static int compressionlevel;
>   
> @@ -553,6 +557,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
>   		   inode->i_srcpath, (unsigned long long)inode->i_size,
>   		   compressed_blocks);
>   
> +#ifdef WITH_ANDROID
> +	write_block_list(inode->i_srcpath, blkaddr, compressed_blocks, false);
> +#endif
> +
>   	/*
>   	 * TODO: need to move erofs_bdrop to erofs_write_tail_end
>   	 *       when both mkfs & kernel support compression inline.
> diff --git a/lib/inode.c b/lib/inode.c
> index 787e5b4..6be23cb 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -22,6 +22,10 @@
>   #include "erofs/xattr.h"
>   #include "erofs/exclude.h"
>   
> +#ifdef WITH_ANDROID
> +#include "erofs/block_list.h"
> +#endif
> +
>   #define S_SHIFT                 12
>   static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
>   	[S_IFREG >> S_SHIFT]  = EROFS_FT_REG_FILE,
> @@ -369,6 +373,12 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
>   			return -EIO;
>   		}
>   	}
> +
> +#ifdef WITH_ANDROID
> +	if (nblocks)
> +		write_block_list(inode->i_srcpath, inode->u.i_blkaddr,
> +				 nblocks, inode->idata_size ? true : false);
> +#endif
>   	return 0;
>   }
>   
> @@ -626,6 +636,7 @@ static struct erofs_bhops erofs_write_inline_bhops = {
>   int erofs_write_tail_end(struct erofs_inode *inode)
>   {
>   	struct erofs_buffer_head *bh, *ibh;
> +	erofs_off_t pos;
>   
>   	bh = inode->bh_data;
>   
> @@ -640,7 +651,6 @@ int erofs_write_tail_end(struct erofs_inode *inode)
>   		ibh->op = &erofs_write_inline_bhops;
>   	} else {
>   		int ret;
> -		erofs_off_t pos;
>   
>   		erofs_mapbh(bh->block);
>   		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
> @@ -658,6 +668,15 @@ int erofs_write_tail_end(struct erofs_inode *inode)
>   		free(inode->idata);
>   		inode->idata = NULL;
>   	}
> +
> +#ifdef WITH_ANDROID
> +	if (!S_ISDIR(inode->i_mode) && !S_ISLNK(inode->i_mode))
> +		write_block_list_tail_end(inode->i_srcpath,
> +					  inode->i_size / EROFS_BLKSIZ,
> +					  inode->bh_inline ? true: false,
> +					  erofs_blknr(pos));
> +#endif
> +
>   out:
>   	/* now bh_data can drop directly */
>   	if (bh) {
> diff --git a/mkfs/main.c b/mkfs/main.c
> index e476189..d5a5e07 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -27,6 +27,10 @@
>   #include <uuid.h>
>   #endif
>   
> +#ifdef WITH_ANDROID
> +#include "erofs/block_list.h"
> +#endif
> +
>   #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
>   
>   static struct option long_options[] = {
> @@ -47,6 +51,7 @@ static struct option long_options[] = {
>   	{"mount-point", required_argument, NULL, 10},
>   	{"product-out", required_argument, NULL, 11},
>   	{"fs-config-file", required_argument, NULL, 12},
> +	{"block-list-file", required_argument, NULL, 13},
>   #endif
>   	{0, 0, 0, 0},
>   };
> @@ -95,6 +100,7 @@ static void usage(void)
>   	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
>   	      " --product-out=X       X=product_out directory\n"
>   	      " --fs-config-file=X    X=fs_config file\n"
> +	      " --block-list-file=X    X=block_list file\n"
>   #endif
>   	      "\nAvailable compressors are: ", stderr);
>   	print_available_compressors(stderr, ", ");
> @@ -293,6 +299,9 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   		case 12:
>   			cfg.fs_config_file = optarg;
>   			break;
> +		case 13:
> +			cfg.block_list_file = optarg;
> +			break;
>   #endif
>   		case 'C':
>   			i = strtoull(optarg, &endptr, 0);
> @@ -541,6 +550,11 @@ int main(int argc, char **argv)
>   		erofs_err("failed to load fs config %s", cfg.fs_config_file);
>   		return 1;
>   	}
> +
> +	if (cfg.block_list_file && block_list_fopen() < 0) {
> +		erofs_err("failed to open %s", cfg.block_list_file);
> +		return 1;
> +	}
>   #endif
>   
>   	erofs_show_config();
> @@ -607,6 +621,9 @@ int main(int argc, char **argv)
>   		err = erofs_mkfs_superblock_csum_set();
>   exit:
>   	z_erofs_compress_exit();
> +#ifdef WITH_ANDROID
> +	block_list_fclose();
> +#endif
>   	dev_close();
>   	erofs_cleanup_exclude_rules();
>   	erofs_exit_configure();
