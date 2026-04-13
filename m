Return-Path: <linux-erofs+bounces-3285-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G73AYx13GnYRQkAu9opvQ
	(envelope-from <linux-erofs+bounces-3285-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Apr 2026 06:48:12 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB03E75A7
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Apr 2026 06:48:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvFK15RdQz2yYs;
	Mon, 13 Apr 2026 14:48:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776055685;
	cv=none; b=K0EeBUt/2VSLdJ8X3YzeWWWRV43MYAzIV/wSD6kxg0iy0GRTKU8RK4KAZzMoliuxhhYUjx09LZ9mc3noaalVUoNoQRBg74VYU8wtQEZr4Kjtcr87FJDvvC4JTye7RjnB7xHr7TS850rK+HVbN7HteDz+i5Mr7ALupYAlzLc8DKc+CwmvyNpzEdTcE8v55FUt68CE7H726MMWcGHIpRPwv3KwAIxhMa7A7GDC7ZotrvztvGnH66BTXi6k9bk/MZix9HUADjQp9sCRbXV/PutFrCzv6MhhYxYh/8ZnfjAg/Gk4UzBQ+CE+0kJDh2Pnpad5Clu2zXv1Jhj2UlO4Jp0r1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776055685; c=relaxed/relaxed;
	bh=dgGYw8Uqx8jDf//fuL/HE6l5yZ7dPjm6KPUHzqfZm6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NJm3J21zzyl/VhBt+r/pfH+ibdUkjm1i+Viev1ZrGUuY0lI3r5KS7T5CiwHpnNTCO+faYH9hcQ6+yM3n04taL1WqJpGWpvMK+eE8C4XFX4JPbUACvhx9dCZquBEIrfuDPzARtQv/4hJd/btlMl54OaekA6P3Eo0n4jGGZFE9H0DzJjWEZb/0cXV1heIhWhwjQqJqcD3nbUeLgsXuhpLG/+udFvtiBL9FUVxhZhPgUwlG89nW2XT9pkkj5ZRqmEGUEnVl5Pgde53zYTMOTxhfwXJv1Fz82Arc8XC837PYvW3GUKldyS+ILbndYVyWvvGBNboudMV1AXlsvrE277v3Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hqGmO32p; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hqGmO32p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvFK03XQkz2yFc
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Apr 2026 14:48:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4974660180;
	Mon, 13 Apr 2026 04:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1281C2BCB0;
	Mon, 13 Apr 2026 04:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776055681;
	bh=12eK+PZixYCIBpa4EXDTXgXPRu+6gqKx9Spidnb4Xyk=;
	h=Date:From:To:Cc:Subject:From;
	b=hqGmO32pYFiVxzMLjtGHQqgsL6/8EgtG5pTFF8QSkcNSPZ2htdZOYEjoT7kwp1g18
	 vPp2tY4HXeUCaSQ6BWRV6jMCzAt+Yv2/Al9ltIUc5Hp6nTH9JK9RzXGycrbc86TH8g
	 gM8vvuo9QpzHBlpHnBNBwj7k+t6cWjOkAaTPBhGmmpE68tTqYDqCZXCOOJlBAWNmzV
	 eHgMu9eZHuiOOj0YnQ16Q545+xEySLeB0CaEoCjaFLupLhF5BWG7tTumafwqRMsHMt
	 7ZFie+S3XwkNeo3rp4i8rHcWFB/nHHsVCKuaOP3eFYnVZVcXwNKdZ9jfODp40uExEF
	 aJpoJ7eTRkhSQ==
Date: Mon, 13 Apr 2026 12:47:49 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] erofs updates for 7.1-rc1
Message-ID: <adx1dXEp8xyWwgZ2@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3285-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B2FB03E75A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus,

Could you consider this pull request for 7.1-rc1?

No outstanding feature for this cycle and there are small random
fixes as below.  No potential merge conflict is observed.

Thanks,
Gao Xiang

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.1-rc1

for you to fetch changes up to a5242d37c83abe86df95c6941e2ace9f9055ffcb:

  erofs: error out obviously illegal extents in advance (2026-04-10 16:53:39 +0800)

----------------------------------------------------------------
Changes since last update:

 - Validate xattr h_shared_count to report -EFSCORRUPTED explicitly
   for crafted images

 - Verify metadata accesses for file-backed mounts via rw_verify_area()

 - Fix FS_IOC_GETFSLABEL to include the trailing NUL byte, consistent
   with ext4 and xfs

 - Properly handle 48-bit on-disk blocks/uniaddr for extra devices

 - Fix an index underflow in the LZ4 in-place decompression that can
   cause out-of-bounds accesses with crafted images

 - Minor fixes and cleanups

----------------------------------------------------------------
Gao Xiang (3):
      erofs: verify metadata accesses for file-backed mounts
      erofs: clean up encoded map flags
      erofs: error out obviously illegal extents in advance

Junrui Luo (1):
      erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()

Utkal Singh (1):
      erofs: harden h_shared_count in erofs_init_inode_xattrs()

Zhan Xusheng (3):
      erofs: ensure all folios are managed in erofs_try_to_free_all_cached_folios()
      erofs: include the trailing NUL in FS_IOC_GETFSLABEL
      erofs: handle 48-bit blocks/uniaddr for extra devices

 fs/erofs/data.c              | 14 ++++++++++++++
 fs/erofs/erofs_fs.h          |  4 ++--
 fs/erofs/inode.c             |  2 +-
 fs/erofs/internal.h          | 23 +++++++++++------------
 fs/erofs/super.c             |  8 ++++++--
 fs/erofs/xattr.c             |  8 ++++++++
 fs/erofs/zdata.c             | 22 ++++++++++------------
 fs/erofs/zmap.c              | 43 +++++++++++++++++++++++++------------------
 include/trace/events/erofs.h |  7 +++----
 9 files changed, 80 insertions(+), 51 deletions(-)

