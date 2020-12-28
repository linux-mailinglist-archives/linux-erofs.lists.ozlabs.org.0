Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644042E35AA
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 11:03:58 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4Cn54ChrzDqCC
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 21:03:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.45;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=0VmKgj/E; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310045.outbound.protection.outlook.com [40.107.131.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4Cmy3L8wzDq9G
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 21:03:42 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HusV4ViXUCMw2dlN9A58poNvBwuASvd1sQC0afY4vCfgv7HOL7O9UzG1PFkqk81Gpyloz53rqY6o+eJbEjWHwgLnb/+JdTnmMda1KuIVx2+IbtksO2LtgAduT6/SwHcjJoy3uT0LLTtUuFTfH0P1IpJz089OxZpTjsKZiOi1vf2oGRkX3nSQJgJEqH29Blv5ISC8Wuie42o4m6KcdgU+BT7jf0KMR0LScFTWbNX/xvq5MKVG4s5jDBYIYk/10vFNHKJtEluoKA9pF8T9NqK1WRiJUahOegemve/3pJYrIVTMQ3E1XJEny/2RVpMsvn7xzO5yJ/E7ZoVPLhIKK5u6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKhCZ9dsgbf06y6ODNzZZC9iTXWniMfsMA438Bf4v54=;
 b=ICRxuVrj8yaLaNpf5pkfxshxr8V14BCdYBk9BrbreMpOkHpIKzjc7O4Re1KBEjNNnuZWKRAfKMK0uIlxEbYeUz+WYBnh0AQEU/Cu+7Y38M4x3c5FF2wKE5FT7Z7eJLMYjp6Rlwvx9HGHDMGGCIW1XDKlnw5KfI2e/xAnYK5Rhw03Y4kUXzej55wBrvFEa7mQPakO/yeWw9uony1Emzs48nd28ZJrVzEm1pe0rAXxG3/rWac6WUArQ7KDm9bGDrvbhvisEeRSjOODVmV9F8jIG+/vwd476El4U6DvGFBpK6MD9JHYrsAFF9ZtthnMb4N1IfYaOc8x/55wd3ruDpot0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKhCZ9dsgbf06y6ODNzZZC9iTXWniMfsMA438Bf4v54=;
 b=0VmKgj/EyEbVdE5HveHoK6HNScJW5eRg1axHWoB2aoRA1yaUFWWmltVz5PN3/yliOmJHYC8PQyb7PhzBFZUYZXDRAvMYMRH5s4saqv6oayrRc3g+s6yeY6rl0Yviyu4ZZfJPrG6tOnwVflRj5aULGTsEzD04Aq49uKdawYSpvTM=
Authentication-Results: aliyun.com; dkim=none (message not signed)
 header.d=none;aliyun.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3574.apcprd02.prod.outlook.com (2603:1096:4:30::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.29; Mon, 28 Dec 2020 10:03:30 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 10:03:30 +0000
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub-directory prefix for canned
 fs_config
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org
References: <20201226062736.29920-1-hsiangkao.ref@aol.com>
 <20201226062736.29920-1-hsiangkao@aol.com>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <94a271f5-2bfd-002e-a77a-93582282a6d0@oppo.com>
Date: Mon, 28 Dec 2020 18:03:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201226062736.29920-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR02CA0216.apcprd02.prod.outlook.com
 (2603:1096:201:20::28) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by
 HK2PR02CA0216.apcprd02.prod.outlook.com (2603:1096:201:20::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27 via Frontend Transport; Mon, 28 Dec 2020 10:03:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c3f5835-d0d6-48e3-867e-08d8ab17d427
X-MS-TrafficTypeDiagnostic: SG2PR02MB3574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3574705DE1270E99BEEABFF3C3D90@SG2PR02MB3574.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8OQir9BwcV4AtxSEwxZOzVKVEVQlHSUD9EkxbYUia//azedBXJ4eno9/2se0PNnBWyoRI0xinCfhYhGeVspTXgJROn0y7menv3lYq88oxTZBJHEoMoV3rzyqtd9OvOWxFb89K/D/pWNhWrmr5ethH2y0aRqRJVWs6ZhPTS1SgUzdnk+WFMFdqlVwkmQGczAjllHHjnSLAhLrVDJ4zDg+xryC54aJiM/n8ThhU38vIZ52pn+xFp+MenH1/5Q0mlOhi1LDd2HOrNCCyxVua7jRkIcsFpCNnsOcUJp7rQgMr95LdXLt516uUc9CRmF8dyPTPv2Orbr5y+JvW0agdvt/FlFO1/G3LeH2sWyJiGEj5/DvwX7xvdPbyCKybkDep2LcpPDOz0ZLhzmDEpdYW6Y73urte+KXNq/JofED/RDAS8qpNAOSBqXBnltE33gQKxU0qAzLLm5a/m4AzoS3yQM7HdMgMGefg9JXkSXdXSGF4Kt+sJ0JOqRU7q2nTRin2XzxwFvuZuVTYQ+LLice+SY3APhCG/sIz3nVyYDCNszBDoz9nKhqA023Z0Jyb/gShA1bdEmJ3MvJ/1PNT0hI4nhHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(31696002)(26005)(4326008)(66946007)(16576012)(31686004)(6666004)(8936002)(478600001)(66556008)(6486002)(16526019)(83380400001)(5660300002)(316002)(86362001)(186003)(66476007)(8676002)(966005)(2616005)(956004)(2906002)(52116002)(36756003)(11606006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?gb2312?B?NC9nQ1ZySEt0Zys1WEdZV1FZeFNPTW9HLzhsN0dlS2NWTnlXRS8vY2hnTDRt?=
 =?gb2312?B?cmcyNFRlcDJFdzIxakYwclRpT2lxQU9RVVNzZlNOaTNhZ1hMVUZVODdzVHV6?=
 =?gb2312?B?TlU3a0ZOK2pVc2JrV3ZxVVhNQjJLSzRTSGFhUjdHUVlUbGMxZ0lFaFJtVWZZ?=
 =?gb2312?B?SkJ1aGpGdjU2a1h2eUtQRkdoTmFaMlk4ZGY2cTJDNzVjdWFTREwybWZ6dTJP?=
 =?gb2312?B?TU5PdFk4dUlvOEg1VUw0a25oeThOMmFHN3dhSGs3UHZJUUdlRkhvODNKcnEy?=
 =?gb2312?B?OGZ5bUVveXB4dmtJVU4yd09wRExqS3Y2Q2hJK2d5bCt1WXh0SDJyNjRQeXBW?=
 =?gb2312?B?Uy94YTE1elZLUCtYYTQrcW11YTc0NlVDUHA3ZTRUMWw0b0lLazl6RzBOQjZm?=
 =?gb2312?B?ZlJnSmVGMDgvZTh4UjhvRFU1ekRxazlIUG9KamV4Vm53TUZaNkFGZGdETHhW?=
 =?gb2312?B?ZDRIZHROaWxyektxVWxMTmN0RjNKUW5kSTRReDJVRjZBUllvamEvVGcyUG1m?=
 =?gb2312?B?L2RuUEJ6SS8zRTU1QlowelhVVHR1MGpzaXpqc1Rod2w3bTBCYTZpNVRZRC9R?=
 =?gb2312?B?dHNRaldGL0s3eko5Q1M4V0xZTGtKNUhLQlR5dHNxbUtLWEhaSCtQQ2pvdkdB?=
 =?gb2312?B?YUQvb2xlLzVmY3lsamxOV2lIOVRBV0cyYUlPcUVjVGl2SmFGV0srWlZxaWxt?=
 =?gb2312?B?UnNqU1kyZUNrU1VZdEJGSjk2NXZJTktQSG0rOUhtOWpXQkN3d2NFZEw5TENj?=
 =?gb2312?B?MUJQU3prKzdhb2d3TzZ3WWVNZkNzTXhVSHZLK0pmQ1A3SGhuTW5vZW5ZRjIw?=
 =?gb2312?B?TmFPdWRMUDgrYmI3UTJOb1VMcDVRZHhVUWJna0toSEx0RUtxVTBqa3pwc01H?=
 =?gb2312?B?ZHdXQTFXMUpQWEpMdVpGV0U4TFIzaklaQTNxbFB5QTl4aHl2dlJaczV6Y24w?=
 =?gb2312?B?U3huNndqZjExK3prMi9mZ3BNdmtLM0FyNEh0MFJ2b3RVL1NvODR0eGZmc0Nj?=
 =?gb2312?B?cjIxSCsxcGhHeVo3TmNkY1BjVXRwZFZBV2dlbWlzRkgvWTBVeTNFOUNHRG01?=
 =?gb2312?B?ZThpdzRpeVhpbUlmK0swZ2o4YXBwejY1b0E4Q3pHN1JrTzBrVDZXTjN0NXpq?=
 =?gb2312?B?Q2Jza2Qwc2haejlGRVg2Vi9iSDkwOG9LdHF3MDIzRXhJYk1LM1BleVJRVXBG?=
 =?gb2312?B?dzJvTTYzTklOK2E5d2VkZHA0bEtGR0d2MURZRVBGUWlObjVpK2pmQ00zNWE0?=
 =?gb2312?B?Q3pBUWdiTG05dVZxbStGTC9SQ0pZbVRMUmlXSVFWNEdSMktFL2RvVGZpd29s?=
 =?gb2312?Q?eLrIdDS4dea+Y=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 10:03:30.1444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3f5835-d0d6-48e3-867e-08d8ab17d427
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Ilhl/PJnk5yfLPyMw9yK8fb9Kv58MqcrqJNgVpEaZ3uZYsgwehJYSrHe3j7BYvgMq2024kDAQ1YxnvO4mQkxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3574
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
Cc: huyue2@yulong.com, guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


ÔÚ 2020/12/26 14:27, Gao Xiang Ð´µÀ:
> From: Gao Xiang <hsiangkao@aol.com>
>
> "failed to find [%s] in canned fs_config" was observed by using
> "--fs-config-file" option as reported by Yue Hu [1].
>
> The root cause was that the mountpoint prefix to subdirectories is
> also needed if "--mount-point" presents. However, such prefix cannot
> be added by just using erofs_fspath().
>
> One exception is that the root directory itself needs to be handled
> specially for canned fs_config. For such case, the prefix of the root
> directory has to be dropped instead.
>
> [1] https://lkml.kernel.org/r/20201222020430.12512-1-zbestahu@gmail.com
>
> Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
> Reported-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> Hi Yue, Jianan,
>
> I've verified cuttlefish booting with success, It'd be better to
> verify this patchset on your sides. Please kingly leave "Tested-by:"
> if possible.
>
> Hi Guifu,
> Could you also review this patch ? This needs to be included in
> the upcoming v1.2.1 as well...
>
> Thanks,
> Gao Xiang
>
>   lib/inode.c | 39 +++++++++++++++++++++++++--------------
>   1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/lib/inode.c b/lib/inode.c
> index 0c4839dc7152..f88966d26fce 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -696,32 +696,43 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>   	/* filesystem_config does not preserve file type bits */
>   	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
>   	unsigned int uid = 0, gid = 0, mode = 0;
> -	char *fspath;
> +	const char *fspath;
> +	char *decorated = NULL;
>   
>   	inode->capabilities = 0;
> +	if (!cfg.fs_config_file && !cfg.mount_point)
> +		return 0;
> +
> +	if (!cfg.mount_point ||
> +	/* have to drop the mountpoint for rootdir of canned fsconfig */
> +	    (cfg.fs_config_file && IS_ROOT(inode))) {

Hi Xiang,

I have tested this patch with --fs-config-file, and the problem still 
exists.

IS_ROOT can't be used here to determine the root directory , because 
inode->i_parent is null at this time. It will be set after this function.

Thanks,

Jianan

> +		fspath = erofs_fspath(path);
> +	} else {
> +		if (asprintf(&decorated, "%s/%s", cfg.mount_point,
> +			     erofs_fspath(path)) <= 0)
> +			return -ENOMEM;
> +		fspath = decorated;
> +	}
> +
>   	if (cfg.fs_config_file)
> -		canned_fs_config(erofs_fspath(path),
> +		canned_fs_config(fspath,
>   				 S_ISDIR(st->st_mode),
>   				 cfg.target_out_path,
>   				 &uid, &gid, &mode, &inode->capabilities);
> -	else if (cfg.mount_point) {
> -		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> -			     erofs_fspath(path)) <= 0)
> -			return -ENOMEM;
> -
> +	else
>   		fs_config(fspath, S_ISDIR(st->st_mode),
>   			  cfg.target_out_path,
>   			  &uid, &gid, &mode, &inode->capabilities);
> -		free(fspath);
> -	}
> -	st->st_uid = uid;
> -	st->st_gid = gid;
> -	st->st_mode = mode | stat_file_type_mask;
>   
>   	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, "
>   		  "capabilities = 0x%" PRIx64 "\n",
> -		  erofs_fspath(path),
> -		  mode, uid, gid, inode->capabilities);
> +		  fspath, mode, uid, gid, inode->capabilities);
> +
> +	if (decorated)
> +		free(decorated);
> +	st->st_uid = uid;
> +	st->st_gid = gid;
> +	st->st_mode = mode | stat_file_type_mask;
>   	return 0;
>   }
>   #else
