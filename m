Return-Path: <linux-erofs+bounces-254-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722F2AA0040
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 05:25:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zmm0b1hzFz301N;
	Tue, 29 Apr 2025 13:25:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745897119;
	cv=none; b=VaHpxGKAPPYAVQJmQFkty0YOHMmI3lXlS7ru2HBhHRWGeaHhX38kcMrjBYWKcJZikUusyl3HCCnzA2vKnV9u0g1i7gTcom3NZRm5wB/i/N0jYj4/sLcwCe/RDNqKIT8YPVHUIkhkJyc8edjAuh2wGFC9j9Hxh0zHUKo0X4LzOXOG7v6L82VZo4rWD6Blbt8mE5X50sugEOgyRHSEBXBXZR1gVvqheY2iKq/NEuN/AuarXNPaMcS3FVintgygjJSX2ZoQXq/KBe0K7A8ik+FINFseVMmxrVaxM0m1NEGbx8wEUdCcJNo64Q360oKEl5qdPIQAxYT0xYVdeHDeMKo65w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745897119; c=relaxed/relaxed;
	bh=+5yYMOER0cZRuQthZecXBRPt3GeCpNrPCdgz6hPYMpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gLhODe273r2UTYyECPDV7kQKVwrf2saTc7jTTgiFDDe/zoZ1NRYH2eOV0aNxFuJWoW/2xCanrdvgXip1zv8hMHU2a3y1/9QgFm7uqn74+cTDTTt9ITcxCGtXmB2xSUgMzW+xOuql07NS1rgMFXstUCkmjbQ+ILGTjTKCA5VLOVcALUO0WZpO6irKjBF1VcaD4ua2BPO67xFw6H7Heawkse2YbIh3OZfefbvZtO/TPDh9LPe3koBfkFxabbamIVjbh2sZLwxFyWJMymbtow71VxK7USnzYk1kglbBbG2k3PHDMdqn2nnOg1wgEeOK3NT2mwgjQeuuY9/M5mzGE6E49Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zmm0Z0NB2z2yfy
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 13:25:16 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zmlz92VTfz1d15k
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 11:24:05 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BF1C180087
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 11:25:11 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Apr 2025 11:25:11 +0800
Message-ID: <bdd99a5d-2e24-4cd3-8e38-dab796e66100@huawei.com>
Date: Tue, 29 Apr 2025 11:25:10 +0800
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
Subject: Re: [PATCH] fs/erofs/fileio: call erofs_onlinefolio_split() after
 bio_add_folio()
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250428230933.3422273-1-max.kellermann@ionos.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250428230933.3422273-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/29 7:09, Max Kellermann wrote:
> If bio_add_folio() fails (because it is full),
> erofs_fileio_scan_folio() needs to submit the I/O request via
> erofs_fileio_rq_submit() and allocate a new I/O request with an empty
> `struct bio`.  Then it retries the bio_add_folio() call.
> 
> However, at this point, erofs_onlinefolio_split() has already been
> called which increments `folio->private`; the retry will call
> erofs_onlinefolio_split() again, but there will never be a matching
> erofs_onlinefolio_end() call.  This leaves the folio locked forever
> and all waiters will be stuck in folio_wait_bit_common().
> 
> This bug has been added by commit ce63cb62d794 ("erofs: support
> unencoded inodes for fileio"), but was practically unreachable because
> there was room for 256 folios in the `struct bio` - until commit
> 9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts") which
> reduced the array capacity to 16 folios.
> 
> It was now trivial to trigger the bug by manually invoking readahead
> from userspace, e.g.:
> 
>   posix_fadvise(fd, 0, st.st_size, POSIX_FADV_WILLNEED);
> 

Thanks,

Tested-by Hongbo Li <lihongbo22@huawei.com>

> This should be fixed by invoking erofs_onlinefolio_split() only after
> bio_add_folio() has succeeded.  This is safe: asynchronous completions
> invoking erofs_onlinefolio_end() will not unlock the folio because
> erofs_fileio_scan_folio() is still holding a reference to be released
> by erofs_onlinefolio_end() at the end.
> 
> Fixes: ce63cb62d794 ("erofs: support unencoded inodes for fileio")
> Fixes: 9f74ae8c9ac9 ("erofs: shorten bvecs[] for file-backed mounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   fs/erofs/fileio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index 4fa0a0121288..60c7cc4c105c 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -150,10 +150,10 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
>   				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
>   				attached = 0;
>   			}
> -			if (!attached++)
> -				erofs_onlinefolio_split(folio);
>   			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
>   				goto io_retry;
> +			if (!attached++)
> +				erofs_onlinefolio_split(folio);
>   			io->dev.m_pa += len;
>   		}
>   		cur += len;

