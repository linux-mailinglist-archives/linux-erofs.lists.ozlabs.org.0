Return-Path: <linux-erofs+bounces-3687-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WqqiJlFQNWousgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3687-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 16:21:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6566D6A65FF
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 16:21:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=gir92c1b;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3687-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3687-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghfs96Wv5z3bqD;
	Sat, 20 Jun 2026 00:21:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781878861;
	cv=none; b=lk5YqMOBy2++HVS2kSM7m0xA/JtHMdiA+VzyMMRUfY8twaHii+5b3YujUg85WseiYFNVizCwkp7fEzB9K8Dey5NEVjI1Ck2iL9MW6tZ41PRZB/AscJcoGNCgsKGApiH1Qg316xkJSaWDuAwFe7WNM3St2f93oZgqj02ZNb0eUJlCcruUVOqrfzEDS+yRKXoIzBhCAJILRN21kolKG27EJGBop28I9VaxZabbijT0Ji4jwbALPcySV6kv5xkM4AqqtIjHin1t08xJBk75YM5uOSfNGkQltZl6Slh31aey4ScbBN5XRFJ+777vzkzLjv20OSfTUtLcRbugoH7sHReRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781878861; c=relaxed/relaxed;
	bh=v7QN8cgA1vRY/cW4m/TkqL9jlmMh794tIfnv4Iho4io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lg+2i3KBFxl2cedGm5GYOHLl23sJTYAV9k19nFtkg+WlBAKpDc6eZA5rITP6De07op1FoQ3qR9oNhZ4pwsiqwTmmA3jKg9DDUI/7FaIO6zQocKwRfv6ypMugXl0SzWkthqZaD7QdngMYBJAup+ycAUfQj1mgRT/LLTvIMhlby+kY25CJZsEpdDhRAxRxxA6MxRvpreBCQlbd0LY0jGPljJVBSfQ6xb+SwN/cfx6Om1TxWqLms8LwaGo1rCAcbRvVyB5PqO39PwXXcN+MgwIY1wWhuAIIKL8gcIwIF5gVeYC77D+eD4QRE03NKiOiKCsqNkZkYfcIrfjseyI+7vNL5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gir92c1b; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghfs730RZz2y7r
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jun 2026 00:20:57 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781878853; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v7QN8cgA1vRY/cW4m/TkqL9jlmMh794tIfnv4Iho4io=;
	b=gir92c1bsQM25/za0wDCzDiQqKYyEzgst9zR087v0zJlm6KRbXpPraVm7EWTmhJhz/E339G1awbhIbtLD3Ccgaiyk3dV+LfUWL/3rtg0ghp78RYxAYvgSlax4ssYTNvmMZHiKTa+abWm7vo/thD3W5TvPIwnemTxv6hc/qH7/Kg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X5A-J1P_1781878849;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5A-J1P_1781878849 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 22:20:50 +0800
Message-ID: <bffc5b69-2f90-41f5-9b93-fe527da63f64@linux.alibaba.com>
Date: Fri, 19 Jun 2026 22:20:48 +0800
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
Subject: Re: [PATCH] erofs: complete fscache pseudo-bio once when a read is
 split
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc: Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260619135800.1594811-1-michael.bommarito@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260619135800.1594811-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3687-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,google.com,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6566D6A65FF



On 2026/6/19 21:58, Michael Bommarito wrote:
> In fscache mode a compressed read uses one pseudo-bio whose io->end_io is
> erofs_fscache_bio_endio(). When prepare_ondemand_read() splits the read at
> a cached/uncached boundary, erofs_fscache_read_io_async() issues several
> fscache subreads on the same bio and erofs_fscache_bio_endio() calls
> bio_endio() on each. The pseudo-bio is not chained, so z_erofs_endio()
> runs once per subread while z_erofs_submit_queue() counted the bio only
> once, underflowing pending_bios: the reader hangs in D state, or, on async
> completion, the first completion frees the decompress queue and the rest
> are use-after-free.
> 
> Hold a bio_inc_remaining() reference per issued subread and drop the
> submitter's initial reference with one bio_endio() once submission
> finishes, so the bio completes exactly once. The request path
> (erofs_fscache_req_end_io) is unaffected; it uses its own refcount and
> never calls bio_endio().
> 
> Fixes: a1bafc3109d7 ("erofs: support compressed inodes over fscache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> 
> Reproduced on x86-64 with KASAN via the erofs-on-demand path (a cachefiles
> ondemand daemon serving a crafted compressed image that splits a pcluster
> read). Found with the help of an automated review tool.
> 
> Without this patch a stock kernel either hangs the reader:
> 
>    task:dd  state:D
>    filemap_get_pages / erofs_file_read_iter
> 
> or, when completion is asynchronous, faults:
> 
>    BUG: KASAN: slab-use-after-free in z_erofs_endio
>    Kernel panic - not syncing: Fatal exception in interrupt
> 
> With this patch the same daemon, image and reads complete cleanly: no
> hang, no KASAN report, no panic. Harness and full logs available on
> request.

fscache is already deprecated, I will remove this path
in this or the next cycle: it's not worth to improve
this, and bio_inc_remaining is suspicious since I never
tend to introduce chain pseudo-bios.

Thanks,
Gao Xiang

