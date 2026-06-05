Return-Path: <linux-erofs+bounces-3517-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qTPgGpIcImpTSgEAu9opvQ
	(envelope-from <linux-erofs+bounces-3517-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 05 Jun 2026 02:47:14 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6E2644275
	for <lists+linux-erofs@lfdr.de>; Fri, 05 Jun 2026 02:47:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=krw6T2ND;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3517-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3517-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWjSb1Dkmz2yRM;
	Fri, 05 Jun 2026 10:47:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780620431;
	cv=none; b=f8bgiTXkeDaYujlQlE5i531/y6Xdc2/psbGEsYm+w0X6rccHqNMWJa2tqQNMI0IzA6c4RbCPQLx+jrgHDAP4wW7X2cBUoaYeZCS3imWjKD+ONf0K7pqqarlDfTWCUcF/faVHYMl6uiYoppTglBmC64zpPoQwyH1Wq6OL5zo1v/kRbpYC9QdO2Qjd0IEKp0UABMp8kkzkTnYw4EPqfW82LTonjlyIp9AdjSSzOwOFZFLhIj7QSl3knUVvBpbg9/j9oAiHwLipvpSA0O5e15P9YwOFNCpuGHeeh1vjzy7IEteFngWA81i+P7SrZs4w7hzsCE+yAtWiGXbNI/1A0MMHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780620431; c=relaxed/relaxed;
	bh=c49VL7uKw8so2+cIv/ola1Te+aFfJDXx7mZr68ECfAg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hCsG2S0ckZFvTBerDBLpwc/QcHOnlKId0Gwu4rzL/iV0hvT58LvoEO0OLPN2jwE2ngN7kCwzO80n4VdRrchxgWfjs1oIM/ZyN+bS0TDmC2nz3HGYK2iEjEXoPkel3bc2jxfAlFzvgP9LMnDlg7mWJJaKqu7O1NXpKTEWFKlKmGnJTStOiyoZ+Qu48rjRQwABfi7VQRBuqHc+GqZXWYuncQsiKjlfGxWCAAnFRAsiBN7iqIbWAbX/4QZ3kmfudtg/r8EZIueFaD3uNQzhc0R56nwpK/tTSCquk5tofTWDIG65pk2/hF6D3NlCy6GIX9QbSRtV6Istq55Ir6vzapFjxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krw6T2ND; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWjSY6sjXz2xR4
	for <linux-erofs@lists.ozlabs.org>; Fri, 05 Jun 2026 10:47:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AFFB86001A;
	Fri,  5 Jun 2026 00:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939991F00893;
	Fri,  5 Jun 2026 00:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780620427;
	bh=c49VL7uKw8so2+cIv/ola1Te+aFfJDXx7mZr68ECfAg=;
	h=Date:From:To:Cc:Subject;
	b=krw6T2NDPX/TFtfQMb3CKhb0XRPXMst7L4T5FQ6eeF9eHxFT5mqxDmXPfsgehqPlZ
	 iCK5Q7DMF59BwDrqDRIEhmg6/1ZMyqyK5VNwN0eKZAcl8YPy3GDGZinOiwXwNX2Y8J
	 5+uYGoLyDBYP/eTLLIPEb97QITQZZv7QvCH2lQ8t6ea5F7wGOITvVnSJ3QD3ohxZ0z
	 YdTz4olfbyQKbjzjpzYm73yjW4UmmyO4jX2bfU2S+SVsjcJM2u+lf6vmTYt1nBUadp
	 7mLU9qRtuWacvT7AWgVSA9lVKNq9hvgxF6aMFAfWRjzAx2vRZcxeVIQwJNl8PFkO2W
	 vv0A1Fnruf1bw==
Date: Fri, 5 Jun 2026 08:47:01 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Jianan Huang <jnhuang95@gmail.com>
Subject: [GIT PULL] erofs fixes for 7.1-rc7
Message-ID: <aiIchc5EH5GPU-UW@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Jianan Huang <jnhuang95@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3517-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:chao@kernel.org,m:zhanxusheng@xiaomi.com,m:jnhuang95@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,kernel.org,xiaomi.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[debian:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B6E2644275

Hi Linus,

Could you consider these two small fixes for 7.1-rc7?

One fixes a regression introduced in this development
cycle that affects multiple-algorithm filesystems.

The other fixes a narrow race (but found by syzbot
these days) between compressed I/O completion and
unmount.

Thanks,
Gao Xiang

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.1-rc7-fixes

for you to fetch changes up to 27f2d085bd72abe4235689d34d8654cfc876d568:

  erofs: fix EFSCORRUPTED on multi-algorithm images in z_erofs_map_sanity_check() (2026-06-02 01:52:58 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix a UAF of sbi->sync_decompress when compressed I/Os
   race with unmount

 - Fix a regression introduced this development cycle that
   incorrectly rejects multiple-algorithm images

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix use-after-free on sbi->sync_decompress

Zhan Xusheng (1):
      erofs: fix EFSCORRUPTED on multi-algorithm images in z_erofs_map_sanity_check()

 fs/erofs/zdata.c | 6 +++---
 fs/erofs/zmap.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

