Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F90F967FE0
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 09:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725260463;
	bh=8fgtuvRFIXezToFGm8qZZqVkmscpF7rZyoJRM+DZI0s=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ME5p4bxo/2Wq9deBM58jU86q+b1posShuTfBD/z+yy2S05aMtNh9Ycw5BtYCELtO0
	 CFBTCptE8n3C4cMbWtONd5Bb2Xkm2XPA9MQuw+eBwjccy9bfiU7VQpSlIlekt2Rcoh
	 IyURIiDHqE6vJ7LtYwC1/WI4+XFrCbRi88YSCJY3+ZD6zKnOKEsB6fqm+vvHhjFq3e
	 0aSltLzJ5Qp+5/qXVFlzrTg8Tdu2CHBMPyeyGWdW8JeT409wLomxWq/Na38MAlCTCZ
	 4YVXlkjc/HVzy4ghRtUVUeS1QlXS8iD5P8Wq6Q14VV3iOckuwLkcImL6NGGjDGHCOo
	 6mC8961XAFfLA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy05q4CJGz2yVX
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 17:01:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725260461;
	cv=none; b=RwAsoiJW26VptJ6RFNz5+qAyDA1Y/dwx+iMTZ9EmeaaHr8QqEz2yvU/HJsgXqBfLqdCu64snV+3UERKAyfwM7bnJmAWBL7UlayIuxZvimfETGt+FVAAzvjO4P/qVojYSA/rBXy1w+mqd9QiV7B7vp2CU1WGqF5jKrRgytMzN16FXrJNa3Naeg9lgfqrKuUsbwLlFlHW7BtirgkhqQqJyLPMbqLavBnDmBUu5vP2caCeR3qQJj1PTajHyMoHD/bmYMXZSvTK26p46GanJ9wfVIEkpI3ghn7yFqCE3ftnsMLppHpJFwytdSTo2yNjoC7P4PpIo1DklRXUd4izC2b1y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725260461; c=relaxed/relaxed;
	bh=8fgtuvRFIXezToFGm8qZZqVkmscpF7rZyoJRM+DZI0s=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version; b=T8QP4MOCTxJpNvQTgegrc4ylEkQ7X+vfzV1tjqZfANsk64utfchBLSuswCmGMCvvELfnr1mrt22/HQtHiiPaGno3ZCfPE0XNQU8XdAPi6f6bujMpat97LH6rcRI/J+5ct3S1XDwEoQTA/zxTChPABw0hss1CbdP3XUp/T0QjTAsAXzp2rRYhracBuYM2weRUQb0fqOYwsuS6h0ZB9+wup/1K9pAlrqJw/MEmbPPAN+TK25N+2EUPDPtNwOnri/4UQD/Neou7ZKu8FK7P4DCq/mlB4i2j+F7TDcolKlU0bLKtXtySSa3yJF1pQUj3K25GJvpJDxIl9Gkj2wRDxnjIPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=m7QQ4tkm; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=m7QQ4tkm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy05n2nq3z2y7M
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 17:01:01 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4522269843;
	Mon,  2 Sep 2024 03:00:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725260457; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8fgtuvRFIXezToFGm8qZZqVkmscpF7rZyoJRM+DZI0s=;
	b=m7QQ4tkmO4/FMHc4YtQFF2v+IvtVqyyJO3x7VjvfdMoYD8nJPzOPgYNYCaelX9qCVz1Keb
	qKPClzkXJKZSFI97qn4vLCDtysYQDjmnMd23lwVl75ymXlRpFKjQOymYIEvsfiRPKcfAt1
	yLkKECXIhuNUC26YIJSnFZ2HTxBJ3AOZwZ3f/ZCDvwNXJIWMEAQDPwuC9uqGZwmadcL2d2
	LX4fvySdT8QdstAqp+BYjIgM7iEQhHbZsZxVZ3CQUccFuyqR7wFEkMzvxVYbqNd8bbPFSJ
	QIUF/dTGblz6r677DvOx7zyDlpNT8dMlca28beKsXkQ+xrToim/hQPcnh/Q3eg==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH V2 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Date: Mon,  2 Sep 2024 15:00:46 +0800
Message-ID: <20240902070047.384952-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902070047.384952-1-toolmanp@tlmp.cc>
References: <20240902070047.384952-1-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove open coding in erofs_fill_symlink.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 419432be3223..d051afe39670 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -188,22 +188,20 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 		return 0;
 	}
 
-	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
-	if (!lnk)
-		return -ENOMEM;
-
 	m_pofs += vi->xattr_isize;
 	/* inline symlink data shouldn't cross block boundary */
 	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
 		erofs_err(inode->i_sb,
 			  "inline data cross block boundary @ nid %llu",
 			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-	memcpy(lnk, kaddr + m_pofs, inode->i_size);
-	lnk[inode->i_size] = '\0';
+
+	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
+
+	if (!lnk)
+		return -ENOMEM;
 
 	inode->i_link = lnk;
 	inode->i_op = &erofs_fast_symlink_iops;
-- 
2.46.0

