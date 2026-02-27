Return-Path: <linux-erofs+bounces-2438-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJJrOF0CoWlVpQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2438-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 03:33:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8E1B2118
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Feb 2026 03:32:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMXRs26K1z2yFQ;
	Fri, 27 Feb 2026 13:32:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.108.3.166
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772159577;
	cv=none; b=dE83AZlRYb0kxjOAfwwwW4CopFnB0SHhBCVBybYkhH+hJQJyabYMdv5hbn6UB81ieksclqvTRFH7Cb8jlNXgWQCLbH1Kmd4hJ4SvJ3PCI1ZXeXhum0HeVbryqJm+PaRmqkyA0lHVUXi47PUNLmUaPAQeF6hY5kMf8s3iXtFltIC+SRex+F/zDT5NlVb2Dzqh5M7Kn9E67tNuQSvg3A9ZsndlmAU/OFSCauSuxwa4M49pQRXkeAjDOzHFTSav1Uk+giUvbrFrthahrrkAoJhrA1ugQ2Q3FZqHhS3j1REuMpZY0T/jLmjpe8ZRy1Rg1Zr/3EBuZyan6ZEtQX+MLo51ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772159577; c=relaxed/relaxed;
	bh=Ex9qM+2XuVg2r2DvaSUmdorI2HFF8ZSJSdl1UB3maXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIk6fmJL0UwRBkoS+JX6gcEuHWoVvl1zbzzSYXgM670BrFH+B407i3D78WsKdRUZlm6gsHich+DZlu3ZQ220NClQWir/erX5iILnhsRVHJ5nsahkC8U+CG/1f0PiGWITJSGwrkJvK/EokNFDGFMs7jsQlQZaYvc9GvajSU1d59752QBRqOIVV70D4lJvyndhRi+KLTvvi7f2RrUJ9VzMqBKKzjCaT/SWE7mLhS7rj/3+/XCJhBPM1Ao6O2sigL3wk7vsvxhACDzPtVM/qViz5FFhLNVi6U4WxpiszxKIEjz8wN+F74kLKkh4bKs1U3uHfEsOr45KbRyH7KiBUEDK3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sina.com; dkim=pass (1024-bit key; unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=Sn1OLtKI; dkim-atps=neutral; spf=pass (client-ip=202.108.3.166; helo=mail3-166.sinamail.sina.com.cn; envelope-from=shengyong2026@sina.com; receiver=lists.ozlabs.org) smtp.mailfrom=sina.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=Sn1OLtKI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sina.com (client-ip=202.108.3.166; helo=mail3-166.sinamail.sina.com.cn; envelope-from=shengyong2026@sina.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 132 seconds by postgrey-1.37 at boromir; Fri, 27 Feb 2026 13:32:53 AEDT
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMXRn31NTz2xMt
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Feb 2026 13:32:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1772159574;
	bh=Ex9qM+2XuVg2r2DvaSUmdorI2HFF8ZSJSdl1UB3maXw=;
	h=From:Subject:Date:Message-ID;
	b=Sn1OLtKI5so7pkre3FCAUSUFOFeWXBfwJdoSxyU5o7lP3R//9dJMTbFj3mvYKG4oN
	 eqQqt90TPQmn+acMTlEJWEMOtY+iVlTCW/St7dsiYKW2cvcDJ64poV8PSHJ5Ut6AqA
	 Z0TFh/Nfw2fhiY1wW8J2Pc4enQ66YVuN00ebSeak=
X-SMAIL-HELO: PC.mioffice.cn
Received: from unknown (HELO PC.mioffice.cn)([114.247.175.198])
	by sina.com (10.54.253.31) with ESMTP
	id 69A101BD000067A8; Fri, 27 Feb 2026 10:30:23 +0800 (CST)
X-Sender: shengyong2026@sina.com
X-Auth-ID: shengyong2026@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=shengyong2026@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=shengyong2026@sina.com
X-SMAIL-MID: 5900266816028
X-SMAIL-UIID: 2A7E148782974AE49E6D5F2827846A8B-20260227-103023-1
From: Sheng Yong <shengyong2026@sina.com>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong1@xiaomi.com>,
	chenguanyou <chenguanyou@xiaomi.com>,
	Yunlei He <heyunlei@xiaomi.com>
Subject: [PATCH v2] erofs: set fileio bio failed in short read case
Date: Fri, 27 Feb 2026 10:30:08 +0800
Message-ID: <20260227023008.147813-1-shengyong2026@sina.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[shengyong2026@sina.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:shengyong1@xiaomi.com,m:chenguanyou@xiaomi.com,m:heyunlei@xiaomi.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2438-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shengyong2026@sina.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.com:mid,sina.com:dkim,xiaomi.com:email]
X-Rspamd-Queue-Id: 3ED8E1B2118
X-Rspamd-Action: no action

From: Sheng Yong <shengyong1@xiaomi.com>

For file-backed mount, IO requests are handled by vfs_iocb_iter_read().
However, it can be interrupted by SIGKILL, returning the number of
bytes actually copied. Unused folios in bio are unexpectedly marked
as uptodate.

  vfs_read
    filemap_read
      filemap_get_pages
        filemap_readahead
          erofs_fileio_readahead
            erofs_fileio_rq_submit
              vfs_iocb_iter_read
                filemap_read
                  filemap_get_pages  <= detect signal
              erofs_fileio_ki_complete  <= set all folios uptodate

This patch addresses this by setting short read bio with an error
directly.

Fixes: bc804a8d7e86 ("erofs: handle end of filesystem properly for file-backed mounts")
Reported-by: chenguanyou <chenguanyou@xiaomi.com>
Signed-off-by: Yunlei He <heyunlei@xiaomi.com>
Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 fs/erofs/fileio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index abe873f01297..98cdaa1cd1a7 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -25,10 +25,8 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 			container_of(iocb, struct erofs_fileio_rq, iocb);
 	struct folio_iter fi;
 
-	if (ret >= 0 && ret != rq->bio.bi_iter.bi_size) {
-		bio_advance(&rq->bio, ret);
-		zero_fill_bio(&rq->bio);
-	}
+	if (ret >= 0 && ret != rq->bio.bi_iter.bi_size)
+		ret = -EIO;
 	if (!rq->bio.bi_end_io) {
 		bio_for_each_folio_all(fi, &rq->bio) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
-- 
2.43.0


