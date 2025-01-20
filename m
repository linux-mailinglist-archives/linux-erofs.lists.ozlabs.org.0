Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ED6A1658C
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 04:10:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YbwM237tYz3013
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 14:10:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737342621;
	cv=none; b=bfWgPanfcZFdmRmnEDJM9YKSr6c/LUOE/sqa0MoqeJ3sGyKmBelQnnz7mtv9U2SxEtHmuasSmcWvCZO8rT/WYZV0BnJcO30KUfJxl4MkdzDEMDRld+pt1JHYJkqe8eyo6evikOIUzGwBri75ECJDVFehQ8Nf++mlJQZhaZYok8I/sRCm/y9pd1XlQIRDonfbtmeEKQ4/sA9vZ3Pvt6rWghbArxFjywYvIo2GQFX37fGZE2buj735IAHKl+NftDXc814xrfQN+igZUu570FJqLMwKRE0qv/bVhJrHNTAd5HN9dvbw1dqYZXVBSCsZH5yKdMcPdeUgXU0RXnKnPeMVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737342621; c=relaxed/relaxed;
	bh=y4RDpjIfdodilFcqwOcNdbWY09P2HgD4v1eMqKJ6Wtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmVNyqH2KT765KLDEVx3nmMRJY4A34ZcD9sHIohXnBgA2Cjc5RRQ2+WhCjQHHmbvyaE1ExhsNLC3HJ1C9tvYrrwpq5jFOkhUERA4IkTItiI9cRXAB8iNx5z1U0zSqdZa+NaByhqGEcxHummDP9M+onivDDCfFupOLXkPLWt3VrcPXg14HaqrqwQoPxOikubRiB1VkS/IcH2IzKKZvVIWhz/AuPbfU+cQZNPiBga1kvjgzPyn6VYRPreVc77NGkmO3xE+hVryqSJ2VUlpl88OpXJZb/A97jET63SFsv7wPOP64NqZfmf81r5qVjgZReuM8XSdGa0nSEuSPF77jIeuHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FaHbMNqr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FaHbMNqr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YbwLz4mG9z2yFB
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 14:10:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737342614; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y4RDpjIfdodilFcqwOcNdbWY09P2HgD4v1eMqKJ6Wtk=;
	b=FaHbMNqrNgm8X9xpd9HIQlYQ5FeaThrWq0fUQ6O0fnG+zRAKB1MH5RcGql/ngxlrYwKCTvbF3Hj+yBQ54qQVmkEOVp/wKHprwnwo1XfW/N70+k+cxQ9Yvqqin/fm5nI+WNidvMucO4DoqrfJzPLX4QpQkEwZXK89o3xN690ytiY=
Received: from 30.221.129.118(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNvLMCh_1737342611 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 11:10:12 +0800
Message-ID: <f0a6b66e-0427-4c66-8c69-20c6c362e55f@linux.alibaba.com>
Date: Mon, 20 Jan 2025 11:10:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] erofs: file-backed mount supports direct io
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org
References: <20250115070936.119975-1-lihongbo22@huawei.com>
 <635ede9a-b5eb-4630-88ba-2826022d5585@linux.alibaba.com>
 <fbd5850c-e431-4914-81eb-ec3ff42419a4@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <fbd5850c-e431-4914-81eb-ec3ff42419a4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/20 11:02, Hongbo Li wrote:
> 
> 

...

>>>   }
>>> +static int erofs_fileio_scan_iter(struct erofs_fileio *io, struct kiocb *iocb,
>>> +                  struct iov_iter *iter)
>>
>> I wonder if it's possible to just extract a folio from
>> `struct iov_iter` and reuse erofs_fileio_scan_folio() logic.
> Thanks for reviewing. Ok, I'll think about reusing the erofs_fileio_scan_folio logic in later version.

Thanks.

> 
> Additionally, for the file-backed mount case, can we consider removing the erofs's page cache and just using the backend file's page cache? If in this way, it will use buffer io for reading the backend's mounted files in default, and it also can decrease the memory overhead.

I think it's too hacky for upstreaming, since EROFS can only
operate its own page cache, otherwise it should only support
overlayfs-like per-inode sharing.

Per-extent sharing among different filesystems is too hacky
on the MM side, but if you have some detailed internal
requirement, you could implement downstream.

Thanks,
Gao Xiang

> 
> This is just my initial idea, for uncompressed mode, this should make sense. But for compressed layout, it needs to be verified.
> 
> Thanks,
> Hongbo
> 
>>
>> It simplifies the codebase a lot, and I think the performance
>> is almost the same.
>>
>> Otherwise currently it looks good to me.
>>
>> Thanks,
>> Gao Xiang

