Return-Path: <linux-erofs+bounces-3526-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PjAtCHtXJmp1VAIAu9opvQ
	(envelope-from <linux-erofs+bounces-3526-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 07:47:39 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFF0652E90
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Jun 2026 07:47:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=bg0M28I0;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3526-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3526-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYgzn5fhdz2yR5;
	Mon, 08 Jun 2026 15:47:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780897653;
	cv=none; b=VbXRx48swKdYsh7wWqdyJGOpLOJdREIzXV4GOilL0NaK1EzkcfcgVmX26m4Qre8yYA79A9JZlNv+Md28wSlfqMIt+fJfT6S8gK/LOgaGNKuIdoam0qbmYJVcL7ceZkp5dls8S0vg0j7FfzGmuaMs7pSYewETzI14k3LS8+E7mgeYpejkeJMY4NOuIRH3gkN/uQXEwfDnSemaPu/drMjjdFvIRhkugGN/ZrChfjWIV6dStAI1W5XLGQF9RhdWbhbxBAmQ54W7lNzfL5XqlH3Ee6CL4eWGpoUUSCfZbjHwXlMDyNRhnEy6msUPcH9lu14HR7yh2upbkjAI1anvSMgGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780897653; c=relaxed/relaxed;
	bh=hlB46HKiYGvKpKR1bCWJmvd0hr/PjEuYmnUd0ykOlgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L3J3AvJY3HdoL7EkYPvxdB+OQiIvDjZZm3fMLRQ4ZFfc+oATNVnOHdxl6HaBGsfYZ/By8BEdQpzvzL9kREwOyO0fnVLACAUItuWf0Keze/aFX4e6w+zxn7WAI+4EgaYMAQ1AqcPN9Ztu+DpEZ3xHmzp/IZMqlmQW3ewuA18fnU8MmW2pmMEukzVlgEHRFrMGIzPAanduQA03wF/m2RfhigDjIJwrl3M+CD1tGkIOuqNkr1jsAU5sG9O9xVsNFvMb06OByt9T8JOF6v0PLM1RmwJ/9dM6FNLVpOi42/27D3ZqLV8xVp1avL+4k+ecnN/htg0JrRUf66pIbawz1gkhPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bg0M28I0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYgzj5lQtz2xRs
	for <linux-erofs@lists.ozlabs.org>; Mon, 08 Jun 2026 15:47:26 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780897614; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hlB46HKiYGvKpKR1bCWJmvd0hr/PjEuYmnUd0ykOlgk=;
	b=bg0M28I0HcdxUFIrhGnKl6qgvB2dm+e1uHGlb7XgcfSRreCInNDJGjCjX8xP653hgYz8JyC3gAuosH2pV93+jIkLiwdlkDiXgxS4Ko+RRzRO90sKuog/8hlN1pZyx1XctbSR76Sij0KIE+DQrmopFtS3xIDZ5aie0OH1+NaQKMc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X4Jf1zE_1780897611;
Received: from 30.221.133.92(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4Jf1zE_1780897611 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Jun 2026 13:46:51 +0800
Message-ID: <9ddb3fab-e5b1-4dec-a73b-814e833e208d@linux.alibaba.com>
Date: Mon, 8 Jun 2026 13:46:50 +0800
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
Subject: Re: [PATCH] erofs-utils: build: link tools with liberofs dependencies
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org,
 guoxuenan@huawei.com, zhukeqian1@huawei.com
References: <20260529071702.981596-1-zhaoyifan28@huawei.com>
 <aiA8AhQvFtK_QMwb@debian> <1c8489d6-c55b-426d-b965-b6b96caa616f@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1c8489d6-c55b-426d-b965-b6b96caa616f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3526-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:guoxuenan@huawei.com,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CFF0652E90



On 2026/6/7 19:29, zhaoyifan (H) wrote:
> 
> On 2026/6/3 22:36, Gao Xiang wrote:

...

>>> +])
>> Although I admit that I'm not super happy with this approach, but it
>> seems that we have to do like this.
>>
>> My only question here is that why  ${libxxhash_LIBS},  ${libxml2_LIBS}
>> and ${libnl3_LIBS} cannot be appended directly to LIBEROFS_LIBS as
>> others.
> 
> As these flags were conditionally appended to liberofs_la_LDFLAGS in the original lib/Makefile.am code path.

Can we append them into LIBEROFS_LIBS directly?

Thanks,
Gao Xiang

> 
> 
> Thanks,
> 
> Yifan
> 
>> But I think it's fine to guard `-lpthread` with enable_multithreading
>> tho.
>>
>> Thanks,
>> Gao Xiang
>>


