Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E99839C4CA0
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 03:33:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XnVnh12DFz2yXY
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 13:32:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731378774;
	cv=none; b=igAmPB/owTWDAOQ5ccnKKDqv0dkrs1ZIrefYCWRnTisSADRe3OZW2mU3TNt33nU9iq58EUayMsUUYJpY16nBdWuniz7YxK90o7fY2Yi0vhr5rbZpkcCRDsoCXxiFMDdpPFKO285hbs7I5oK1yCr8hL3ikz8zbIgo/ZNePi0/br6DWhWTXx+JSrOE2NXdlTEjg4y8cQNeCx81yAFiykkhhSlwO47tqKbhYzGOwCyYE3y56Q8LqRJj8CBOQaciR1041MnHGEdrjwZdlrS9h6dFhs+DYGA3eCODHwHkXxLCyXlaS2DiEUv0nHc8wqSp6vmYw6Kw8tBJYK5WhbBsI/LyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731378774; c=relaxed/relaxed;
	bh=Jbj91BmDvvsxwWvx8lHwWl07tIkYm+T47B95nubtj1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSKx3fxgAkR0oOhzJUTehkE1qZyS5G9UMiGWgiwyAnuE5XEWpaxPHYDMqQqLxXtnB5lba9GkJpex/ERlimagE6rUZy2QpEPsPfqpWwwuoam5c/PNGcZqhJeSDk8dYYAwPdzuTezR0Sa0GR98yaP5/HxV1rp1sl9+3QPbllbA4D2lxeukMqKHZHnt8KIq6gbHI0MENGbJ7xzbrFH8/abWAC91pxmFMDc7ADj4URcJpJlzTNNv6DE+W5FpIK2O/rSG+H5Jj1u/2bTZb1Dx3zC6GFHfK9jkfLjGXKlMudsvvIfnHFqT1rLDVUUphKxEmct+kZTpwULtmG+XMthyUIaqIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GBJ+52Xl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GBJ+52Xl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XnVnb0MxRz2xJK
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 13:32:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731378761; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Jbj91BmDvvsxwWvx8lHwWl07tIkYm+T47B95nubtj1Y=;
	b=GBJ+52Xlh07HJJ5qVH6QxWNUOJj2Uki/1z9ZlpgYvJr1t4BU7BUHd4PV4mSnf1nm3vjkxPiMlLz/wRPki8Ada1kEpUO6Wew3gtSBdSYIRbFd7Ro+m97ejPHRU/B/ezZtBh5HhbEyD8vjHi33jyXAIZ7XSZ5lOSNegSnXSz4QhwA=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJFJuX2_1731378760 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 10:32:40 +0800
Message-ID: <1ce4a2b4-1b2f-48d1-99e5-f664b760a7bd@linux.alibaba.com>
Date: Tue, 12 Nov 2024 10:32:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: free pclusters if no cached folio attached
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20241111113842.469080-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241111113842.469080-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Just two extra minor nits...

First, the subject line would be
"erofs: free pclusters if no cached folio is attached"

On 2024/11/11 19:38, Chunhai Guo wrote:
> Once a pcluster is fully decompressed and there are no attached cached
> folios, its corresponding `struct z_erofs_pcluster` will be freed. This
> will significantly reduce the frequency of calls to erofs_shrink_scan()
> and the memory allocated for `struct z_erofs_pcluster`.
> 
> The tables below show approximately a 96% reduction in the calls to
> erofs_shrink_scan() and in the memory allocated for `struct
> z_erofs_pcluster` after applying this patch. The results were obtained
> by performing a test to copy a 4.1GB partition on ARM64 Android devices
> running the 6.6 kernel with an 8-core CPU and 12GB of memory.
> 
> 1. The reduction in calls to erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (times) |   11390   |   390    | -96.57% |
> +-----------------+-----------+----------+---------+
> 
> 2. The reduction in memory released by erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (Byte)  | 133612656 | 4434552  | -96.68% |
> +-----------------+-----------+----------+---------+
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

...

> -static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
> +static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
> +		struct z_erofs_pcluster *pcl, bool try_free)
>   {
> +	bool free = false;
> +
>   	if (lockref_put_or_lock(&pcl->lockref))
>   		return;
>   
>   	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
> -	if (pcl->lockref.count == 1)
> -		atomic_long_inc(&erofs_global_shrink_cnt);
> -	--pcl->lockref.count;
> +	if (--pcl->lockref.count == 0) {

Second, EROFS codebase uses `!--pcl->lockref.count`
coding style instead of `== 0` since the old checkpatch.pl
will complain this and I'd like to keep consistentency..

Otherwise it looks good to me, if you send out a
new version, I will apply directly.

Thanks,
Gao Xiang
