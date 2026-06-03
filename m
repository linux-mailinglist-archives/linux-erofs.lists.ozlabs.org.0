Return-Path: <linux-erofs+bounces-3513-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JBNGLjovIGo+yQAAu9opvQ
	(envelope-from <linux-erofs+bounces-3513-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 03 Jun 2026 15:42:18 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F256382D4
	for <lists+linux-erofs@lfdr.de>; Wed, 03 Jun 2026 15:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kkHGJzvF;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3513-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3513-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVplp5hh0z2ySJ;
	Wed, 03 Jun 2026 23:42:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780494134;
	cv=none; b=bBYPrvQQ7rxJCA/eL80RFjlStqM4EzhiaKMF8iFs8l6PYn6kwBSM3sEJYQpOZQguVjz5HLIfNJSdpA/inv22LShCllyQkxVKURYQtiZEj/7qmTMsn/tRwhk0zliEyynb/VpzblGykBu/UkGfaULukxpQB3I93y0feSl9pd/GfBhAQ0eT8yxrK7l0xvPwtam3b2JU1zG9ssHA/n5AQfk8lBHvkwXxbw90GCLwgt+JJiojHCl7rTZkPkcjGefWDOV4tyM5cNIiEpK+OeOWSO/CCqRGI98dQXWmVpbC7RNyGs145v8ooIMWjL7QBfRxoMu4J6I3IvteyLqAFSDx+XVFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780494134; c=relaxed/relaxed;
	bh=20NIHqWNkYzNtWsw5gcXIpkfj7VXIC9slkxS6qDvrqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7zjXoNeVrKuxX9sdkXI3Gs59cDtQFPY6LVgYd6DpmqmZCorECNh5LCB8Ws6zCswQ6CWf6391Hi/Z3ycJs8EwEDCKMEZ1bUU+Jwz9snmfsu1MtdXUxjqE6Jgq6pfT3TmTq0FEvyYvg9+U2i42c+8lQIZap+z/ROeKlxl6u4cMUbdA0Z8OqaNDiZwGFIPmGqtDN7pc18gdttO3Pr8UPpB64tJsDYgDoFjFT/j0Inlwy1vPoqXnkVCWBLVLooYqeIS/2H5BmtXR3kxn0IcC3la2z5yXfMgv0F4txDfZ2uDIvwW7H9ERDgqKRK9wsxlzuQ1yzNwWIybzYnoZDU+m42BYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkHGJzvF; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVpln6jSsz2xMQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 03 Jun 2026 23:42:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BDFD742A44;
	Wed,  3 Jun 2026 13:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F8C1F00893;
	Wed,  3 Jun 2026 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494131;
	bh=20NIHqWNkYzNtWsw5gcXIpkfj7VXIC9slkxS6qDvrqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kkHGJzvFmAwfe3z2sRaxyWOciskIY5l8XO36H8XCn7X5GWfWbSBONcHL3hBYcW/gY
	 ZlqPSY13HQrlaQOmPDtp35fUJLoonxsA9tJYNvzbrqbhfD3CFuDndt7/P6fdcBhamn
	 XgXphrAI0uEyeDchylT4q46uU76+EIBZTAR8mBPW/a4pifkUFt9gqDWjnbzsrvbSgg
	 G76X7bKtjuPCY+Lfmw6SN7GU01neZ5VaSqQSXKKxdaBZ5Y1znFYNcEYK3ODCsorEO0
	 M4H/hTOFuTRLsflTDrUSEfNcd4ZzTlc+om3ghi5m8D1Ly+p3ITZcQyXtaDPJFhXkhL
	 OBM8VgOGRJ8EQ==
Date: Wed, 3 Jun 2026 15:42:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH RFC 7/8] erofs: open via dedicated fs bdev helpers
Message-ID: <20260603-nieder-ausdehnen-siebdruck-aa96f40ebec6@brauner>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-7-bb0fd82f3861@kernel.org>
 <7c5bfcf0-36a3-4cc6-bf31-6af4fc901c37@linux.alibaba.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c5bfcf0-36a3-4cc6-bf31-6af4fc901c37@linux.alibaba.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.30 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3513-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:hch@lst.de,m:jack@suse.cz,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79F256382D4

> May I ask if it's an urgent 7.2 work? If not, I could

No no, it's way too late for that this cycle.

> make a preparation patch for the upcoming 7.2 cycle
> to handle erofs_map_dev() failure here so you don't
> need to bother with this in this patchset.

Sounds good. I take it you can just do this yourself without me.

> I will seek more time to resolve the recent todos

Thanks!

> yet always intercepted by other unrelated stuffs.

:)

