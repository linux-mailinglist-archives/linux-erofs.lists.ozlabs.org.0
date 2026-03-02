Return-Path: <linux-erofs+bounces-2459-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLaiNVifpWmuCAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2459-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 15:31:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C51DADAB
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 15:31:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPhFv2hhVz3bkL;
	Tue, 03 Mar 2026 01:31:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772461907;
	cv=none; b=bf0orJ+f5AtnYVmU5DjdwbbKL0IS1xfWA1w7YWKPNNIXPFWDW5Ikzzp71Y8Fe7IMH6I0TYxb7fxc+8IW+oH0Ye3iHpwM58QnCs3c9hrFnv8GqMaErqnalw0P3rH7aBBvvaEHVqxIe8BfQK/FUqWW07cSc0BbqaY9xvIWKrdyv1YjfI0xM+1zysOuEqc7KwphSwifZitYd90Gf0UkZ63bAqx4u4WCef8CtQ0FMevzBZa4GWppHv8RIGrzhKQbG32RFSieH0PSFE04MtmgP1Xqmm17il5EFtXQ4AbOf9aB6fXY7SmVu1ohw/w8OGWEJisp4qKX2PVNK+qjR15EdGnTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772461907; c=relaxed/relaxed;
	bh=Xm4vXctV0FzuJ+WbTv3JqeE72Q00z0/K308lspoKlYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmEX5yl6vYA0rMGG+gaZ5EewVqi4PgFuyV8sFhZqioZlOBTtkqjyfjuCz963HczprsEOkErGKMBG9t21rumXZWJAiNVlrDllCRxHoZKub7Q2AzBsFl3lzD9MykhQuxa+sj6BoteaChVcom/6+Y0jHBHZpn7/98F6jIxdsnyfHM05/wFU+pDpPz69eHxtd3w+SOEiDvRIuFTey5IRrRepVho1N4y1argIgSNNRfiXhJptmf8nO2XOS/lvxYqdHF9oajow36lvoNfD04AveUBp9V/VwMrN06hrjD8DkdqkWrwRTjrD8vUOlA0JEJ0expz90wA/uWlOD7l1Tuuc2p6rMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f5K1UzGF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f5K1UzGF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPhFs0pPwz2xGF
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 01:31:43 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772461899; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Xm4vXctV0FzuJ+WbTv3JqeE72Q00z0/K308lspoKlYE=;
	b=f5K1UzGFJS6vNs35BwDVnDRM7Tr3amBmmTqLxEDaHmUjtYV2u0/63cFWS9jbm22V186zxq2VR36HPXWPdtrNOXA6rnFD5GvJb0iyVCJLDkJfwXBuNKfelUKQwGrxHrJ93G6nlE8cU6iIycX/j5sq4VHi58HPfiRDzJ0927OWVqI=
Received: from 30.42.59.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-5IIfM_1772461896 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Mar 2026 22:31:37 +0800
Message-ID: <d50a059a-afa1-4803-a570-127c62b6e154@linux.alibaba.com>
Date: Mon, 2 Mar 2026 22:31:36 +0800
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
To: Christoph Hellwig <hch@infradead.org>
Cc: jiucheng.xu@amlogic.com, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianxin.pan@amlogic.com, tuan.zhang@amlogic.com, Gao Xiang
 <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
 <aaWVwH_Xna22DTAq@infradead.org>
 <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
 <aaWe1PsmzYatc_zR@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aaWe1PsmzYatc_zR@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: E21C51DADAB
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
	TAGGED_FROM(0.00)[bounces-2459-lists,linux-erofs=lfdr.de];
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



On 2026/3/2 22:29, Christoph Hellwig wrote:
> On Mon, Mar 02, 2026 at 10:23:04PM +0800, Gao Xiang wrote:
>>>> I've trimmed down the call stack, as follows:
>>>>
>>>> f2fs_submit_read_io
>>>>     submit_bio
>>>>       mmc_blk_mq_recovery
>>>>         z_erofs_endio
>>>>           vm_map_ram
>>>
>>> ->bi_end_io code really should not be having random in_atomic()
>>> checks that make it completely different, but even if they have
>>
>> Thanks for the head-up.
>>
>> For this part, I'm pretty sure we need this particular one
>> otherwise the scheduling performance (latency sensitive)
>> is unacceptable for all Android phone users.
> 
> Where do you regularly get user context calls to ->bi_end_io?

The obvious one is that dm-verity, it's actually in
the workqueue context.

Thanks,
Gao Xiang



