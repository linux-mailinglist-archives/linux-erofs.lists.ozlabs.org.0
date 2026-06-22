Return-Path: <linux-erofs+bounces-3716-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EJl2LBJROWoOqgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3716-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 17:13:22 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6B6B0A08
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 17:13:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="K/V1Z2hh";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3716-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3716-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkWt65QB3z2yVZ;
	Tue, 23 Jun 2026 01:13:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782141198;
	cv=none; b=bCi/TmdBRCgBCGaZ343grq+BgPQnJDVzcR4l5EN4JMD9Bzqs3P9pajtOf9gNvSTw1OotNj/O3fRHXIP44+negHPp/RShnGeyw+rVh663To7/XCWBP7fo1QJ3F3vJSC6OU1L4+748sjlJTa4ySlO4ehPsLmSx4jMP9dgSqmyD3x7sXysWU/TJn+qwaO3nASE43n1W5KM+D47tx8vOjpbiEhqk6fvtPjWdj0B318dT5GLxu9ATTsE3FIfKewXhkIsL6jsSf5kQP0pRrYgPpLg/3QRjTcfg6rjYE9LRvHyKFvaexs3gqjQRkMxAN3z1HMb9oldPreUEEvJ9N70cRSrqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782141198; c=relaxed/relaxed;
	bh=T2jW4l/fJrbfv9Ss+G416BdWermJV6II77JXcY0a4Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fOAdhlZE7L3CScTun5jtCDurPyg/lnyWmLws0Pp/Ib7A1LUH7YS1t4HywkSKqT18sBsXYInqCkZCRpwmFjO5W3kEtT3R/uAjPSICI8qSe+DAiyGRRlzgGFG2/KVVuiRpqUH5qDMZXbXEXIMdKF1qr+D+h1fiKy3xKDC7O1vnXdsTOxRGdXSQMxj0l8wvbA5v/yofR+RX2UU2qpUZxmgqkTtmCAbbSDM7o+mrp1CbIEOju+aBi5eqmT6uYZ37ncKhXSmVg7Gk9j5qEbHSDwYvDYZPQNICQalnmwxP28S5lMcSfdrT8OPJsabs4KpDIbCArr2v5xDb0WrXdZ3YwPSLsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/V1Z2hh; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkWt547NVz2xl6
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 01:13:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1E17E4338B;
	Mon, 22 Jun 2026 15:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7886E1F000E9;
	Mon, 22 Jun 2026 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782141195;
	bh=T2jW4l/fJrbfv9Ss+G416BdWermJV6II77JXcY0a4Ag=;
	h=Date:From:To:Cc:Subject;
	b=K/V1Z2hhCSUkLtZK3OWFKD/OJNNUisbP4555e3jVS4L2Xdnupn9Yihhjn9IEc1H6x
	 d1r5TpkkaLL7PD27NjeSb+wFQrkj/pHhFHcWVaGxkFQpRPVfiJKTl9yzWT7HYEHUSZ
	 W+J33IFbgsJPauMkfZr3q+WIduQI1z8WugrbvF1dXVFOw0LniqQ9M8YMlSrZnVct9d
	 Ziub20HkdpiOVACKZ+lyZAipojsPZKaegecwf+tOoj/ZMFlmyzDHjWPNJwRt4YW5qO
	 vofeih8B4ZqeKEmVavcYtRFWkeSl/9d3n+iXbHVp1Vep1lBu9E0CipzddWVOuz/5tg
	 jFSvbjiw5L2Hg==
Date: Mon, 22 Jun 2026 23:13:07 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [GIT PULL] erofs updates for 7.2-rc1
Message-ID: <ajlRA7jYcsnYPXiw@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>
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
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3716-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:chao@kernel.org,m:zhanxusheng@xiaomi.com,m:lihongbo22@huawei.com,m:jefflexu@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23E6B6B0A08

Hi Linus,

Sorry for late email this time, but could you consider these
commits for 7.2-rc1?

The most notable change is the removal of the fscache backend: it
has been deprecated for almost two years, mainly because EROFS
file-backed mounts and fanotify pre-content hooks (together with
erofs-utils) now provide better functionality and simpler codebase.
In addition, fscache has depended on netfslib for years, which is
undesirable for EROFS since it is a local filesystem. More details
are shown in [1].

In addition, sparse support has been added to the pcluster layout,
which is helpful for large sparse AI datasets, and map requests for
chunk-based inodes have been optimized to be more efficient as well.
There are also the usual fixes and cleanups.

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20260622013622.934174-1-hsiangkao@linux.alibaba.com

The following changes since commit 4549871118cf616eecdd2d939f78e3b9e1dddc48:

  Linux 7.1-rc7 (2026-06-07 15:37:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.2-rc1

for you to fetch changes up to 803d09a554055aba160a62abd1e4b1260b899dc1:

  erofs: handle 48-bit blocks_hi for compressed inodes (2026-06-22 18:50:36 +0800)

----------------------------------------------------------------
Changes since last update:

 - Report more consecutive chunks of the same type
   for each iomap request

 - Add sparse support for the pcluster layout

 - Update the EROFS documentation overview

 - Remove the deprecated fscache backend

 - Various fixes and cleanups

----------------------------------------------------------------
Gao Xiang (7):
      erofs: clean up erofs_ishare_fill_inode()
      erofs: update the overview of the documentation
      erofs: call erofs_exit_ishare() before rcu_barrier()
      erofs: introduce erofs_map_chunks()
      erofs: add sparse support to pcluster layout
      erofs: simplify RCU read critical sections
      erofs: remove fscache backend entirely

Zhan Xusheng (2):
      erofs: add folio order to trace_erofs_read_folio
      erofs: handle 48-bit blocks_hi for compressed inodes

 Documentation/filesystems/erofs.rst | 138 ++++----
 fs/erofs/Kconfig                    |  21 +-
 fs/erofs/Makefile                   |   1 -
 fs/erofs/data.c                     | 135 ++++----
 fs/erofs/erofs_fs.h                 |   2 +
 fs/erofs/fscache.c                  | 664 ------------------------------------
 fs/erofs/inode.c                    |   7 +-
 fs/erofs/internal.h                 |  72 +---
 fs/erofs/ishare.c                   |  47 ++-
 fs/erofs/super.c                    |  98 ++----
 fs/erofs/zdata.c                    |  38 +--
 fs/erofs/zmap.c                     |  33 +-
 include/trace/events/erofs.h        |   9 +-
 13 files changed, 231 insertions(+), 1034 deletions(-)
 delete mode 100644 fs/erofs/fscache.c

