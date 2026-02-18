Return-Path: <linux-erofs+bounces-2334-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKq6Gke7lWntUQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2334-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 14:14:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9763015689B
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 14:14:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGH6X37Rxz3bnD;
	Thu, 19 Feb 2026 00:14:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771420484;
	cv=none; b=OI29YRCAgmnQJ/mhvkcyPPzdC628rCGW11N/TL3Fxv+WQY8hY4o+rjbQ6OR+X6cmSbanjYzKkuUwBf+A1S1lpZJfEZYapkZYCFb43BPi2gNBnabrAn18YLJfjkmokgIlg8BH5M/3edMezvSB4OTCgzvS8VAouYXiYB9sgAkpEdVU1chcrRp6rxoK3hdHfSlF/4jK2c3bPBaFWSx3yRTP1t9DfsrPUKDVXUIqLVRIuF28CCY+wW1uaA+8F5XSax/GTS4ydbIMMSjtL67l+PWTjNq+cS6mjYzwaqSmwdaC4hdgksoni4dY55hyNyoxSFPAmOygmem94YIG83o52dENaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771420484; c=relaxed/relaxed;
	bh=R9o7B0XyRf4oxbZtrtwELk9VUK22k/bz/nbBOAn63to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNr3fk3ecOjONndgkL/FQUFiAYDVEsZ7tO3NefCOnfg1dQSyUslGHeSAiNaKUvPPRkUIvrMraVzmzJJ7hVBkj9CjQZK5XXYyi80IKjSAnVM+DhPGcFUUadUdgx0jbqOJXGX3G637VX2/xd8ohikwCCrgQioR7evDT1TgcVR7alfhV9mSGCNNy2+WuN5ZCiJaPKgOtJ1uI9qss0Ju5om4uFm8Op7ZdfsVGbiWay0f9KllX9PcmO124y4C6s63SwDpTsoLkYIa/sVqpCoY2ZF4JZAJIalQEWydD6O6ijX0Ls12QbFKTlAHgMo1uGQ42HkQ6YCisTJIl0MatlveS+NyWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aAwtVuj9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aAwtVuj9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGH6W2WV2z3bnB
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Feb 2026 00:14:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 36B8944497
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 13:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90A6C19421;
	Wed, 18 Feb 2026 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771420480;
	bh=bfKMXFcupLlPjIgRJunEY2tjDlC/CeYIZUY+LIxrNYY=;
	h=From:To:Cc:Subject:Date:From;
	b=aAwtVuj9qKo/zKtJ0ZZfZHg7ONlgoh89pCnsLk4MPsOjyh8zJjXZ5VWvGKDYwYrUn
	 pIE9t0ybbnfjRUGxNljhyllWr+UehBgVmj5c5jVqBSBOWf69UprtTY6LqRK3dqXSex
	 Qlx3j5JiMxdpCt2La4Y9aLc64Trx+cSZsy/JhE0yl5ndAsJzH9hZBKQeF6PI/I+NMQ
	 FojghEtivg22ZKWav+lcHR3BNiRXImyJBxUNZ7JK74sYQPyEu8PdSNKy2/wuQRTU8A
	 wT3Bb9GfLFANseBfmYP97CjckHJ84ENVgM1DO3M8iauzAHxV4JVFKLHHyNUVJSJsfP
	 fY8LriFR2AYqg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <xiang@kernel.org>
Subject: [PATCH] erofs-utils: manpage: fix installation of `erofsfuse.1`
Date: Wed, 18 Feb 2026 21:13:51 +0800
Message-ID: <20260218131351.46839-1-xiang@kernel.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2334-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 9763015689B
X-Rspamd-Action: no action

`erofsfuse.1` may be missing if `man_MANS` is assigned twice.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 man/Makefile.am | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/man/Makefile.am b/man/Makefile.am
index c951681..b9b5989 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -3,10 +3,12 @@
 dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1
 
 EXTRA_DIST = erofsfuse.1 mount.erofs.8
+
+man_MANS =
 if ENABLE_FUSE
-man_MANS = erofsfuse.1
+man_MANS += erofsfuse.1
 endif
 
 if OS_LINUX
-man_MANS = mount.erofs.8
+man_MANS += mount.erofs.8
 endif
-- 
2.47.3


