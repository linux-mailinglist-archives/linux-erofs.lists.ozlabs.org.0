Return-Path: <linux-erofs+bounces-3239-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Pt2gJ/yF12k9PQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3239-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 12:57:00 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 033AE3C952E
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 12:56:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frxhS2mRWz2xT6;
	Thu, 09 Apr 2026 20:56:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775732216;
	cv=none; b=RYIDsS6dEwlMat5SW2TzyV+mlVPvexiRW4EzPBfdMhcfie74AgRLiGabEEeWAeJU2nw5YdWfdBRi9aP+qza+O24XJ8fWmCIdh8cwOoJFgdDYCBvZjqQ0IJrm0R+hqq6HXXU3NEnsL99D46o9jBVtbYSObAeo7HxgiN+rpS4x2etbh9r7mIRVX+WGq720sMzYSRch32eBC5TYhbGedCi7sEzeizCzcZlirqXC6UoKzxRzl5Tb3JV0sPi3GpdP3Rs+MyRYiJZUw0I1d6LH+a6IFFhtMJzhGMWzRdlJduGtuu+psiYWTJStJmaAyLn1qELXKDbInhkldsILjol4S72/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775732216; c=relaxed/relaxed;
	bh=CBfTM9xBob73GimIL4JdnF/RxealF87d/9oNo4Ik0D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzjgcH/YCHfqSRXqCeBLY3M8GW/S13lryjALI2wvVjUaaIzxAORoHyNc3LtlB2dsjifz4CPXsTvb3fWHy7+4pBMfz8OCZ0m35dUbbZh4uU3k1AyPLURJJtdHBsel5rnFu2NfjQkYLvLaPUmxPW6pmffLm1T48Tx1oi1X+Ca+afn+OzG/9SIQL8GPNvj4Rie2jlO2Gn2sXWf1uhs5aZQM8bMBJSI1cNbBdmGxQH7YEx9yP24IUT7bZPJnNrniEdRBcllD7Uz/3BrCv9s5Ly6jrmNsfJFLvbbYHlt0ae+G0RDRCfUqPBYSjTXV56J2NJ0OCehIx/J4QVlKouYEDX+WFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cZyFqI5I; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cZyFqI5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frxhP03y9z2ySj
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 20:56:51 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775732207; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CBfTM9xBob73GimIL4JdnF/RxealF87d/9oNo4Ik0D0=;
	b=cZyFqI5IyXW9GhG7dSNE6Tz6N3sL8eXtjVZqkjREGCrWma5MeBlXmhj/cGXWomywJOTzU1uMdPVn5lfgD0MCcMjbeuiJCwMP2BHcwDJ9MiMfJHfNnrjOckYN9r+ekUrLnwJSGBkCUENo3dTC90NhyJH0dyZPbb6a29ETzpKUvTc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0iBlhJ_1775732203;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0iBlhJ_1775732203 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 18:56:45 +0800
Message-ID: <f608d440-6d26-4dd9-b838-b5ad1e70541c@linux.alibaba.com>
Date: Thu, 9 Apr 2026 18:56:42 +0800
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
Subject: Re: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
 <3F909329-EB34-4B5E-A26D-081D9031DE01@outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3F909329-EB34-4B5E-A26D-081D9031DE01@outlook.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3239-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:moonafterrain@outlook.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 033AE3C952E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/9 18:38, Junrui Luo wrote:
> Hi Gao Xiang,
> 
> Thank you for the review.
>   
> On Thu, Apr 09, 2026 at 03:28:21PM +0800, Gao Xiang wrote:
> 
>> For this kind of stuff, do you have a reproducer?
> 
> I constructed a crafted EROFS image declaring plen=8192 and i_size=4096, giving
> inpages=2 and outpages=1. Tested under QEMU with kernel (v7.0-rc6) plus a temporary
> pr_warn trace in z_erofs_lz4_handle_overlap():
> 
> [   12.889652] erofs: BOUNDARY CHECK: outpages=1 < inpages=2
> 
> The image mounts and the decompressor is reached with
> partial_decoding=false and outpages < inpages.
> 
>> I'm not sure what you're saying, but I don't think
>> you really understand the entire logic.
>>
>> `m_la + m_llen` should not be page-aligned for typical
>> erofs images, you can just mkfs.erofs -zlz4hc with some
>> file and check it yourself.
>>
>> BTW, I just check upstream, and the inplace branch
>> works prefectly.
> 
> During testing I observed that the inplace branch was not entered with
> my crafted image and incorrectly concluded it was structurally unreachable.
> I apologize for the incorrect analysis.
Can you share your initial crafted image binary
with `gzip -9 | base64` encoding here?

I think the proper place to fix this is in
z_erofs_map_sanity_check().

But we only accept patches with proper reproducible
ways (e.g. base64-encoded zipped images or syzbot
link).

Thanks,
Gao Xiang

