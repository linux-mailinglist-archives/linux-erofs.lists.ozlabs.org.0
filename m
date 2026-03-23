Return-Path: <linux-erofs+bounces-2955-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONN5KnVDwWnPRwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2955-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 14:43:17 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF602F3305
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 14:43:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffZB94vPCz2ySB;
	Tue, 24 Mar 2026 00:43:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774273393;
	cv=none; b=agJQUbvgRyOhv0Q8H9KHrL7FuznSQkAufdqXyeCfz6gVQEehnOQVX8wbuBgePNnHfeqSs3gysHUFTx9oMYm/Ufi0PE9ot+XrEjeNuUdfAIUGIZUa/ji2MvyRVfy435GQRN4Duk2Acu4ljmhMPtHCd1cB0GOUdUiP0Z5WNtG3TfNGZSEZfBi40NTBGEdpEIQyajEDmXWtTJ8rlMTZir8XR+PEHcDtiAFszIeFrU7frMP549NQ9hgBTKisXQoApqfVRanCHTz/2fDlN/NyV9WUGqeuY6xoKZof8XvBOBhTKrtDfPu8nwoIpILhAxWBEPBUcJTfsdwaNoK54c+pHwOfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774273393; c=relaxed/relaxed;
	bh=a14i+KVu8vDaMR7GMVnZyoNHNYvWHIAgqQ0/zlIqH3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmSm6umTh9m2164lrNmVjsx0pJNATWVGmOQTGYUmUELNeESWeLR2oYsDULy+Lvex/lGGpXhrXXxdDYnR8Ebnor8y0k4cym4gXEWqb16ZhqzwmwWKMNyTaf/2RUJnumILx7s4xO1H5Q9m/JzqfBa8SXzEDxPMX+wEa5fYrezBLQFTSIOOGbtBbFAvhj46VE8SUdcEuBfm4jVam0gzX9MNTpdbUztx9N9ldPRlQ7BtlC/uInB8YGudvaYfRUXDg66bhrBPteYdhtFc62+RqAV2L2v8rvL98s7dRiMFGuRWyVhLJbbSL5lW335rmN1F3stFpXUs3iqjoXEJUVajYToPzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mQ/vHnTI; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mQ/vHnTI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffZB902wmz2xs4
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 00:43:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D1544380B;
	Mon, 23 Mar 2026 13:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F782C4CEF7;
	Mon, 23 Mar 2026 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273390;
	bh=ELGN7+2FkkSaWxcngu7PqeaKwb7oORMOp5q3h9ev+yE=;
	h=From:To:Cc:Subject:Date:From;
	b=mQ/vHnTI+5/ocVZu6/DtuwXC+ncf1aOx9n2EGhd9s8JOCYBpx3jZ4FU7FBdkG1NEg
	 Hv7bZh10/m3KVXApZGmRD9i8n1Y38nFSheL6GewYYbACh7Swd+Woc0Y73XxEqfigNe
	 aXOZcA5jtEp7uMjenW2EgAnA2Rja1VI0qYtWl9ShCwlWNBImzKCnqR7McnoSOGsHJX
	 EMs37+qPjjVmq4JTrRMadUQqBwj7QBYucwAvXiSfP2k8CVE+AOVqIC/SSPbp6pcq2F
	 lAatED/aKy75MDEjuK4dIEistVg+hEUaPMbw9/o2tRdZvD+1w6uywtF0xHb7xx5Ss5
	 F+6Z+ItqtSIYQ==
From: Michael Walle <mwalle@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org,
	u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/4] fs/erofs: major alignment fixes
Date: Mon, 23 Mar 2026 14:42:16 +0100
Message-ID: <20260323134305.2675822-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2955-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[mwalle@kernel.org,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jnhuang95@gmail.com,m:trini@konsulko.com,m:linux-erofs@lists.ozlabs.org,m:u-boot@lists.denx.de,m:mwalle@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,konsulko.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 7BF602F3305
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Throughout the whole fs code, large (4k) data buffers are allocated
on the stack. While it is not nice, to allocate that large buffers on
the stack, there is a much more fundamental problem: it's not
aligned.

This will result in a huge amount of cache misaligned messages on
arm32 SoCs, e.g.:

 CACHE: Misaligned operation at range [x, y]

While this is more or less a warning, as it will only invalidate
surrounding data, DMA is more of a problem. Some DMA controllers
have address restrictions and because of that there is
ARCH_DMA_MINALIGN. Thus as a first fix, move all the data buffers
from the stack to the heap with proper alignment.

There are still some misalignment warnings. I've traced it to
fs_devread(). Most of the calls to blk_dread() will pass an aligned
buffer. But the main blk_dread() will just pass buf, which might
have previously been advanced by readlen. Not sure how that could be
fixed in an elegant way. The simplest would probably be just a
bounce buffer, which there is already one in blk_read() if
BOUNCE_BUFFERS is enabled. But I haven't managed to get that
working. And now, I'm running out of time.

Michael Walle (4):
  fs/erofs: align the malloc'ed data
  fs/erofs: allocate data buffers on heap with alignment (1/3)
  fs/erofs: allocate data buffers on heap with alignment (2/3)
  fs/erofs: allocate data buffers on heap with alignment (3/3)

 fs/erofs/data.c     | 125 +++++++++++++++++++++++++++++---------------
 fs/erofs/fs.c       |  14 ++++-
 fs/erofs/internal.h |   5 +-
 fs/erofs/namei.c    |  47 ++++++++++++-----
 fs/erofs/super.c    |  40 ++++++++++----
 fs/erofs/zmap.c     |  61 +++++++++++++++------
 6 files changed, 205 insertions(+), 87 deletions(-)

-- 
2.47.3


