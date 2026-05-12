Return-Path: <linux-erofs+bounces-3405-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPmINMrbAmrJyAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3405-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 09:50:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10E551C2E8
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 09:50:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF8075JW7z2ygG;
	Tue, 12 May 2026 17:50:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778572231;
	cv=none; b=YQNvSkRIogfjK/Vhqo6eoOEq97rZdSFkXLzewfSMfhok5ZterfCmHkUAvnnib4zBHOYuVoXNtIqAwAvSUgJ0XK8b0eXw2hmPqkWnb4l3sLyrLuoEupOBvfI3CSUTddcfqa5YWRDglGZJM1vxwfVj08wr6T9wuYd0PR/ZTrR04BzWmMLp6P36sQv6QcMHZUcuOLI6xXB/8ofHvG3Uv5yzoPT/K2s6GGIAA542UpMxy26Tus11Pq2359fjTaqaIVsWP9MAMDUbwbM3U2NXd0E3dLAPlczd51UkxPkFoT/5CFBWG4obLpCd6CKJRLvir4JgwfOcGH4ENjHaDy2RQJJ4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778572231; c=relaxed/relaxed;
	bh=/9Pa2zVHN342aqTKMVpbrHhy6+1SlaI8Gt/QQlhdyT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hg/9VENO3Wj5vDZzeUrX2gzm4TgdQkgY2TPM4uB45JfuNW2PnTPT4MQFI+P99BTG9dDM37D3cHqr0o17OP5sS4i+I1jLd6MLI5L4vVwYHjwdobvGpuNSAgqx2yLlIuTAihyXWmCPRqN6GjLO8Dk49Pyq9MRb5KpvMEoB/+gi6J/65PSr3Gc6tlUHHvjkHDucPS47LyzUYDUXMiizfdGeZNhjwkdXvxqVQhyFMsEOs1JzAf3WAqJ+VnrRq3rYuB/lP7gNw4UuCA0iIWdDZaIIUDLrJKJrY9B4DARu4LYRkuys2NenDDi899V80OEvyPRMAchFUiNjUVqbjjbGx5WcAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yC7bs54A; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yC7bs54A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF8054MJvz2yFl
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 May 2026 17:50:28 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778572225; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/9Pa2zVHN342aqTKMVpbrHhy6+1SlaI8Gt/QQlhdyT4=;
	b=yC7bs54AMJ9Y8lLAGMclcHF/eVqXSTMS9FI5gVmYWlax4M3OaOk6yv1btvQaMbBPRoGCpE2UvRjFbmRUkcYM0LZvJoQvnzpJGNFoBl1Z8EXhuk9Q+ELmbg0xhsa4ad17+aSBO6V0wkf5JRuW0SEa1YLLiFBzyYTMi85JgK5SG+E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X2prWs3_1778572222;
Received: from 30.221.130.241(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2prWs3_1778572222 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 15:50:23 +0800
Message-ID: <bceec1dc-78a4-4fd2-aef0-6d6670048dea@linux.alibaba.com>
Date: Tue, 12 May 2026 15:50:22 +0800
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
Subject: Re: [PATCH 2/3] erofs-utils: lib: reject packed inodes in metabox
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
Cc: jingrui@huawei.com, zhukeqian1@huawei.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20260512071631.969752-1-zhaoyifan28@huawei.com>
 <20260512071631.969752-2-zhaoyifan28@huawei.com>
 <d759a7f6-b273-4a3b-b686-3ff48ccd7150@linux.alibaba.com>
 <aa902420-a6d8-41c8-b3c4-68d6be1c839b@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aa902420-a6d8-41c8-b3c4-68d6be1c839b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: F10E551C2E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3405-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action



On 2026/5/12 15:46, zhaoyifan (H) wrote:
> 
> On 2026/5/12 15:33, Gao Xiang wrote:
>>
>>
>> On 2026/5/12 15:16, Yifan Zhao wrote:
>>> If packed_nid carries the metabox NID bit, loading the packed
>>> inode first redirects its inode metadata lookup through the
>>> metabox inode.  Initializing that metabox inode can then read
>>> metadata that refers back through the packed inode, forming a
>>> recursive packed inode -> metabox inode -> packed inode path.
>>>
>>> Reject such images while parsing the superblock, matching the
>>> format rule that the special packed inode itself is not stored
>>> inside the metabox.
>>>
>>> Reproducible image (base64-encoded gzipped blob):
>>> H4sIAAAAAAAAA2NgGAWjYBSMVPDo4dcHrY0KwsxANg8jAwMLFjVMSGzPx/7Lzj3zXb3jSFTh
>>> 5iN7v6CrbQSa8f8/gq8GoRpARHErYxYDEh8EVAm4jw2Il4AMFYDoB7IYmDGVNRhAzf8PBMh+
>>> yEjNyclXKM8vyklRIILNRcA5o2AUjIJRMApGwSgYBaNgFAxpAGorv3VkYtBgQLSfQW3sF8wv
>>> kJvZDSqIXkCDKpANlWxQZ2Bk0NPTS8RlPkgXqP0Oa5/DxNDNB7XvR8EoGAWjYBSMglEwCkbB
>>> KBgFo2AUjIJRQBsAAEZO6n4AIAAA
>>>
>>> Assisted-by: Codex:GPT-5.5
>>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>>
>> Can you fix the kernel instead first and backport to
>> erofs-utils? like below,
>>
> OK. Should we do the same for [PATCH 1/3] too?

Basically for incompatble features, they should assume to 0.
So I don't think [PATCH 1/3] is needed.

Thanks,
Gao Xiang


