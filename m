Return-Path: <linux-erofs+bounces-3471-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NmMCqT6DWrO5AUAu9opvQ
	(envelope-from <linux-erofs+bounces-3471-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 20:17:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AB625595B79
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 20:17:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLKWM6Cysz2xqn;
	Thu, 21 May 2026 04:17:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779301023;
	cv=none; b=XQK+anewcgzRniViBkcJai/mEdj4UE6TYuVyNsCzPXhmP99IMa9XSuzgVhA4KVc41mib2BJFVF5YBhC6OEfxMJKUxbxMyxgo/OgK/RTwLM8kOmyQL813b9WculXzWovQscdEDwo7xrevLPlSu6dRQEpETAtGaFC7yOJGFBbq8bPcqVC9S/WUxUhdEdpVqPej/FXD6B1H9LQ1niknTPhtUwt3ZNAWpyNwQTLpd+UUS3PlxhwxGIjJSjVZP5I540gWCjeHcciH+TQs/dYXnE6W4f1g+gGofllv1z+zydfTLxxdQ/RGV7USDKVhmZ8WxKqX3muB5EGAu1NLzbMxM1WorA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779301023; c=relaxed/relaxed;
	bh=VSJu+tCWgnjTv5flT5BvhQpTydl8nUd92HKG/PI/z9E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CZyad9mTG8HndIINNlaBpb0UDbvxT7GtC0xU4u4EBGeOAxnw2lTdWN8+4f+FE8zUGz6PjFnpo/Z85xWeisAzXVsxyz+AxcTnlI8PLORw+5E+N7m+LZ6hD4RACcd0q6xHwWpVMIJtKe3+zm/O0WbNu8SHLlNWVzDqQhFotbArDYguoY8/0AeWkMdTtdT1K5XncrYeJYq4VPIu3hGEoM+hL8P3GPq/D7XgZLR5utK12iNA5EcutYDfbjZ72mbDHggpNBZw+C87tAWAz4C6+0pF2EfF3QR4Conn15ZFkwXVAM+HcTfloj2/uroP1jJ8AEe47+lxUl8NdTvinq0Yg2f7+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R2snVzjo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R2snVzjo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLKWM13T6z2xqJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 May 2026 04:17:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F0F28417B2;
	Wed, 20 May 2026 18:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB1E1F000E9;
	Wed, 20 May 2026 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779301020;
	bh=VSJu+tCWgnjTv5flT5BvhQpTydl8nUd92HKG/PI/z9E=;
	h=Date:From:To:Cc:Subject;
	b=R2snVzjo6eUUA17oOZ8cxXTFV4VDtXsvC87jQc2is+0GGXy9knHskvrI11VaEoOIp
	 0MyL2GrB8XbPuGClDEvxITeZUaCMl1PSmGfpMqlD1eyNjrXCcT3DAHez3GPzsOBDTo
	 erU9z6cTrvm9Ukbu3IxM3eGGMpwVvcudhl1eF9gmyG0TWE0cWD2FuCgWhb1sIw0O3a
	 ncUGurCp/ReK4FvEFc0TFsWK39mGncayyn3GL04ykrczb6b+hBJ4GrNP4XxTswzGgz
	 ngZwADzgNIvZXemEF/61wPbSmcIH/XhupVU4KhZmDgE/2gJYygF0yfWA0xXRRap+VK
	 mEjReNveDkzAw==
Date: Thu, 21 May 2026 02:16:55 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jia Zhu <zhujia.zj@bytedance.com>, Chao Yu <chao@kernel.org>
Subject: [GIT PULL] erofs fixes for 7.1-rc5
Message-ID: <ag36l_9ijbXM_fgx@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Jia Zhu <zhujia.zj@bytedance.com>, Chao Yu <chao@kernel.org>
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhujia.zj@bytedance.com,m:chao@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3471-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: AB625595B79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus,

Could you consider these fixes for 7.1-rc5?

Two small fixes address issues reported recently and all commits
have been in -next.

Thanks,
Gao Xiang

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-7.1-rc5-fixes

for you to fetch changes up to 79b09c54c6563df9846ca3094bcfd72082c3e1d7:

  erofs: fix metabuf leak in inode xattr initialization (2026-05-20 14:53:14 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix a kernel crash related to unaligned zstd extents

 - Fix metabuf reference leak in shared xattr initialization

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix managed cache race for unaligned extents

Jia Zhu (1):
      erofs: fix metabuf leak in inode xattr initialization

 fs/erofs/xattr.c |  4 +---
 fs/erofs/zdata.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 10 deletions(-)

