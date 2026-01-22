Return-Path: <linux-erofs+bounces-2157-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPgpC8k4cmmadwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2157-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 15:48:41 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F080A681BA
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 15:48:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxkTK3kYPz2yFm;
	Fri, 23 Jan 2026 01:48:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769093317;
	cv=none; b=mmcZXt6nfafhvsHHl1nYG47pJG0b10OH+h4wjeg3PuF/Tbw5Y9L8ezPIME1DfstZ7ILMqApI0YPKaUxVQdmGKOTO7pdgbCE31IfoeLdP3Ab3ialwLP0IJi0tExtcDeoYsDp5kJCYtf00VjtPmmDkmjCAzpcIXXlKP82yb1qpl0e4ef0dEB6wyAbWZd+/UFeOvdWSox0qUDJdT9CYkshSmRJSH8d2uo46LEpLZvePeh/9o1f+NPiSURrJK3SheN8rhkDPogd9FEBPX7tNyKRx08oMNqPzO8yWhnkfyUwbUrJxyVpU+10EWHfON+koCSLoM8IzKM8lm/MHEG4/f9FKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769093317; c=relaxed/relaxed;
	bh=oKhdafUCztgqQ7be+GxGMewazRjtOJp89t4HV5luhIM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Q2vYdxXWSKZaulsdBp3rdMPjptaYVaEMB8Cj2/lmH1gABfdnR45TkpmIbmNMkABG2qT2Y7gbpxwgdNMRt/wSSgr4n7kFlW3xwHMDFjBtGxDpf6+ZECeygnTTnt+pH1CMWzg5HP8vIX/cPNUjgmnLlAb7if+82IJfXu7A/IQwzC3LGbQkXMO66ROE1GQySmT9q0gWJ6A9fx6A5rV4PpBoxT2Jm65OHmezJFF18mm4AX3cJz/Bb9KlNO+pk+SX4lTiNZhi6x6uGVaCfE7V7eFfAE86C2Yf4B3oywa4vRh5VFX4xSmpZfNcPlY++c7PrTOqrjcV836FEpKYi80jEch1MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SQl+z5hl; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SQl+z5hl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxkTH11ylz2xl0
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 01:48:34 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oKhdafUCztgqQ7be+GxGMewazRjtOJp89t4HV5luhIM=;
	b=SQl+z5hlGDlfIpoD9aks61iA7Lj4cFwVWxcbRPiKYY1cU+5iTpUejvYpti0I3F+/93OUsbxAQ
	tLLn7Yc3w6+onEqLumifDXoT+WnI4N5KPh0GQ7QPMjMvzOu+wp29L4IKm12M1rnBHlcWjQyMm0q
	+Vf1MM3Zy4OnWtxjXffRclE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dxkNX6Rlyzcb0S;
	Thu, 22 Jan 2026 22:44:28 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 521C340363;
	Thu, 22 Jan 2026 22:48:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Jan 2026 22:48:27 +0800
Message-ID: <ffdfbf7c-25fc-47ca-8c90-c98301847a1f@huawei.com>
Date: Thu, 22 Jan 2026 22:48:27 +0800
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
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
To: Christoph Hellwig <hch@lst.de>
CC: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <5aa7566e-c30c-470a-ab77-8b62a3cdf8c3@huawei.com>
In-Reply-To: <5aa7566e-c30c-470a-ab77-8b62a3cdf8c3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2157-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:brauner@kernel.org,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_XOIP(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: F080A681BA
X-Rspamd-Action: no action



On 2026/1/20 20:29, Hongbo Li wrote:
> 
> 
> On 2026/1/16 23:46, Christoph Hellwig wrote:
>> I don't really understand the fingerprint idea.  Files with the
>> same content will point to the same physical disk blocks, so that
>> should be a much better indicator than a finger print?  Also how does
>> the fingerprint guarantee uniqueness?  Is it a cryptographically
>> secure hash?  In here it just seems like an opaque blob.
>>
>>> +static inline int erofs_inode_set_aops(struct inode *inode,
>>> +                       struct inode *realinode, bool no_fscache)
>>
>> Factoring this out first would be a nice little prep patch.
>> Also it would probably be much cleaner using IS_ENABLED.
> 
> Ok, Thanks for reviewing. I will refine in next version.

Sorry I overlooked this point. Factoring this out is a good idea, but we 
cannot use IS_ENABLED here, because some aops is not visible  when the 
relevant config macro is not enabled. So I choose to keep this format 
and only to factor this out.

Thanks,
Hongbo

> 
> Thanks,
> Hongbo
> 
>>
>>> +static int erofs_ishare_file_open(struct inode *inode, struct file 
>>> *file)
>>> +{
>>> +    struct inode *sharedinode = EROFS_I(inode)->sharedinode;
>>
>> Ok, it looks like this allocates a separate backing file and inode.
>>

