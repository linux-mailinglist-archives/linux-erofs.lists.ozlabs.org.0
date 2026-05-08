Return-Path: <linux-erofs+bounces-3386-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCypMxmk/Wl0ggAAu9opvQ
	(envelope-from <linux-erofs+bounces-3386-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 10:51:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA744F3E7D
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 10:51:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBjXP3ncBz2xdb;
	Fri, 08 May 2026 18:51:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778230293;
	cv=none; b=dinRFP/GyGf6sSnOmCF6z+M1+qKg0Rw65dKq0cqlKp7Bwt1zizrgMZ7DTYYGupqZuNSOh47pLYXN2EHxdJVmhr8i3TTZFS+Q+Iad8WbNiKSrLStcMQA5vyY5Xdwx/S/9G2LdfOhabPqmR4cmp9vRfBcTmHQc+n0eNqVH0ax5IrDBHGU686Ds/ohIx4+cCR/KdJDCskTt9cWvsJBoWzcTM/TZsuVhwHZbAPyFSaSFM2tS/r3fNXpp8o+QJGOTelefzhBxqZfkALdBxnyq7eXKn+SwnoeEyC4FZAY9xX55ZhDriNCFPg5jy7fQXXISePFeH3Ffu7vgRWEHntq+8W5+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778230293; c=relaxed/relaxed;
	bh=LcfSJZunpJtJqEAQxYYrvSXwL2YMHDgM2lPYeKjOS/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PvNnRy+LTMXJ8md3sqAbkm3kyypUJ1fay3fZ3WSGFqmQeU1qH/OXui8HwmajUYYyXVhgPiyAj5cKosCHORGNTBzIJJIHKDa5w9MB/NtVfBcrUowMBeV0ZBQNvrK7wAVgf71ol/PkzyAMiOqTxS8b5jfHWWHrvR8/vT8uxOKqSPi+9hVKKUhKzt+b+7ep1CiBtJktGP0RcaMj/mBJ95DwTVAx6LoEPievYrS9GUZ5nJy78MIohUzgNDNpzRwxiCoM+IWOQFgEm3h9NnmQgYrb0yDtt/YEYO2IS5FoEvooFcp4p5I1srWEQutcuxUsYaC/OR9wo7PH2K1REgc52fCLnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zGAtW3//; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+b3031b5f6a3880ed22fb+8293+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zGAtW3//;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+b3031b5f6a3880ed22fb+8293+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBjXN4rfrz2xQC
	for <linux-erofs@lists.ozlabs.org>; Fri, 08 May 2026 18:51:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=LcfSJZunpJtJqEAQxYYrvSXwL2YMHDgM2lPYeKjOS/Y=; b=zGAtW3//ALZeGoDiZcqA0NDin6
	Djhl0G/b1v95JdQYdY+8UY0Qce0/tg97AmeovmSQrLGCLvdi6XREyBiKgEuAv83Dzg9xrnHTnO9ne
	56RvF/4mgtWuJdMqJ1EZW+/LvWQFgA4WY1XPA7olVpJsbr4UF2wY6MbtGV9qcJ06tsuZ9unJcBF2s
	QPzjXmYs0qREEEouylVWhDDXyBaOYryXfesTRed2xSAMZ0vVMjzX2oNxNWWUXQE1VGt+Uo9+NUmpC
	rG0rtqV5cUwFCQQ1YKmzRbJGsZuHs6i2qzea/allFxjq0g74gqOp9hII0t9oBgggcgK9ljb6rJ2T5
	NkoetzMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLGvd-000000062jx-1JiC;
	Fri, 08 May 2026 08:51:25 +0000
Date: Fri, 8 May 2026 01:51:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com, Carlos Llamas <cmllamas@google.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Tatsuyuki Ishi <ishitatsuyuki@google.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] erofs: use the opener's credential when verifing
 metadata accesses
Message-ID: <af2kDfHe0B3LnvVm@infradead.org>
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
In-Reply-To: <188c33e2-331f-4362-8475-b8cea7a8fe7d@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 5BA744F3E7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:hch@infradead.org,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:cmllamas@google.com,m:dhavale@google.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,m:ishitatsuyuki@google.com,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-3386-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 04:39:15PM +0800, Gao Xiang wrote:
> Currently EROFS file-backed mount metadata is directly using underlay
> fs page cache, which is mainly used for composefs, etc. to avoid
> different EROFS instances have their own EROFS page cache for the
> same underlay backing file and avoid unnecessary copies into them.
> --- That is also what composefs once did in their codebase.
> 
> Since EROFS just read the underlayfs page cache and does _not_
> touch anything inside the underlay page cache itself, so I guess
> it's fine?

At the micro-level this does mean erofs needs to do the checks itself.
OTOH it means this whole scheme is completely broken.  The page cache
is owned by the file system, so erofs can't simply poke into it.

Now for reads it mostly works on the most common disk-based file systems,
but it does create lots of problem for slightly more complex ones like
network/clustered or synthetic file systems.  It also really breaks
layering, so we need to fix it.  Not sure what would be best, but I'd be
tempted to have a cross-instance cache maintained by erofs and filled
using in-kernel direct I/O.  IFF the page policies work great for you
that even could be a synthetic inode/mapping.

> On the other hand, we talked a bit commit f2fed441c69b ("loop:
> stop using vfs_iter_{read,write} for buffered I/O") in another
> private thread related to fanotify, which lacks proper
> rw_verify_area() as well, since it called into raw read/write
> iter methods instead of using the previous vfs_iter_{read,write}.

Note that this does not add the bypass, just extends it to both I/O
types.  But yes, this breaks fanotify.  We actually have quite a few
raw ->read_iter/->write_iter calls, so this might need more structured
treatment.


