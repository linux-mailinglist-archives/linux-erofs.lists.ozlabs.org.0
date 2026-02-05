Return-Path: <linux-erofs+bounces-2266-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DUFFX+KhWkWDQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2266-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 07:30:23 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E7AFAAF0
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 07:30:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6kjP0gbtz2xqk;
	Fri, 06 Feb 2026 17:30:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770359417;
	cv=none; b=kwY1Hye5RI9l3AcCRZdZpqVXdkDSS66fIMCleNsvJ4C1AT7T9gX3n3xQO5jptnbD1nM81c+fvoTuV03Y9/HJILEV4z+ufqstarNXNC7C7n73WoN3yIR0iDLckNuKhCcabNpbx7Wxmx5qMF4cBYu/MUHC6yhmJHuKL+6oagvRRMzbMLKYGbrkcUKLK8RaLtN3mWo+VwQcRPcJ36UBR/0fjIsJUp5dH3U56cm70V9/m1lpOXTZajIZDSBOy458aILAV8xjpUn79TYp+2Wvcb7clt6W1WO54nCAJkXRI+nFezQy0MMblXHpRQ7ArJ+JSf+9q8xzz/5QFL3eWy357SUZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770359417; c=relaxed/relaxed;
	bh=IgxXbLV/Fa9tnQPlgvfhG1cRXkkBj5x5kO/rf9Qfjeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NI4jD3txdt1y9VDnYnBLIo1weOA1vkDkm/i4uFNTwPiW8h3N0RnnNDjjnjeB98emvTOoyxZUdhkdzI5hAM/rqjBSqyLWU4UxHCQoXpTJqiybecL4KMUlxQhno5Oj7I82LLKHT15JuOhKNRImqM47uozuDhx5zryzvqHOTIWFyF9TGGCfR7vzOGAPxK7lTOl6td7hV+Xg7KVQ8R+D1gtIeSnMkQMg4wLMjQmts1tn4U2Ou8M4RaYQMVRkaWMLoWz4xPFyVuALG8liXb7J1pNDGDtuk7lVYiOLHL4wyELNC5iC5ykjzZWtf4gaaCyk/nkJnbxUIAxdrijQz69p76Tqbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aYcKgjHJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aYcKgjHJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6kjM74hPz2xWJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Feb 2026 17:30:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 015FD6001A
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Feb 2026 06:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A89C116C6;
	Fri,  6 Feb 2026 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770359411;
	bh=tySiLComH42yw5CiXQiw6026PNWrWpTomOFKiRPk5D4=;
	h=From:To:Cc:Subject:Date:From;
	b=aYcKgjHJMciUhx8147reu6F0tOEEB7Z66i+/HrqWLDqtAtxG6OX4Tpf5CDA+aQWyY
	 1P+SnlkmXxr9Y36SFtmzELUCvtOqY7kiS/k6fa+7rDXfwEnIo+cSWdHihFniyxG9cS
	 WxzgE8LVeWlIkGaBAHhcHTUeTuNTWlj+g6p3ah0Lp7R795ciRFEoeSW1C9rzSiobDV
	 6FQSucUSiqvWaZabM8As3SSEFsi1w1SrFGvI9EaU+IqTsqUBjpXbjjYhxRCbpgw9sV
	 7d/qGKb5Nl3wxqx/j7/Wrp7kUOqUhYnfqBzrrOtWlRYmcbBczAbYJfxYDYSzggd4H4
	 Fv2nKZzqh72zQ==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org
Subject: [PATCH] erofs: fix UAF issue in erofs_fileio_rq_submit()
Date: Fri,  6 Feb 2026 06:30:05 +0800
Message-Id: <20260205223005.72727-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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
X-Spam-Status: No, score=0.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2266-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:chao@kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 60E7AFAAF0
X-Rspamd-Action: no action

[    9.269940][ T3222] Call trace:
[    9.269948][ T3222]  ext4_file_read_iter+0xac/0x108
[    9.269979][ T3222]  vfs_iocb_iter_read+0xac/0x198
[    9.269993][ T3222]  erofs_fileio_rq_submit+0x12c/0x180
[    9.270008][ T3222]  erofs_fileio_submit_bio+0x14/0x24
[    9.270030][ T3222]  z_erofs_runqueue+0x834/0x8ac
[    9.270054][ T3222]  z_erofs_read_folio+0x120/0x220
[    9.270083][ T3222]  filemap_read_folio+0x60/0x120
[    9.270102][ T3222]  filemap_fault+0xcac/0x1060
[    9.270119][ T3222]  do_pte_missing+0x2d8/0x1554
[    9.270131][ T3222]  handle_mm_fault+0x5ec/0x70c
[    9.270142][ T3222]  do_page_fault+0x178/0x88c
[    9.270167][ T3222]  do_translation_fault+0x38/0x54
[    9.270183][ T3222]  do_mem_abort+0x54/0xac
[    9.270208][ T3222]  el0_da+0x44/0x7c
[    9.270227][ T3222]  el0t_64_sync_handler+0x5c/0xf4
[    9.270253][ T3222]  el0t_64_sync+0x1bc/0x1c0

erofs may encounter above panic when enabling file-backed mount w/ directio
mount option, the root cause is it may suffer UAF in below race condition:

- z_erofs_read_folio                          wq s_dio_done_wq
 - z_erofs_runqueue
  - erofs_fileio_submit_bio
   - erofs_fileio_rq_submit
    - vfs_iocb_iter_read
     - ext4_file_read_iter
      - ext4_dio_read_iter
       - iomap_dio_rw
       : bio was submitted and return -EIOCBQUEUED
                                              - dio_aio_complete_work
                                               - dio_complete
                                                - dio->iocb->ki_complete (erofs_fileio_ki_complete())
                                                 - kfree(rq)
                                                 : it frees iocb, iocb.ki_filp can be UAF in file_accessed().
       - file_accessed
       : access NULL file point

Introduce a reference count in struct erofs_fileio_rq, and initialize it
as two, both erofs_fileio_ki_complete() and erofs_fileio_rq_submit() will
decrease reference count, the last one decreasing the reference count
to zero will free rq.

Cc: stable@kernel.org
Fixes: fb176750266a ("erofs: add file-backed mount support")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/fileio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 43998fe1cce1..4d5054dcac95 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -10,6 +10,7 @@ struct erofs_fileio_rq {
 	struct bio bio;
 	struct kiocb iocb;
 	struct super_block *sb;
+	refcount_t ref;
 };
 
 struct erofs_fileio {
@@ -38,7 +39,8 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 	}
 	bio_endio(&rq->bio);
 	bio_uninit(&rq->bio);
-	kfree(rq);
+	if (refcount_dec_and_test(&rq->ref))
+		kfree(rq);
 }
 
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
@@ -60,6 +62,8 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 		ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
 	if (ret != -EIOCBQUEUED)
 		erofs_fileio_ki_complete(&rq->iocb, ret);
+	if (refcount_dec_and_test(&rq->ref))
+		kfree(rq);
 }
 
 static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
@@ -70,6 +74,7 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 	bio_init(&rq->bio, NULL, rq->bvecs, ARRAY_SIZE(rq->bvecs), REQ_OP_READ);
 	rq->iocb.ki_filp = mdev->m_dif->file;
 	rq->sb = mdev->m_sb;
+	refcount_set(&rq->ref, 2);
 	return rq;
 }
 
-- 
2.40.1


