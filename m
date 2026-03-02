Return-Path: <linux-erofs+bounces-2457-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Dk4ChagpWmuCAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2457-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 15:35:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8E1DAF35
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 15:35:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPh440mRpz2xc8;
	Tue, 03 Mar 2026 01:23:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772461396;
	cv=none; b=V2ZpWWj2LKBa902duCoST+viBl7Kx+N2XZECqZNROMGeJlPTr/leUjG8GRPry24odAZxxgvTITFKf+CkdwXUtfCwGaBFfWLXLokmSuZ2tWHKawHzJQnRhuLwNwFmARyUq+RC+RH05R/72Wv+z76dBXeE1BD6OzyvADZveIifqpQA1Jv/MdfG6zuBDAyq0K1/3qhJWq/5c2KFRg9DG+/4UCpLkxc2CDUDqFQ6RCJ+2Qs/y5zjkOrGZkswgVmeW1W498zfo4U+gP4JRaNUVbqtkbgw5p1PIF0TR/M5Vc1OM/3DeBu16gVAefQxgi7wPcJurWgzIr+85SNyPE3JKbXMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772461396; c=relaxed/relaxed;
	bh=2FugYvgsUqNBnGpuxWyzeKwGRCsMsJJYaZoBUD/m+xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8+5sW/MBlSjRV0Ly27tRbQwdkhrWjLNoGfO68Fji1TCu+eThO3LWL8ojxVjIlLDf97FKd+xuhmyUok5tuwZoTu1jGgYqQsHbTxT3fcSH3I50xpLXMjPjHJnXsDkjnZb/+yfbtk7xOv/+SJ51cSkQpsiU2tc/CoS+Oat1CVT3PGQZ0thw3bMiKW4tNDayYvPSeB3iaXj9h7LUF+dnaUe0/8sAhdV/oHgq4nIko9O3X7PyDrPlh7O1zYc+56qeGdBA6QvulplQZHeQUwA0CztX6RJD8ZAU5ADbKWKUE5tHF6U/yHC+vAF9DfwP3e3i/k7wFOT0NjMN6toFRsfWtx5Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DtfxtaYu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DtfxtaYu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPh414dpYz2xGF
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 01:23:11 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772461386; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2FugYvgsUqNBnGpuxWyzeKwGRCsMsJJYaZoBUD/m+xs=;
	b=DtfxtaYuOGBayoCMeolBxmUjQN2w48TP+PHqFFw4vmIh/9E8gl/Zeg3nGegu4fYhyALAiup3Rm23FIE2N4qdx6JZRxxF4vj7ZZjfN1KbKAzHBHETmMBinw3FqhNYB0pMxBQTOeqIz6WTVQMxrlxK7NA78U0smele0dFOKyWVsi4=
Received: from 30.42.59.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-5AKXW_1772461384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 22:23:05 +0800
Message-ID: <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
Date: Mon, 2 Mar 2026 22:23:04 +0800
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
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
To: Christoph Hellwig <hch@infradead.org>, jiucheng.xu@amlogic.com
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
 tuan.zhang@amlogic.com, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
 <aaWVwH_Xna22DTAq@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aaWVwH_Xna22DTAq@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 3FF8E1DAF35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2457-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:jiucheng.xu@amlogic.com,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianxin.pan@amlogic.com,m:tuan.zhang@amlogic.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Christoph,

On 2026/3/2 21:50, Christoph Hellwig wrote:
> On Mon, Mar 02, 2026 at 10:51:03AM +0800, Jiucheng Xu via B4 Relay wrote:
>> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>
>> When current->bio_list is non-NULL in submit_bio_wait(),
>> submit_bio_noacct_nocheck appends bio to bio_list but skips IO
>> submission, causing submit_bio_wait() to hang indefinitely.
>>
>> Fix this by temporarily backup bio_list, setting bio_list to
>> NULL before calling submit_bio(), then restoring bio_list
>> after submit_bio() returns.
> 
> No.  Fix this by not doing something that is a bad idea.
> 
>> I've trimmed down the call stack, as follows:
>>
>> f2fs_submit_read_io
>>    submit_bio
>>      mmc_blk_mq_recovery
>>        z_erofs_endio
>>          vm_map_ram
> 
> ->bi_end_io code really should not be having random in_atomic()
> checks that make it completely different, but even if they have

Thanks for the head-up.

For this part, I'm pretty sure we need this particular one
otherwise the scheduling performance (latency sensitive)
is unacceptable for all Android phone users.

> that need to use GFP_NOIO.

Yes, it should make vm_map_ram() in the end_io path use
GFP_NOIO instead.

Jiucheng, could you add memalloc_noio_{save,restore}() to
wrap up this path?

Thanks,
Gao Xiang

