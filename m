Return-Path: <linux-erofs+bounces-2964-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC1tF19dwWlZSgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2964-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 16:33:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D82F6796
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 16:33:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffcdk6LNkz2ySB;
	Tue, 24 Mar 2026 02:33:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774280026;
	cv=none; b=NMemrQufxQAhY6MP6WxUk3a17roKOMD/ICGw4C2pYp7oKOovVc1NSPgC8/tl3QXuEXf0NRrYM5IvC2bvCP2oyRjG3ljvpaPhy54zG45Mh4cNIFR3JM6mkRGcEXbM50wOKfbu1v9f6yteMbftvJlZyiiMEFAjkQ7cKkJ/FG+4XVPf67SQT2lqX/cSSH9f9ku86S/A1naiHWQR8H5RezsYxXW8AadycONXmq2ArjeB/Sqb/8AYjyOHaNCYBceuI0U7psjUQbz+TfGB81McYP9xhuOa9/rCCNTOOQc8EKt0LTaZE2CsObnKKO9m/1t6fQXwAw2Yfd5L2rR1kqvhwh8keQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774280026; c=relaxed/relaxed;
	bh=I+H+YlI+LknciL4hOZJVIzyvex8+jcTijTmQB74DYko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElBTWHQfRnQkCaYrTDrbpIjjPimM1PTbuqhMJC/ccHybaxB9Ue63ujWDSNo1is4VttU0Vk7eamSSgky9QPbWg928Jq0gJmQAlMvX6VjYqW8OXo7iT8JPNr13703ixgBt8EIT6bnz5M36w8suFw9utpdI6viBUGyKhKRKkN0OBeiHt6RNCNn5dwFylegQ86lGtRJM7lwzGBAqXZmjM1U67YqiFE/uCyiRiG9Y7YB4pm3Czpn+PfRF2yotZnqnSaaTCUKDlPTzjuJLXcv1TuEnonoYRM1/9m5flo8A8N+WWddLXzTm+XYLFereLTvidS83DocEFEDf6hPNRQRzZlzlYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MCs9wD1y; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MCs9wD1y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffcdh0lr3z2xN5
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 02:33:39 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774280015; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I+H+YlI+LknciL4hOZJVIzyvex8+jcTijTmQB74DYko=;
	b=MCs9wD1yeO2F+jCvQetsiMayLZdJ/P+vNuHwltZW7gKez3RaXfUslKPaXYSuqLAtM6Y4+Oxqwvaq/7iSdIiNsbFckJXPZ+jvGNyL0HfGaaZO17d/EqLbX3zkVqtiUlZ3XrSX2B4RsCyyrlLDkOJYvUuR87hZcHOHnHUgaoRgoUk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.ZDcaT_1774280014;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.ZDcaT_1774280014 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 23:33:34 +0800
Message-ID: <0a4bd05f-9a3d-4cf9-b36e-f49f729f0430@linux.alibaba.com>
Date: Mon, 23 Mar 2026 23:33:33 +0800
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
Subject: Re: [PATCH] erofs: update the Kconfig description
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260323094857.2187994-1-hsiangkao@linux.alibaba.com>
 <927c52ee-24b5-4b8f-98ee-3a18f13fa8b5@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <927c52ee-24b5-4b8f-98ee-3a18f13fa8b5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2964-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AF3D82F6796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chao,

On 2026/3/23 17:59, Chao Yu wrote:
> On 3/23/26 17:48, Gao Xiang wrote:
>> Refine the description to better highlight its features and use cases.
>>
>> In addition, add instructions for building it as a module and clarify
>> the compression option.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/Kconfig | 45 ++++++++++++++++++++++++++++++---------------
>>   1 file changed, 30 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index a9f645f57bb2..9489ed8ad95b 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -16,22 +16,36 @@ config EROFS_FS
>>   	select ZLIB_INFLATE if EROFS_FS_ZIP_DEFLATE
>>   	select ZSTD_DECOMPRESS if EROFS_FS_ZIP_ZSTD
>>   	help
>> -	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
>> -	  file system with modern designs (e.g. no buffer heads, inline
>> -	  xattrs/data, chunk-based deduplication, multiple devices, etc.) for
>> -	  scenarios which need high-performance read-only solutions, e.g.
>> -	  smartphones with Android OS, LiveCDs and high-density hosts with
>> -	  numerous containers;
>> -
>> -	  It also provides transparent compression and deduplication support to
>> -	  improve storage density and maintain relatively high compression
>> -	  ratios, and it implements in-place decompression to temporarily reuse
>> -	  page cache for compressed data using proper strategies, which is
>> -	  quite useful for ensuring guaranteed end-to-end runtime decompression
>> +	  EROFS (Enhanced Read-Only File System) is a modern, lightweight,
>> +	  secure read-only filesystem for various use cases, such as immutable
>> +	  system images, container images, application sandboxes, and datasets.
>> +
>> +	  EROFS uses a flexible, hierarchical on-disk design so that features
>> +	  can be enabled on demand: the core on-disk format is block-aligned in
>> +	  order to perform optimally on all kinds of devices, including block
>> +	  and memory-backed devices; the format is easy to parse and has zero
>> +	  metadata redundancy, unlike generic filesystems, making it ideal for
>> +	  for filesytem auditing and remote access; inline data, random-access
> 
> duplicated 'for'? otherwise, looks good to me.

Fixed and thanks for the review!

> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,

Thanks,
Gao Xiang

