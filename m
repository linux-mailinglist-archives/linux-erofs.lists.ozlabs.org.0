Return-Path: <linux-erofs+bounces-56-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EB8A5F484
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Mar 2025 13:32:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZD6MT4sbXz30Tp;
	Thu, 13 Mar 2025 23:32:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741869141;
	cv=none; b=TVKg2UE+K+XrgVeUlan7lqSlSneuX2ZnoEJ8neo/QHcIeTi9tlLtkHtoLELH/hJpDtbiHH1bp4LziyXbIY+YbeniL/ZzyNoK3t8fgAhEtt/FvD8nYAGHTT45wj2JsaapkqVIHO1a9uiNyAnBhBj3TzBw/i8nKN6wuO4awADVzy5HqSkFKHRNbAdN0+48R0+hrUyCUXfQGvkqCRUO4UO9/DZZ+a7ZAANlXqtZ95p2HMBSwX0vVueI0tBjepzAStm6GnYal3KRkiJjGPSX+MSQsNd65pRC78N3oT1432BgCidd2igyddy6tjD/D6X7YDdoJYBv3hZd+PoO6RSyRv2qyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741869141; c=relaxed/relaxed;
	bh=3WDK/Qfa9S1cCBkG0hM40846x6GSEdu8RcSL8OPjHcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoIeP38THdI7L52fx/0aPUkIy9FnIiNnYH/K+JiPVHbrOvYzzNMZN9kcZEY6c8oPy5RwWRoTlkdkirUlssuqCx8f/UA2ETMeNL0rWow20rUmpO4ZxTb/UbPvDVlxBCz2q0LPFlfsm+s6QUdsA3x7fRxpzR19KtDVIaolOoFsMqwYPJAJCk4V87iaxkHT+lOLWCXgpLz2dVxjHbac1U8Zb0Do/H5b+2mVvRPFu87bH/qyrw+lHEl7yKdoF6zPlZ/cmQWyynp6L8Ek98Kk6nzy2ZG1eAOFtNIC86w2bL97Y5LBHqjm/5hparaawRh//AL7POQq7pe2/u3I/48wTpQcuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tntN1TdT; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tntN1TdT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZD6MR71Z2z30Lt
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Mar 2025 23:32:18 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741869132; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3WDK/Qfa9S1cCBkG0hM40846x6GSEdu8RcSL8OPjHcs=;
	b=tntN1TdTCKoqDIFAcbOVscI1LzsoEZAQzQRa+up7vnPygi2lOuwkqfNshy8g4KFjw/Eb7hb54ZX/wEmkv2fE1GPG4qXKX0s0Wc6xrLc2jg7Cld5wWp2dht7gxTWmiqZl1DUvMs0Sv3WoyO+ynMxA6lqyyXAIKJ/66GTEJpA/5fE=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRGv2EA_1741869130 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Mar 2025 20:32:10 +0800
Message-ID: <751a34e5-5305-4c7f-9568-57cb6931c51b@linux.alibaba.com>
Date: Thu, 13 Mar 2025 20:32:09 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] erofs: 48-bit layout support
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
 <695b5311-d0bb-422c-9a96-52cfcc72afb4@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <695b5311-d0bb-422c-9a96-52cfcc72afb4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org



On 2025/3/13 20:06, Chao Yu wrote:
> On 2025/3/10 17:54, Gao Xiang wrote:
>> Hi folks,
>>
>> The current 32-bit block addressing limits EROFS to a 16TiB maximum
>> volume size with 4KiB blocks.  However, several new use cases now
>> require larger capacity support:
>>   - Massive datasets for model training to boost random sampling
>>     performance for each epoch;
>>   - Object storage clients using EROFS direct passthrough.
>>
>> This extends core on-disk structures to support 48-bit block addressing,
>> such as inodes, device slots, and inode chunks.
>>
>> In addition, it introduces an mtime field to 32-byte compact inodes for
>> basic timestamp support, as well as expands the superblock root NID to
>> an 8-byte rootnid_8b for out-of-place update incremental builds.
>>
>> In order to support larger images beyond 32-bit block addressing and
>> efficient indexing of large compression units for compressed data, and
>> to better support popular compression algorithms (mainly Zstd) that
>> still lack native fixed-sized output compression support, introduce
>> byte-oriented encoded extents, so that these compressors are allowed
>> to retain their current methods.
>>
>> Therefore, it speeds up Zstd image building a lot by using:
>> Processor: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz * 96
>> Dataset: enwik9
>> Build time Size Type Command Line
>> 3m52.339s 266653696 FO -C524288 -zzstd,22
>> 3m48.549s 266174464 FO -E48bit -C524288 -zzstd,22
>> 0m12.821s 272134144 FI -E48bit -C1048576 --max-extent-bytes=1048576 -zzstd,22
>>
>> It has been stress-tested on my local setup for a while without any
>> strange happens.
> 
> Cool, good work! For this serial,
> 
> Acked-by: Chao Yu <chao@kernel.org>
> 
> Hoping to grab continuous free slots to check the details, then we can
> change it to rvb status before merge window. :)

Thanks, I don't find any issue so far and users would like to
get 48-bit addressing and quick Zstd compression. It's not a
complex update anyway.

Thanks,
Gao Xiang

