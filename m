Return-Path: <linux-erofs+bounces-2505-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKJrOFnsqGnnygAAu9opvQ
	(envelope-from <linux-erofs+bounces-2505-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 03:37:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FDE20A3B0
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 03:37:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRDFy11nlz3bhG;
	Thu, 05 Mar 2026 13:37:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772678230;
	cv=none; b=XgMeKt013G1ctTKS2Ju6ZaJQKjwjMCkrgAw6l4ajCd+ejtdYKe90B7MCMcpvMHMg7F0/2nshFLNGHjB5ZKhjePBstFDbV7KfyL6d7moYAD8kcZG58AkEU+PRyEb/c4UdjjzSdebPgBZAqVnxsg1sKWetXT2mxvyrmV4Gy1gT8fOUNOqMTkeop60/RC8298DW2/07+57zEdynerO81Xb7FaTD58tbWNSzZM6ameTzTPmv51cZI2Rt3pfv97BuNJ0fOf8UjZ6Cb6HZ2wNO30yKMkadBDu92LULbkePlnXG9AOQ7xpoMJosZmNfJlM1Jf2wPf1pGjy7RaFifVuanFKu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772678230; c=relaxed/relaxed;
	bh=tT1v2a3J6jYtljuNPzIet71/4FoZvO2/2R6nDxr+jiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NJyxv0U41nC0lkj6kMaMTqSqcHsqqzrSOS0G/5F/K9unH4MpG62Ghzj//A0iNhGk7oOG/vIvMsRz7+biSi+9VKN/1pDj4m1HRAXzO+YVm15AoEfp/cT1+oWJR4Iw2kvxKYchOF0dsHaicdUkjEXWbGmxJAGY7kDQcVXSX5JDj23IfArCQ4WL0hLWIaqoFnw2I7ExwPpQUe+Pynt37+WVpetxPunbvqgK6TcuWwjK9wDPVoZoT17zdRdMQqWX7I7l9SC2VvZOVVdLlmD1mcC9dqPjIxi3UqWS5M8Wy0FDsRI+IuyaKEMj/eL65m5z+7WJx1gWxxtRqpF5bkK310O9Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PHKkL7Rf; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PHKkL7Rf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRDFx1s1sz30FF
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 13:37:09 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tT1v2a3J6jYtljuNPzIet71/4FoZvO2/2R6nDxr+jiQ=;
	b=PHKkL7RfVMixTbgsHp5gd6QJ07a5/TGYUgEEBNMAPjJJpiyd89V4+zbNJhbQ1TRSQ3sCqWRPq
	myRbN/9fKD0osRW2VYel7IrMFGOFSSRYRXsCyjYh05zOB4V4cG+LHte8S4gfkZPzjt52tbQdXZ3
	mniStE6qnOqijQiSHCEQRnE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fRD890b21zmVCZ;
	Thu,  5 Mar 2026 10:32:09 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B1B340562;
	Thu,  5 Mar 2026 10:37:01 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 5 Mar 2026 10:37:01 +0800
Message-ID: <bdb368bf-6fdd-4c20-9111-3857e0b5dd4d@huawei.com>
Date: Thu, 5 Mar 2026 10:37:00 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] erofs-utils: mkfs: enable experimental rebuild
 fulldata mode
To: Lucas Karpinski <lkarpinski@nvidia.com>, <linux-erofs@lists.ozlabs.org>
CC: <jcalmels@nvidia.com>
References: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
 <20260302-merge-fs-v1-5-a7254423447c@nvidia.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20260302-merge-fs-v1-5-a7254423447c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: E0FDE20A3B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2505-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lkarpinski@nvidia.com,m:linux-erofs@lists.ozlabs.org,m:jcalmels@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,huawei.com:dkim,huawei.com:mid,nvidia.com:email]
X-Rspamd-Action: no action


On 2026/3/3 4:01, Lucas Karpinski wrote:
> Finish enabling merge functionality for rebuild fulldata mode
>
> Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
> ---
>   mkfs/main.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 124a024..4c96e9d 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -105,6 +105,7 @@ static struct option long_options[] = {
>   	{"MZ", optional_argument, NULL, 537},
>   	{"xattr-prefix", required_argument, NULL, 538},
>   	{"xattr-inode-digest", required_argument, NULL, 539},
> +	{"merge", no_argument, NULL, 540},
>   	{0, 0, 0, 0},
>   };
>   
> @@ -254,6 +255,8 @@ static void usage(int argc, char **argv)
>   #ifdef HAVE_ZLIB
>   		" --gzinfo[=X]           generate AWS SOCI-compatible zinfo in order to support random gzip access\n"
>   #endif
> +		" --merge                merge multiple EROFS images into one\n"
> +		"                        Usage: mkfs.erofs --merge OUTPUT INPUT1 INPUT2 ...\n"

Hi Karpinski,


I would suggest using existing `--clean=data` option rather than 
introducing `--merge`

for this semantic, and could you help update man/mkfs.erofs.1 as well?


Thanks,

Yifan

>   		" --vmdk-desc=X          generate a VMDK descriptor file to merge sub-filesystems\n"
>   #ifdef EROFS_MT_ENABLED
>   		" --workers=#            set the number of worker threads to # (default: %u)\n"
> @@ -1093,13 +1096,15 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
>   		}
>   		break;
>   #endif
> +	case EROFS_MKFS_SOURCE_REBUILD:
> +		break;
>   	default:
>   		erofs_err("unexpected source_mode: %d", source_mode);
>   		return -EINVAL;
>   	}
>   
>   	if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
> -		char *srcpath = cfg.c_src_path;
> +		char *srcpath = cfg.c_src_path ? cfg.c_src_path : argv[optind++];
>   		struct erofs_sb_info *src;
>   
>   		do {
> @@ -1550,6 +1555,10 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
>   				return err;
>   			}
>   			break;
> +		case 540:
> +			source_mode = EROFS_MKFS_SOURCE_REBUILD;
> +			dataimport_mode = EROFS_MKFS_DATA_IMPORT_FULLDATA;
> +			break;
>   		case 'V':
>   			version();
>   			exit(0);
>

