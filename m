Return-Path: <linux-erofs+bounces-2553-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFNIMw/Cr2kucAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2553-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 08:02:39 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE30246178
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 08:02:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVPvw0Z2dz3bjb;
	Tue, 10 Mar 2026 18:02:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773126156;
	cv=none; b=SAQZhqjx9tpzmz32fpgsNJwGKpko/6Q8X0Tgsyj+zu59fIpFaK/Fs80xzZ2ms0ZuGtEvbAmUgyu03GO32ed8UKX5W8EZZeF2e7KO+nczxcjj8AM7SG8b2/jP3GpxM6dIOg3BlKNhjjJDB1636LeUfZLuKnrHXRob+1jyODmzWh9jZlzl8omZIBfeQsEzElT5ws494mdb68U8blivMFq8TWisR3IsiI5L7eV2eoPhahwWqFJYkinU9GQ6dIFLMl4FuTRon0FUlnNddAaCC94sTzZu3nc45PWjwrBu0EDdQwLigzHMaHtlISWnxklDVM+RqSWoT+tNvBNAK9Zn5GCJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773126156; c=relaxed/relaxed;
	bh=8OfXxbZRS7165p6jxMorXrfU7kFI5hv4wFv/bCV1+9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRKLDAcundYfu7doQLOvhv2hTvb34MY8XsaDFTXmqfUTP8YE+xlbJky04DkwNtNt95CpSEXbcTFHin0u8GNFyyqI9/erCwfr6FzUWnq6CSc9eHUYkwG1StjZ36jqJyfeOP5taRRY+zwsNfjHj/AkLZd6HKqFIk1e2Kz+l7pkm90i2FlZVh5Wb2+6DQPUMjQ/H8pbBycvkrK3oA6ZYVgGj+KOkJ26rDrcvNpteHLFDqTFAwikhVAIO/tDWJb08Xtbfro79dW79Y4av6xGs7ZVreckwigPnRWhqTE/EqKQ+6dWaDHO/fJzLKFD7ard7g5H3VaZnMAPjH+YaqSrfp2+Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aQ+yv2k1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aQ+yv2k1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVPvs35xSz2yFY
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 18:02:31 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773126146; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8OfXxbZRS7165p6jxMorXrfU7kFI5hv4wFv/bCV1+9s=;
	b=aQ+yv2k1eXwy1tglptd+aOxzp14ntmoyARiLFP7omumCw9l3qrVMSzUz9luqfbX0w5C2gh9mMTf469aziMQh2abu65CJ85rrMmLyESP8cYsjUGyI3OypsN1r/8F3eRj9/CnxrPNJX7jTo6ha0x5KXZogXamjdO9wwY8F9++CIZc=
Received: from 30.221.132.177(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-fCCDd_1773126144 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Mar 2026 15:02:25 +0800
Message-ID: <a15eeac5-8035-4ac5-93b5-5c71f3ce7105@linux.alibaba.com>
Date: Tue, 10 Mar 2026 15:02:24 +0800
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
Subject: Re: [PATCH] erofs: introduce nolargefolio mount option
To: Chao Yu <chao@kernel.org>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>,
 Hongbo Li <lihongbo22@huawei.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20260309023053.1685839-1-chao@kernel.org>
 <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
 <dc645bd1-2881-4472-8918-0eada3786ab3@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <dc645bd1-2881-4472-8918-0eada3786ab3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: DCE30246178
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2553-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:guochunhai@vivo.com,m:lihongbo22@huawei.com,m:willy@infradead.org,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,linux.alibaba.com,google.com,vivo.com,huawei.com,infradead.org,suse.cz];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,googlesource.com:url,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Action: no action



On 2026/3/10 14:43, Chao Yu wrote:
> Xiang,
> 
> On 3/9/26 11:03, Gao Xiang wrote:
>> Hi Chao,
>>
>> (+cc -fsdevel, willy, Jan kara)
>>
>> On 2026/3/9 10:30, Chao Yu wrote:
>>> This patch introduces a new mount option 'nolargefolio' for EROFS.
>>> When this option is specified, large folio will be disabled by
>>> default for all inodes, this option can be used for environments
>>> where large folio resources are limited, it's necessary to only
>>> let specified user to allocate large folios on demand.
>>
>> For this kind of options, I think more real backgrounds
>> about avoiding high-order allocations are needed in the
>> commit message (at least for later reference) also like
>> what I observed in:
>> https://android-review.googlesource.com/c/kernel/common/+/3877981
> 
> Basically, the background is about contention scenario on large folio allocation,
> it's among multiple users including EROFS in Android-system, as it's related to
> internal scene of product, so I can not provide more details now, I'm sorry
> about that, but I'm glad to discuss based on the background and pain point once
> if I can share more, let's see. :)

Understood, but I think it's hard to justify an upstream
solution without a public load for discussion.  Anyway,
I can imagine some real workloads which large folios could
cause unnecessary pressure since I once worked for Android,
but I think others need an explicit one anyway to justify
this.

As Matthew and Jan mentioned, it's hard to add a per-fs
knob like this.  If it's Android-specific and no possible
public infos, I suggest leaving the changes Android
downstream for now, until the workloads can be made public.

Thanks,
Gao Xiang

