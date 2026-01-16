Return-Path: <linux-erofs+bounces-1966-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B8D33809
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 17:30:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt51Q3B7Yz2xm3;
	Sat, 17 Jan 2026 03:30:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768581018;
	cv=none; b=lrK7nrIGnNjkObXds4s3qNdcNubfXt2P79XzZnpSFHK6SohH9ZAdTg6OvbQ9nB9Mf+/hsIGh5HPVJkcKldZcJJ1a2mWiEGNvRGFJeoW1XJIDbGyHi9OERoOxus4KtMa44FkkDNrKMg2mTFV2dekoiHmJyGcz7Qz0N2mHWbImQup8TkzxpuSjdNhz3aKoz8aKPR2WKWgyZeCv7AxzM1qg/wAtLtIMGlgyxar9RAvktK9QLSuH3X5A0wCvJNJB8HoG1udCy7qq0lV21Pn6ASfA3XvH15p0ONdv2d8JF7WJjb6XlkXPzjRKkIqdApioQfWbGctA88GAPkaRPUe+/LuwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768581018; c=relaxed/relaxed;
	bh=RFWiI0wOR2yk+5/0dINJESRV12gsa36QcDUdOJgcoEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+uUEbCqz6bKF5NkxJrtDPB1OuCyDTRsWwbHy1On4MpXtxjZObv4t8sCxsCpP5tYEfiGcZqxVcCNDkcmKT68PhD2TD5anyz/wbL8Go+a+BLAaoHqp0FVrI0vCssKIQoxOtlH1RBb7x4ZozQ4czmaNPZgDE+Eve1IaS7HazE6gkZ9hwVrlO9yuHevrA0NRVKC3oPTTGXSYx7vv6o42+Z7ESSErldJwetNRdlkU5h5i68Wxl8l7W8KaU6zuF2cE+vN/RK341+Y3MNulJdI/mejkBdaz0giTawg9SRY+opfG5qKqR+qcS44rzcDEB5ElHWAtNOUiYv1GHty4FdM7lUjzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WopP+0cr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WopP+0cr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt51M5M6Gz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 03:30:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768581010; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RFWiI0wOR2yk+5/0dINJESRV12gsa36QcDUdOJgcoEs=;
	b=WopP+0cr68GhfPuyTCPDDmCjM+Que32lyJma36P2r6A6AZFPdgrY19WRH6/2oRhsskxsF3oDZW5SFSTLCDMn4iuDtubFDDruopqm5aKG3/cXQHQ8OXf3b3majPcWOuvWu1IaC09AXs6O+a9xOsdwZITN4K94VQPDQAFMHbKmc7o=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxAgrWL_1768581008 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Jan 2026 00:30:09 +0800
Message-ID: <96353e77-6118-4272-be8f-ae1ece5b57a4@linux.alibaba.com>
Date: Sat, 17 Jan 2026 00:30:08 +0800
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
Subject: Re: [PATCH v15 0/9] erofs: Introduce page cache sharing feature
To: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>
Cc: chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116153656.GA21174@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260116153656.GA21174@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/16 23:36, Christoph Hellwig wrote:
> Sorry, just getting to this from my overful inbox by now.
> 
> On Fri, Jan 16, 2026 at 09:55:41AM +0000, Hongbo Li wrote:
>> 2.1. file open & close
>> ----------------------
>> When the file is opened, the ->private_data field of file A or file B is
>> set to point to an internal deduplicated file. When the actual read
>> occurs, the page cache of this deduplicated file will be accessed.
> 
> So the first opener wins and others point to it?  That would lead to
> some really annoying life time rules.  Or you allocate a hidden backing
> file and have everyone point to it (the backing_file related subject
> kinda hints at that), which would be much more sensible, but then the
> above descriptions would not be correct.

Your latter thought is correct, I think the words above
are ambiguous.

> 
>>
>> When the file is opened, if the corresponding erofs inode is newly
>> created, then perform the following actions:
>> 1. add the erofs inode to the backing list of the deduplicated inode;
>> 2. increase the reference count of the deduplicated inode.
> 
> This on the other hand suggests the fist opener is used approach again?

Not quite sure about this part, assuming you read the
patches, it's just similar to the backing_file approach.

> 
>> Assuming the deduplication inode's page cache is PGCache_dedup, there
> 
> What is PGCache_dedup?

Maybe it's just an outdated expression from the older versions
from Hongzhen.  I think just ignore this part.

> 
>> Iomap and the layers below will involve disk I/O operations. As
>> described in 2.1, the deduplicated inode itself is not bound to a
>> specific device. The deduplicated inode will select an erofs inode from
>> the backing list (by default, the first one) to complete the
>> corresponding iomap operation.
> 
> What happens for mmap I/O where folio->mapping is kinda important?

`folio->mapping` will just get the anon inode, but
(meta)data I/Os will submit to one of the real
filesystem (that is why a real inode is needed to
pass into iomap), and use the data to fill the
anon inode page cache, and the anon inode is like
backing_file, and vma->vm_file will point to the
hidden backing file backed by the anon inode .

Thanks,
Gao Xiang

> 
> Also do you have a git tree for the whole feature?


