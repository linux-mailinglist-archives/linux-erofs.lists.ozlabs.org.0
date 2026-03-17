Return-Path: <linux-erofs+bounces-2806-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DK0LPRyuWm8EgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2806-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 16:27:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E2E2AD049
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 16:27:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZwnY2zR5z2yh4;
	Wed, 18 Mar 2026 02:27:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773761265;
	cv=none; b=dQ5GNLUxeLvMLq41/eQ0UwyREaC6xZLnGNCFxW6vpAQBNMfVs6X+fq7tLs+Hy8+spTwvuWmBYzDH8NJflQnLqmXV6oHkKOXp9TBpCswN38BCXAL8BZfGzEI+F/B5dhsj0LP4Vj6JF25AfeynU9ygcFk6GtH+6XInuTh5ErfT1lviXBqHTH3y8o4d/dIxYWevwSxwZF62cZgjzzGxJTWnEH3/RrqJayK94hMektBoQpS593FDqvotjvMl+yMQOpnj5NLpRPMgQVL+1XoMRCEcjET0Lvry4WAMaHUglW+zGXb1FDezLPAsaH3t5P+YBARlDfNJkb/DAkBcI1rj+Msy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773761265; c=relaxed/relaxed;
	bh=B6l9BHLd2QEPLhFYcGwt4EBf7fas3+t8opcdWNgQJQI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X06pMx75MGdWhL530P5+PcIQC8+OQXtw8EaTaxaShTanomnIOpM9wep0XZKWFK0jFOaIlI0BuqlSrcSX8oG8n+dC3OZ8wM3EGIS9WMGbj04JC72W+BUJ8acZy4n50a18mt0KMXK7ad8tgQB1WvWicKe//EZzc8LZ2VYAwfBJ7kdivA8ZwRuevtMZTORYiOEsTNjQt8uD7Yo7FB0eGDsTNv6k+ONpTlE8rkDyYT57lqXaLmlFA+ze0n2LnQ5cKfE1GcZS86hkt1ekvcj1RvHmhZnW3Y+9IfuGZRK0JshGbNAYE4B5hNOUmWJqnr4x15YfBn2qT8sL4DZPwQNDWgbksw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uBxB5jpp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uBxB5jpp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZwnX1jSTz2xVT
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 02:27:43 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773761259; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=B6l9BHLd2QEPLhFYcGwt4EBf7fas3+t8opcdWNgQJQI=;
	b=uBxB5jppOa/kJIeuwFDbGx86bV6XqzADJuX4nigTwUXF7sumsUBMGwKWqX+eAXfcNdvhzjZDTR7rGXt9osGnQoClLEg5wKBCHd/31ci4kqIqfJNTavAXfs0cG/30MtOPCTbmNDoRC67GP0ZuycNJEC2wFiY4+mVO8sxLL4vvmlY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.BTeFX_1773761257;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.BTeFX_1773761257 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 23:27:38 +0800
Message-ID: <64d2c179-0f0d-4815-bc3f-562e6d93284d@linux.alibaba.com>
Date: Tue, 17 Mar 2026 23:27:37 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: harden h_shared_count in
 erofs_init_inode_xattrs()
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <20260317151514.3529-1-singhutkal015@gmail.com>
 <e7285eaa-281e-4a5e-adc6-8af88b166b43@linux.alibaba.com>
In-Reply-To: <e7285eaa-281e-4a5e-adc6-8af88b166b43@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2806-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C3E2E2AD049
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 23:25, Gao Xiang wrote:
> 
> 
> On 2026/3/17 23:15, Utkal Singh wrote:
>> `u8 h_shared_count` indicates the shared xattr count of an inode. It is
>> read from the on-disk xattr ibody header, which should be corrupted if
>> the size of the shared xattr array exceeds the space available in
>> `xattr_isize`.
>>
>> It does not cause harmful consequence (e.g. crashes), since the image is
>> already considered corrupted, it indeed results in the silent processing
>> of garbage metadata.
>>
>> Let's harden it to report -EFSCORRUPTED earlier.
>>
>> Reproducer:
>>    mkdir testdir && echo hello > testdir/a.txt
>>    setfattr -n user.test -v val testdir/a.txt
>>    mkfs.erofs test.img testdir
>>    # corrupt h_shared_count (offset = nid*32 + inode_size + 4) to 0xFF
>>    # then: fsck.erofs --extract=/tmp/out --xattrs test_corrupted.img
>>    # Without patch: silently processes invalid shared xattr IDs
>>    # With patch: returns -EFSCORRUPTED
>>
>> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
>> ---
>>   lib/xattr.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/lib/xattr.c b/lib/xattr.c
>> index 565070a..9d52a18 100644
>> --- a/lib/xattr.c
>> +++ b/lib/xattr.c
>> @@ -1182,6 +1182,13 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
>>       ih = it.kaddr;
>>       vi->xattr_shared_count = ih->h_shared_count;
>> +    if (vi->xattr_shared_count * sizeof(__le32) >
>> +        vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) {
>> +        erofs_err("invalid h_shared_count %u in nid %llu",
> 
> I think this line is incorrect (did you compile at least?), also
> you need to Cc LKML <linux-kernel@vger.kernel.org> for all
> kernel patches.

Sorry, I misread it, but the patch version number is quite confusing.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang


