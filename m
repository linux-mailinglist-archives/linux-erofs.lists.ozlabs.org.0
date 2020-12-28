Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADBC2E3641
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 12:14:45 +0100 (CET)
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4FLn1JYxzDqCD
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 22:14:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.131.55;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature verification failed" (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=w7Ux1UU/; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-eopbgr1310055.outbound.protection.outlook.com [40.107.131.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4FLQ3DsVzDqBd
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 22:14:20 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ7t09c97YSULRZ8w86FV6Mp6AbC+1k2kMf+qowXQBRyW7motIC6OHK+sU7VMxJO8phvggo6m4uF57mJ5jKcALt0JJTxH/z0//6yzc0DARtacZcgcGFI8pD3ogN7XugS39EDWtp/fh8XvVmuD6Ltz3FEPEmw86LNJF9PeC9lad0yE2FGMvh17t9/V27fNj7Xc4XOePd7/4USW7b9OxxwEVZKrf+WSyCqWo0I9+TypRdTkFKXRySEmRQflwZhV6rRaq0YPIsXyyRzxeQ9tCvebkXJOyuaplRHBXq7iZGJvMl2lS3eKhbX1RObFssseNGnNfhXC/JjsCYsSygQDBtSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku9C4c7HJHAoapIfqk3K1pU7K4utwwTxQUM/BGPZWsw=;
 b=i0CVaBmc2ya4o/PYU6vhwYclX2p7CO+uybF06AdFcsJhZRtrtPwtBiETaCJ2fRXXhS4NvKoqjSMBzaqdct1gZVsnWIFEVoYwoOjWkElcFsvUYl2J0dVfLu4Z0iZsSWKURpgBO9mRbhTrTiEvDm8u77u0UJPP8aVy0pNkKjNwgKu3aQDv+5cZj5qISdK/NVMJIe9zbl/KA9dVa8hRLPlbqsXgnOjjgux36234oWmJ0AtOQA6yUaUZVK9LISj53pMeufGwg1oI2osSLgCzRy9wDjBd+LMcmNUrB8wnMzKFg3zQP1WjvAxlzTT2rlEfYTZuDIGB8UWC6fxmsuepdm5wGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku9C4c7HJHAoapIfqk3K1pU7K4utwwTxQUM/BGPZWsw=;
 b=w7Ux1UU/ZCwmSxf+FSsFwAOJQ2JfrYbYiVRLjDo0uE7Fx2myTzlFwdoAmUyG4Tr6+FZpWlyltEnrz6WJbhi4W4XxwAvyt4PiAkl3fhegW0wcw+kYgbKThR8sXZQM3ZfJLuG8SLV6zEtNS4rdh/jZTqrHLYTbjDPwxJhd7WNoq5U=
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4106.apcprd02.prod.outlook.com (2603:1096:4:9b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.31; Mon, 28 Dec 2020 11:14:08 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 11:14:08 +0000
Subject: Re: [PATCH v2] AOSP: erofs-utils: fix sub-directory prefix for canned
 fs_config
To: Gao Xiang <hsiangkao@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20201226062736.29920-1-hsiangkao@aol.com>
 <20201228105146.2939914-1-hsiangkao@redhat.com>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <1c0e0b37-fcbe-3e5f-9f8d-8ee6f74bc089@oppo.com>
Date: Mon, 28 Dec 2020 19:14:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201228105146.2939914-1-hsiangkao@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HKAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:c8::13) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by
 HKAPR03CA0008.apcprd03.prod.outlook.com (2603:1096:203:c8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.12 via Frontend Transport; Mon, 28 Dec 2020 11:14:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c314fa7b-c6fb-4cd6-d880-08d8ab21b238
X-MS-TrafficTypeDiagnostic: SG2PR02MB4106:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB410620D397CBF61312DB593CC3D90@SG2PR02MB4106.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTfja2uZ+7IiOR5HH1piMsVvqViPC3tvUdjhrthZRN+TbzhoJJ66dulVvUhtI80wABkMSt73wiKFDlZolDLhcUohkjEhATsIijLvSuutOCjwGchBZ0MLgYGK9ohmb17HW/ILMPWvYUZMfdcFIkqxPpY0usb/XiFa0jG13fTWiQ7hBk9St+FfisjYbU13GpjkYuJI0E7NZ8zTEFExLIczmcQDHGlbrw/Uv42XpWcNEV8V4zSOHLIOtSwVknElwCP/QpzN0dw37p4BpS2CuMh0vlT9ysQz7o41k0arRZhi/s3e28/ct2T51gdD4BbjeU0YlFfJhvTp5/LAFnKDSlCNCcTqvg796NR4Sh5o3vvOCgnxt85PFhijbTs0SRBvZ+B0gGTCAfZu8BC8D88Obs7LGmVwmdKM8Jjn6Pxhtrq5rWw2zJGWBpVdrom7SWrIyHtFFmvV8RvZc1TBeV2nyRtZjLt82KzKhFrLXL6TJw0Y51GWsbvzZ66++NCxFBgsFq4njjoqC2DwgkReuCOG7Dmjdsr0VeJstZSF40mOKvnOQJJpPmfAqSquSTSK5fqAiubyftf+nW+0gnfZtC0K6ugz4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(31696002)(5660300002)(66946007)(54906003)(6666004)(478600001)(16526019)(316002)(86362001)(966005)(8936002)(186003)(2906002)(4326008)(16576012)(107886003)(52116002)(26005)(956004)(2616005)(36756003)(8676002)(31686004)(6486002)(83380400001)(66556008)(66476007)(11606006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?gb2312?B?TEU3b1ZtRTV6QkFEV0tQYS9vWTFsTWJrNjNIVEVTV2NSRW1VanV2cDB4VG9Q?=
 =?gb2312?B?WTBUYVNwdEdINVBnNkxvZDhFQlQ1ZTlmMlZnZklNR1hWVzdSRG5QbmRTQXJS?=
 =?gb2312?B?aEd2NjROckNHMlYxNVlkamxSMFFSUUp6UFBJVk11TkNYMzVWQjBUQ1VYU1Ev?=
 =?gb2312?B?RHJIWEVmcUErK2xNa2VUV0oyK082WUVCZUV3ZkEvRDhuWUpZMXZZSk9mUGJz?=
 =?gb2312?B?b3EweDJaaWVJZlpnamx3dWY4UStrOGRnbml3UDRITFlDbDNiekRnVlE4K1dm?=
 =?gb2312?B?Y1dvYVQvcTdJOGIzaHk1QmJLNFlrT3phbzR5VHpWSzlEemNPVXUvcjNiaFBj?=
 =?gb2312?B?eHc3Nkg1SUh3MGQxME5PaVNXM0tUQTBQazdkTUEyOUwyb2sraVFrVTdmWTdk?=
 =?gb2312?B?WkpOVVJlSm4yTGJ5alRNcnpvcXgyaWdmRWYwMGh1d0xaR0RIZXY4ZkhUQjZt?=
 =?gb2312?B?Ny9Ba3YyWFkxVEVSWFBLWjJWL2gyTUZBTTd1dUJpaWM5N2t6aXhPZ0tablJS?=
 =?gb2312?B?cE5QUEh1ODVWQ3VKalNDeXlRK0Q1bU9LWjlZVHpTTDNabTV0TThKdjR6bHgw?=
 =?gb2312?B?WmZGMnZmSHl3T3NFdk16bGdjeEtpdzRzNjVUUHZ2em83R3owN1NLTkFXQU5Y?=
 =?gb2312?B?cEpZMTFFYUtFUTRFdlh2akhrY211dkJWc3F2RnRaL2ZveE9ydUU1aExJUHNw?=
 =?gb2312?B?bm05czBzQ1hkbVhSdXVYVjArVFpUTnhtZCtscmpJTTdCUFNiak1OWUh1MExH?=
 =?gb2312?B?ZHBwN3J5VjVkUzFKbmN4bExZeWFqZVRIZ0xCY3VuNzZVVFNMRERuRDd6VERK?=
 =?gb2312?B?NzhVYno2UVJGOW9PNUIxRmMvc09wVFlhaTNvazJ1ai8yWFpLM0JzQnFINkpO?=
 =?gb2312?B?SUxudTkvYWVtb21DTG9iMHBSZHpJNDRza0JQU09uRVU5bFRIVDRlT3p5S2d4?=
 =?gb2312?B?alZSbG9QdXFUY1MyYnQ3RlZzQWVLNU10VW11OGVpbG1zTGp3RmxyQWFNK0Zo?=
 =?gb2312?B?ZDZpWndlcE9wVXhBUDRhUEtwdEJDZnUyV05SempDRnlwTFlWSGZtNm8yNTRw?=
 =?gb2312?B?NVliY3lzRk5zYU55K05rUXhCcFE5VWtBNFdnS3R1aTBtaGdmQlN4Nk1IVmZx?=
 =?gb2312?B?WWNwSStBKzVKbXlmZVl3Q2FFbVFtbDVTd3F6RUxIVGJBZXFUaWpPcHpRbDJW?=
 =?gb2312?B?WkdTd1NJdkN5WjVnME9kNjhVSDd2T1hDMUZxTHRHaDJ5bTYwS3cxR1NBTStX?=
 =?gb2312?B?WnNSQmlqTFVwNXB6cE5UZ3ZMN0p1eUFhM1I2OUhHTk45cS9FdGZoOHM1RWxW?=
 =?gb2312?Q?RStPwxlrMg3cU=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 11:14:08.3866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: c314fa7b-c6fb-4cd6-d880-08d8ab21b238
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhY9Ql+laHiCLv1oSUDZWI2LFmqnSJnV3Sl9uW12P4KMQMysoOgRDYC7lqTyWYCwq5te4FKcK6mXa1hgEK22Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4106
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
Cc: zhangshiming@oppo.com, Yue Hu <zbestahu@gmail.com>,
 Yue Hu <huyue2@yulong.com>, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

This patch works well with or without --fs-config-file in build.

Tested-by: Huang Jianan <huangjianan@oppo.com>

Thanks,

Jianan

ÔÚ 2020/12/28 18:51, Gao Xiang Ð´µÀ:
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
> Link: https://lore.kernel.org/r/20201226062736.29920-1-hsiangkao@aol.com
> Fixes: 8a9e8046f170 ("AOSP: erofs-utils: add fs_config support")
> Reported-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
> changes since v2:
>   - fix IS_ROOT misuse reported by Jianan, very sorry about this since
>     I know little about canned fs_config.
>
> (please kindly test again...)
>
>   lib/inode.c | 39 +++++++++++++++++++++++++--------------
>   1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/lib/inode.c b/lib/inode.c
> index 0c4839d..e6159c9 100644
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
> +	    (cfg.fs_config_file && erofs_fspath(path)[0] == '\0')) {
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
