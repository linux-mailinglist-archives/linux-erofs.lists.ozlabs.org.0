Return-Path: <linux-erofs+bounces-3818-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OI12OKpkSmpmCQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3818-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Jul 2026 16:05:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC7270A3B3
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Jul 2026 16:05:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Rpp2pINF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3818-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3818-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtTlq49gxz2xYg;
	Mon, 06 Jul 2026 00:05:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783260327;
	cv=none; b=i2CFpQ9rTvKcYUR8SG1EX591bH+UNCb+YpGqFaZp8D+Q3s+8se07T/ma7xatzUaoO53/XnLsBlYHT/DuZEk44yTWlwedXah0y0l9GzFPHKSM7NM/+l9zIGEPXAc89hrF1kzWmW5667nAmVue9LgxiwM6N071iecbB2/Yn8avZJSa5Z19VN7Et+hI4bBkv4f9Ax8L41HRATAqmOCPwwwTZ6olxzoIi36IWoTZNuhB6/JAen0qINIVawyRyOZxLVOfK4gd4gqpEJHznOjWht1bf3YvpK01LIArr1UmWyjaCurfLJ74huHUkFLy/7tirHe2eaM9V3Lk+9WXm4flN2mh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783260327; c=relaxed/relaxed;
	bh=G0NjfVljOEEWZJcZg5KTJsfv4Azjyhvvy7CNeWkg5+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlUGkdn03qxy7J8ivw8c58iDOxJDFlL95f1m7bWlt8B0OBmel3VoKKWvXL14o9vZIoXjRLUq1UCZ6ZE4RrbvIRuTUDLobzIFqYz0GYfBdLzOAgpEAlheKezIszNXUKEKA115CmXKcl4xarAcscppmw7Jd1u0KV0HRt3/5f2lq/tvpCWBF1euV5gbdxkqTZnfh/TEkDhYjwGrBiJ/1fXcn25bZWY1jXptlO7Mnt+OieaQZHB3dfYSAXecP/8wTmdUVzqWXE/OmOisnQLWwxlKr8lMVwmsktKDP8/1+VCAc5+3ZNHeBJS6GEMBveEvlQmYlnWX9eDzkYXzAVU40kfjUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rpp2pINF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtTlp4l4Bz2xHK
	for <linux-erofs@lists.ozlabs.org>; Mon, 06 Jul 2026 00:05:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E523161389;
	Sun,  5 Jul 2026 14:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A281F000E9;
	Sun,  5 Jul 2026 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260323;
	bh=G0NjfVljOEEWZJcZg5KTJsfv4Azjyhvvy7CNeWkg5+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rpp2pINFf0EpqsUwDEpLERYgmSx4SxFt/tI+Hil0ZKUOOlwr6sXwju2X6wzEqHkhO
	 i5EU+sW+eiRxN7/T0pr8EzUVA+9Ad5DBwFvJYOSwPcdMNtz+9hR+O5E/sN3alGex3u
	 cS3+id6lHb5rcez7PrnZvKcJsqn4ut7tdT0Yxms7JBFatLdRkLRKtlTBsPwvapWZQn
	 a81mB+fyaGet187U7IVyK6dpEtRk0PbmKHULjD2M0H03yOzGILk/jjkgpXDh3Iy3mn
	 rGXzeiW/s4t2sE7nrn4tARzKbwtaXOxixscnf6Yie/wMWCTR375Dh0lqeN32fA+7ZQ
	 sKrj9odYct5dA==
Date: Sun, 5 Jul 2026 22:05:16 +0800
From: Gao Xiang <xiang@kernel.org>
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	xiang@kernel.org
Subject: Re: [PATCH 2/2] fsck.erofs: implement concurrent directory traversal
Message-ID: <akpknJC1zDTfE1I6@debian>
Mail-Followup-To: Nithurshen <nithurshen.dev@gmail.com>,
	linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	xiang@kernel.org
References: <20260621120121.73114-1-nithurshen.dev@gmail.com>
 <20260621120121.73114-3-nithurshen.dev@gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260621120121.73114-3-nithurshen.dev@gmail.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3818-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AC7270A3B3

On Sun, Jun 21, 2026 at 05:31:21PM +0530, Nithurshen wrote:
> Currently, fsck.erofs traverses the filesystem tree and verifies
> inodes synchronously on the main thread. While decompression
> compute is offloaded, the main thread remains a bottleneck
> during the I/O-heavy directory walk.
> 
> This patch parallelizes the directory traversal and inode
> extraction processes. To achieve this safely, the globally shared
> fsckcfg.extract_path and fsckcfg.dirstack states are decoupled
> and localized into individual struct erofsfsck_inode_task
> payloads, which are deep-copied and handed off to the worker
> pool. Global statistics and hardlink tables are secured using
> native erofs_mutex_t primitives.
> 
> To prevent thread pool exhaustion deadlocks—where workers
> processing a deep directory tree occupy all available execution
> slots and block on erofs_cond_wait, starving their own spawned
> decompression tasks—this patch introduces a dedicated
> erofs_traverse_wq. By isolating the producers (traversal and
> verification) from the consumers (pcluster decompression), the
> pipeline avoids gridlock.
> 
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>

I really hope you could parallelize the inodes in a single directory
first, and get a minimal commit and show the improvement.

And try to improve parallelization between directories.

The priciple is to keep each patch small so that it's more reviewable
and has low risky.

Also it seems that you could make mutex protection in seperate commits
too so it's also easier to review.

Thanks,
Gao Xiang 

