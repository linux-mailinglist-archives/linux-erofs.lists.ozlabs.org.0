Return-Path: <linux-erofs+bounces-538-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B27AFB22F
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Jul 2025 13:22:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbMKr3zv6z30W9;
	Mon,  7 Jul 2025 21:22:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751887376;
	cv=none; b=UXAShqhkiwhhMyOgUm8H++97VyeZuNbLuH+jjcu7WMbJnCU7Zon9l/OkbV0gC+CfNE+DEgKbzXNI7HeeHdrZYozvMuMBNQZECcVAKEJBWWTR5tng2XuEaNGkPOldv7a/ASPaf4Rj0iy+dJS05rGI0SFj5fj4DID4JWe4JWHkWuOcfR6DL9/smayJpwzUg9+TAAx09CkCORuHPiTJk4zt+5kkSzzl/QtXwNXedFmnacISkKTB/oHos1zT5fIBK9myLG7DCSnFHI9kOIK0axuoFTPvsHobiRb/K/lhk3WvdkkrqB4u0ghz1NdIbpS2eqvIFC1FvpjZMElQ1DTmRKCqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751887376; c=relaxed/relaxed;
	bh=f4FLu/Ps2n6tXOcoIQC+HmiNqL6UoSy2YWKhlCiR1FI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UfRoA/CLQjc8IbNDiRNUFJSpNIH5K2GYgiXffH5HTsK9d+XhXbZFdWutwhb2ei71JlxodJCSDbk2kh2gTxdRZ1ThjbHCBFp+F7S9BqUG57ey3MMm0VIULnWRaqx1I9+bqyOVqwBB9U6mA9W53o9IcXPMGNNzoUMlulKUUTORFfyuaRYW1F7gEA4pWwtkWFVC34GS+WkFnNEephB6yOEAbEF3mI/jCkotUYBNxsmNx0iPVAAVDvyCSaD9ym3yTeeGzGLDAaRknNxCdxxJsiFErZQB4wTLH3vZPKERFIdeboHLTMbn4H/UPMoBfyKa0hQVpZcmT2K/ubHcLGbC5CxRZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VLaUdpuW; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VLaUdpuW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbMKq5CMmz30W5
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Jul 2025 21:22:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A2A4D5C10B0;
	Mon,  7 Jul 2025 11:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9C5C4CEE3;
	Mon,  7 Jul 2025 11:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751887373;
	bh=7SKvBSBl8ewoL2gELoxqBtizcHpPDe7vJ7QfhlYKQBw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VLaUdpuWGl63t3PCbX0rj5c8Gc/xPwxvre3xaZ9PEbb94QtwN9rF8MnLd2hWPznD4
	 mm0BvI8CwRqhcvaobVhY4O9oGgfsx2CScqGtAWtDtrH7E6yfDxbFojoAWISUWp0vai
	 jTf/tdd2AAHBKwMUfXospWrwgu2SgWECFeOHeHYjyQeKlt2KOmpqMgLEY2iCp8txtW
	 zbJqIrCvumQjdhvhDLrT0pixtoptAmaSS+zE79Hlee4X13NUNT12QoLAgQ/NqvuLYL
	 s4BScdlc97AYGluH1Wr5onG0mDlERyj9nZYe7oRLUfVAcTVz9lAHgVsvYaTodVI9+9
	 gznLghs949HgA==
Message-ID: <0b45c2d9-a610-4839-baa6-75041a6c37d5@kernel.org>
Date: Mon, 7 Jul 2025 19:22:48 +0800
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
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH] erofs: fix to add missing tracepoint in erofs_readahead()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20250707084832.2725677-1-chao@kernel.org>
 <c911e159-d216-4b0f-865b-f4524e6f8f0f@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <c911e159-d216-4b0f-865b-f4524e6f8f0f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 7/7/25 18:17, Gao Xiang wrote:
> 
> 
> On 2025/7/7 16:48, Chao Yu wrote:
>> Commit 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
>> converts to use iomap interface, it removed trace_erofs_readahead()
>> tracepoint in the meantime, let's add it back.
>>
>> Fixes: 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
> 
> Thanks Chao, btw, should we add tracepoint to erofs_read_folio() too?

Xiang, I guess it is useful for debug if we can add it, let me figure out
a patch for that?

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/erofs/data.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 6a329c329f43..534ac359976e 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -356,6 +356,9 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
>>     static void erofs_readahead(struct readahead_control *rac)
>>   {
>> +    trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>> +                    readahead_count(rac), true);
>> +
>>       return iomap_readahead(rac, &erofs_iomap_ops);
>>   }
>>   
> 
> 


