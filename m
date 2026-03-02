Return-Path: <linux-erofs+bounces-2456-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHZLAtOVpWmPEQYAu9opvQ
	(envelope-from <linux-erofs+bounces-2456-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 14:51:15 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 547CB1DA211
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 14:51:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPgM221X6z2xc8;
	Tue, 03 Mar 2026 00:51:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772459470;
	cv=none; b=itpbcDxHtCNEOXxfHaws+VkbsZvNXVAzJZzDvLgioeSboHSxVDNuEly1ehSKekduZFOAK4Gx16aAtoxCiBjFrWf4Js0tJhWrmWPuCG6Nrm9BuBMDhgZ7X6cWMh/MawD+V8JJdP9XOPrKCSVgyqa9itZK0r/CERWwVNnUW+hGjr9ScqrFOYdLroJRzbEvYRgi5vztAIGn8LKgveyJZ8Zi4OBa111llK4Q6Lpvi2WeDHYgub3hUK/eQ0GPsOw5pHL1g8WNd9x7L+Amh7b092ojrU5RaBhU+5oFuvNNTqOdHuGtwaxJRfa3WddvVAnkqzv1t2wmfI7o3/pkQxHzmDupvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772459470; c=relaxed/relaxed;
	bh=0mxOV7omutuRZu2xaV3AtdtQohZwv5xm8F7gjTBJ59Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKGi+v/aTmSvO6dMpGJDdrpS9LknH36qboXVhfwdI0IbfouMT8iQuTAaMh+1d/fkBH8QFv0pU/NEaRObb94FJWuDa/pDftlIbSb5sDOJC4YVjGfHnwpnMzXLF+WOUJH/+BOryCOSLCXyH84bnsOxwkOvjqfJ9YG2Zvp2qfPW4kP/vFGuu23Qb0y/ME+VLF5bfOBOphSiOwVh3/fpqvF3pMJThBaRZ/KdEjfwq3Uvf2PZzqNO7zheq+C4ugDL5SBVUOs3hN4RxeQ3iJ5rbsv7EA699hHhAi106Y83sUDrOiQlEy7VC8vLmYej2eq2jWG/oH0jehpm41PAqP0zmpAAaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t9FoqLVN; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+ce5019daea4c3780914a+8226+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t9FoqLVN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+ce5019daea4c3780914a+8226+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPgLw3H4Pz2xGF
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 00:51:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0mxOV7omutuRZu2xaV3AtdtQohZwv5xm8F7gjTBJ59Q=; b=t9FoqLVNqtepR+hrSxb7DbRRW/
	ZEx/KAh3QPrXU9qH4AEFUMbbhSfoCIIS39yTzAfwZMdnXRn14QDzmT4c7ioUu7OdAJpPYhFIe/b7K
	4vy0fepxNw5kD67v7lgefavzXh0P0JjwKevMmcIkjXVfUWYlEZ55VH8qlUaF8/yZ+3YkbVx1Txz3m
	PFqH98KUC8WqrfNY7ItimnKHUm+G//woU6ICgtGA5R/mZIrwRK2F8ubn0L2uXBW+r6HR878wlftM6
	AmFx+g+vGqMyrWQjLlLHmK9kGab2HHHITzv6WnBN2ABtm4/SzBBGC4gJ3YqdTbW8/O4i/+CWuXYdR
	wjYc74hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx3fk-0000000DA78-1MN6;
	Mon, 02 Mar 2026 13:50:56 +0000
Date: Mon, 2 Mar 2026 05:50:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: jiucheng.xu@amlogic.com
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
	tuan.zhang@amlogic.com, Gao Xiang <xiang@kernel.org>,
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
Message-ID: <aaWVwH_Xna22DTAq@infradead.org>
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2456-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiucheng.xu@amlogic.com,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianxin.pan@amlogic.com,m:tuan.zhang@amlogic.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,amlogic.com:email]
X-Rspamd-Queue-Id: 547CB1DA211
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 10:51:03AM +0800, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> When current->bio_list is non-NULL in submit_bio_wait(),
> submit_bio_noacct_nocheck appends bio to bio_list but skips IO
> submission, causing submit_bio_wait() to hang indefinitely.
> 
> Fix this by temporarily backup bio_list, setting bio_list to
> NULL before calling submit_bio(), then restoring bio_list
> after submit_bio() returns.

No.  Fix this by not doing something that is a bad idea.

> I've trimmed down the call stack, as follows:
> 
> f2fs_submit_read_io
>   submit_bio
>     mmc_blk_mq_recovery
>       z_erofs_endio
>         vm_map_ram

->bi_end_io code really should not be having random in_atomic()
checks that make it completely different, but even if they have
that need to use GFP_NOIO.


