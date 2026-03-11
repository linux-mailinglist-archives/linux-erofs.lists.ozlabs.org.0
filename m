Return-Path: <linux-erofs+bounces-2656-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGevG8wxsWm0rwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2656-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 10:11:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98A26010E
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 10:11:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW4kJ2QLfz3cJ9;
	Wed, 11 Mar 2026 20:11:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773220296;
	cv=none; b=AP/Zd/S5KEQwPcsLGz00/38MssMBO7JgsP80Q45O8wz+Tr7VwO5o8MIqwA74NpeBThDQHSijQGZ0SMpU7rBic/i+6PQrh7TIX93ETFYeeF0mf+eZKYfYuc2QRhA1rnEkJhVsYzFxynL3ibBO+TAFobRwYHUzuuxPA0PFe40F1tcoU3OVCh6Uaboi+3ZfUbs/9ZeHPAfGffVCPs/omCC7vhVL4Vv7I1E32xaCykMI45KXWd/3a0ifjko5OyESnm/um3ishVrPGZN3Mu3Km8Uzas1hx0MdeERx603a3bS2BFirpuKc3a+NPutUdh9zXisEX84ZvQTgGfuCy5zUFmyFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773220296; c=relaxed/relaxed;
	bh=04bm+tEWSMuuJHvI5KKhqF3dOCW9xKgNtLL1mWhPfSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lyy2aBAaM9cyL5JVLcoFgNboXZgV8sQknOKbFbf2n0BFDHLxjT56iA0VWRZ6LrFf9vutPbIZjW3vMErJ8iRQ4BAkgPiH3wpnwGGWSIb/1Hw4r5EegCF9bhukH2MgeORkyo9evCBXS539YAZ7e1yuU2EdB3F7jnWoAl9YfIOd/a9OIYNdep1+KerMdeOFEJWtCu+r+8qngq2F0T+fOfUee8BCXo+3dymVjIa61m7e3J0GMPw5JjkDEhuQNXQwkI+7XGmm9qjjs/DF6B6yqFeEkTXBg+B3hMcJ4mW7m/K5MZknyD1/KdwOtljYwb7FVIZEua63JwwwonSilRVS6GWLVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YtyjDYMd; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+jiucheng.xu.amlogic.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YtyjDYMd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+jiucheng.xu.amlogic.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW4kH1y1xz3cJ0
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 20:11:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C42C60142;
	Wed, 11 Mar 2026 09:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05940C4CEF7;
	Wed, 11 Mar 2026 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773220293;
	bh=Bk6Za+FR91Hj5mP/s3GgDxQNXtTe/Vg7T8Hbggv/lEs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=YtyjDYMdnE+TtglJRED719Y6o9DWZN83tBMCtyiIbdZe/ws3/43x5ZTz93ZY+26bA
	 PEQs5pWHKswhMF/j4HCEZRB383d0ZrEJj/OGAP8qkGAnxeG2UyC5DhFv/bOzdvnS5A
	 KBnufpKGUq5axdgnAkEUe920m/DFJELCaF0hiZg/zoaSYOGnhE5Rm2rlhuVERZHiO3
	 76HLWFeMlzNglAI9QYAuN0rBiRezAiWwMGve7r905NzlrYtMJSZkVr8Owqp5A21RFm
	 G9+xLiC5uUWrMvvkzWYB4ZjNPpnBY1XU2WEqTOtjf+ktJZajJOPfhJwWlCghlsPZo+
	 66t9YKNz5YCww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E627EFD0649;
	Wed, 11 Mar 2026 09:11:32 +0000 (UTC)
From: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>
Date: Wed, 11 Mar 2026 17:11:31 +0800
Subject: [PATCH v2] erofs: add GFP_NOIO in the bio completion if needed
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
Message-Id: <20260311-origin-dev-v2-1-0657cff690eb@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAMIxsWkC/23MQQ7CIBCF4as0s3YMIKXWlfcwXTR0oJPY0oAhm
 oa7i127/F/yvh0SRaYEt2aHSJkTh7WGOjVg53H1hDzVBiWUERcpMUT2vOJEGaXtjWm7/qqEhnr
 YIjl+H9hjqD1zeoX4Oewsf+tfJkuUqEWrNDnROSfu4/IMnu3ZhgWGUsoXgsB0KaYAAAA=
X-Change-ID: 20260311-origin-dev-1c9665798204
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 jianxin.pan@amlogic.com, tuan.zhang@amlogic.com, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>, Gao Xiang <xiang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773220291; l=2158;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=YPPl1F3AUiL8XQFRy+eFl96JoDCQD8dYm64Zhy8f3cs=;
 b=E0Upnfawkos/3AiYtmkE1dhVITJ+d/UynPpDQdaMAbmgFjnARJUiz49lEt2IJfK9wcudy6z32
 CLHKK3xLA6RBs+TwUnC/p76zC/qg7Zq4nsHsjVz3okyIOqW5cUMQBAJ
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
X-Rspamd-Queue-Id: EF98A26010E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:jianxin.pan@amlogic.com,m:tuan.zhang@amlogic.com,m:jiucheng.xu@amlogic.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2656-lists,linux-erofs=lfdr.de,jiucheng.xu.amlogic.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

From: Jiucheng Xu <jiucheng.xu@amlogic.com>

The bio completion path in the process context (e.g. dm-verity)
will directly call into decompression rather than trigger another
workqueue context for minimal scheduling latencies, which can
then call vm_map_ram() with GFP_KERNEL.

Due to insufficient memory, vm_map_ram() may generate memory
swapping I/O, which can cause submit_bio_wait to deadlock
in some scenarios.

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

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
Changes in v2:
- Reword the commit message.
- Link to v1: https://lore.kernel.org/r/20260311-origin-dev-v1-1-40524ef07ff0@amlogic.com
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



