Return-Path: <linux-erofs+bounces-573-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D12D8AFEAC9
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Jul 2025 15:53:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bcfZb3sTdz2yhX;
	Wed,  9 Jul 2025 23:53:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752069207;
	cv=none; b=fgzwygvTvB6sDuSNZKC/GoAZZ3pCILA9pV79a3u2rv7jFYMti+icM2gXdhvd/uKjfjsys3ersj6b4mTCxku0kgVK1w1xvXlrX9RBpZIBwxzyhIr0f5+38dqiDFudjGqaHPtBG2+pIRUH0VT2eG0AAwXMR3SDe+dk+bhnuiDerIsc2MbqFz31VtCl21P69pYHpmntPdkGVC/ktE0PuDOzn6/PVNHiSnaKCzRCYVZMddxCmep7Su8QWsvIiTGEEfe94Jnbnst95683TEbEkInKj18rx8ttWmJuQSVhbsUPBw5BpowfA6w7FlmfZSMtXsjTC+6XwLAepoiFJNfbM9ehXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752069207; c=relaxed/relaxed;
	bh=/mKQu7tb4IqCL/bEEszvX7wtPRViVpX6KjOqifqgDtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IB4uSj7oBqsHndha3zMH2UJd2f9H+KztXPojQId+/IAziVJEZLo836XhwgYW2dxKIBE9W/N6+Pkpk+sNKJe+diNci5iIwWBIFf64lPUfKbzMXy19dygtjoZ1H0LPGSumDlpcg+dLoMGPPfXrI7gqXlEdXTX+rB2vu50E5uN/xm6+Eb2HDN+WvFxbWWGj7B7IIY6fd98hTribpcFRPAiL6GINU2HkaYiNLXdB2iNx+ZW8uvUURIiA37FzSpY8NoMqndMwKaezHwMFST2MwBTX5o9sg42YfgoJNJKmHh7knISbsjDzxqOY67EyNNEtsK/0fgMHmDF2wRMDlNObBYI/9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ve89oBRV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ve89oBRV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcfZX68Zzz2yKq
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 23:53:22 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752069195; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/mKQu7tb4IqCL/bEEszvX7wtPRViVpX6KjOqifqgDtI=;
	b=Ve89oBRVjUQbwXFyKaYqxIhFLKQRyHPGf7JprRm2NmV7b3grvCK8mxUuQK+AeiNT3VYa87lfqwlRD7YBUd/CL3s9QzXhnZ+26f/wPch1sog6QdusiAwLV5ctypFfFHNiabt3B9o3Vwy0KBn5D46QZpI4KRuiJWYPryhXa8eY0Jw=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiYWRYo_1752069192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 21:53:13 +0800
Message-ID: <da52a0d3-9a3b-4465-bf17-cf2ad8044330@linux.alibaba.com>
Date: Wed, 9 Jul 2025 21:53:10 +0800
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
Subject: Re: [PATCH 2/2] erofs: address D-cache aliasing
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
 <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
 <862beb2e-f8a8-468a-a2ed-c8151eabb342@pengutronix.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <862beb2e-f8a8-468a-a2ed-c8151eabb342@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Stefan,

On 2025/7/9 19:25, Stefan Kerkmann wrote:
> Hi Gao, Hi Jan,
> 
> On 7/9/25 5:46 AM, Gao Xiang wrote:
>> Flush the D-cache before unlocking folios for compressed inodes, as
>> they are dirtied during decompression.
>>
>> Avoid calling flush_dcache_folio() on every CPU write, since it's more
>> like playing whack-a-mole without real benefit.
>>
>> It has no impact on x86 and arm64/risc-v: on x86, flush_dcache_folio()
>> is a no-op, and on arm64/risc-v, PG_dcache_clean (PG_arch_1) is clear
>> for new page cache folios.  However, certain ARM boards are affected,
>> as reported.
>>
>> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
>> Closes: https://lore.kernel.org/r/c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de
>> Closes: https://lore.kernel.org/r/38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com
>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>> Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> Hi Jan and Stefan,
>>
>> if possible, please help test this patch on your arm devices,
>> many thanks!  I will submit this later but if it's urgent you
>> could also apply this locally in advance.
>>
> 
> Thank you for the fix and great work, it solved the issue I was seeing locally!

Thanks for your confirmation too!

Thanks,
Gao Xiang

