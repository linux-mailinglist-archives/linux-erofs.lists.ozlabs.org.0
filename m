Return-Path: <linux-erofs+bounces-2647-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C31IFAYsWn6qgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2647-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 08:22:56 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E48125DB24
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 08:22:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW2Jp6RMNz3f1N;
	Wed, 11 Mar 2026 18:22:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773213770;
	cv=none; b=bCjWiPEm8oCQkViVj8h6XEqwr68NTrYSTRN+Vbgn0my5FLSo8Y2TpW/8V1H85lRoTMD21SssV7RAOet0WdmWikhNbQU60lGx19EtbA9EP7sPpn7m9/bmsVlCYlV7d/xpA6KMMGEbeGr4XZVKbbypjsyIEslLSvfk5IlarjUf1PKlp4hB7L+cuvH5q4tCPNxB7sH5mmITApfxeBCz32LLW4jdFnPvmOWGxeElwd3PsAUtSAmTjbZG49WswJ6BopHfg3vP1tdfzQYp4JG7/nkwTZU8BLdfYEUJIuh6rava7nEaVPXWEqKhrdALh6/gWlkikqBdiyEawVCyOqrNABU2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773213770; c=relaxed/relaxed;
	bh=h4UATkvAR9zm+HaA+cOMgUi0XJPdsdisPxqrCZs41aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ek23Vi5nhwVtORd/wwVik59oxwx5Pd4NAFceXxLzrsmHL/GkZWAMdihKtn4bV3UscBs1zFDdc4BC5Uxa7wH5BDeQpYXeE87lBFSm30DO8arwq/NcHH6shECLtTFBglS+5qJpuE+aSjPY/TKVF33vi5oGiv5bqDXe7OiSKDuP4cwOqGp1B4xhBHnWMNQmHoaQEkD4GGJejQAYMSkm215a2Wk5syFkFx9dPspW2UJxu4dowASTBjqXVFEvLI1b90bxo0JM9AaxNhSSVOx2NJoA06UJViKvtmLieGCaeUfhvQmKFIYSwcMSXZfbzjpfR0JueZSlIEZuP7rqjZg0oWgrbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FVg0IDG9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+jiucheng.xu.amlogic.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FVg0IDG9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+jiucheng.xu.amlogic.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW2Jn6RFwz3f1M
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 18:22:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 506D140B87;
	Wed, 11 Mar 2026 07:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28265C4CEF7;
	Wed, 11 Mar 2026 07:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773213767;
	bh=m7ADRIW7RFYYIrjtqvF0zF5SCfBDetrXU5BeIzQ+buY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=FVg0IDG9cp9gRegQZJHQSa81Dzcj9wcTUxMGHJF31GuKzZ4ErzySrXl06pzTlQqGA
	 pHEIb4XPqbjNAzIzlGSB6tBqUoJfl2q0HhOCn7R6Z6i6XNZw/0UzX7iFZLZq8Qc9NE
	 b9kwzvZLOarnlEEjt5abJKKNp45GDReDvWvuZNt1XITbOtOhhuFZiAWww0wuC5uhJN
	 n2NZyGhRKTBWLZNEZVCSO6S8TqTZya18/EZUOviMa12skGn6Pzo9bf+AJezQhQkWlt
	 rNAA3LWJ1D6KxHHdenFrVZImIsdKiP49fUMdbh/BLNKvTL0w25tlE4nRA33pnbqNVK
	 qL9QUddvAXXJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1501CFD0648;
	Wed, 11 Mar 2026 07:22:47 +0000 (UTC)
From: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Date: Wed, 11 Mar 2026 15:22:34 +0800
Subject: [PATCH] erofs: use GFP_NOIO in endio decompression path of erofs
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-origin-dev-v1-1-40524ef07ff0@amlogic.com>
X-B4-Tracking: v=1; b=H4sIADkYsWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ND3fyizPTMPN2U1DJdw2RLMzNTc0sLIwMTJaCGgqLUtMwKsGHRsbW
 1AF5jXR5cAAAA
X-Change-ID: 20260311-origin-dev-1c9665798204
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 jianxin.pan@amlogic.com, tuan.zhang@amlogic.com, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773213766; l=1783;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=M0DxC1YSsNeUXU4lWpQgPmCwcDRu1aw6juBcKAOFoVM=;
 b=ugKwv1rm6H2qLye79IJSJ4l//Zmqe9nzUqXC6/9IrEJa+VRQ1DSlVFZTgzZXXk8PfbtMAiR1X
 pJ2N00kgkSRCJW4cJ4EGDTq+vIS5vsU2wTZkgsUJGoXqxxYaw/ekjFY
X-Developer-Key: i=jiucheng.xu@amlogic.com; a=ed25519;
 pk=Q18IjkdWCCuncSplyu+dYqIrm+n42glvoLFJTQqpb2o=
X-Endpoint-Received: by B4 Relay for jiucheng.xu@amlogic.com/20250821 with
 auth_id=498
X-Original-From: Jiucheng Xu <jiucheng.xu@amlogic.com>
Reply-To: jiucheng.xu@amlogic.com
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 3E48125DB24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:jianxin.pan@amlogic.com,m:tuan.zhang@amlogic.com,m:jiucheng.xu@amlogic.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2647-lists,linux-erofs=lfdr.de,jiucheng.xu.amlogic.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-erofs@lists.ozlabs.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	HAS_REPLYTO(0.00)[jiucheng.xu@amlogic.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

From: Jiucheng Xu <jiucheng.xu@amlogic.com>

The endio decompression path of erofs calls vm_map_ram(). Due to
insufficient memory, this function may generate memory swapping I/O,
which can cause submit_bio_wait to deadlock in some scenarios.

Trimmed down the call stack, as follows:

f2fs_submit_read_io
  submit_bio                      //bio_list is initialized.
    mmc_blk_mq_recovery
      z_erofs_endio
        vm_map_ram
          __pte_alloc_kernel
            __alloc_pages_direct_reclaim
              shrink_folio_list
                __swap_writepage
                  submit_bio_wait  //bio_list is non-NULL, hang!!!

Use memalloc_noio_{save,restore}() to wrap up this path.

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 fs/erofs/zdata.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3977e42b9516861bf3d59c072b6b8aaa6898dd8a..fe8121df9ef2f2404fc6e3f0fbbd6367f9ec2c67 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1445,6 +1445,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       int bios)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
+	int gfp_flag;
 
 	/* wake up the caller thread for sync decompression */
 	if (io->sync) {
@@ -1477,7 +1478,9 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 			sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
 		return;
 	}
+	gfp_flag = memalloc_noio_save();
 	z_erofs_decompressqueue_work(&io->u.work);
+	memalloc_noio_restore(gfp_flag);
 }
 
 static void z_erofs_fill_bio_vec(struct bio_vec *bvec,

---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260311-origin-dev-1c9665798204

Best regards,
-- 
Jiucheng Xu <jiucheng.xu@amlogic.com>



