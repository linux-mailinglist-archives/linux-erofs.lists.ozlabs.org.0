Return-Path: <linux-erofs+bounces-2726-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIuvGnGzt2nUUQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2726-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:38:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D44295BDD
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 08:38:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ6QQ0Yd4z2xS5;
	Mon, 16 Mar 2026 18:38:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773646702;
	cv=none; b=eQjrsCf70xYsmEklSNUkOfx3wiFRTwsMuWRy2L7FdXQFj9yp6YRDntm2yhRTqS9WSYONfI98T5abkNB2i+w42vREsecTNdqjvzWyZ3Vjul7A3WejDsPyzrYRfSJJrQsZYwpQj9/0ugDh0mEtnDgDz11vD2Ldu4v+imVpzYe2zZ+M3Ta5MJbnHJzsBRnFdSJBjhiuHbR0pPQxMJElYNLzh8uQjqmDUCJ/KthdPGFjsJqHnneiqcaOZrTCAk+eqLnyl6o26ZfQEtRYo9WKyvxrnRcTU8XpO8/whmUBfVolwBY/TiqUgoMqHSNcJ5OVatydjndVvlHr53ZYHoXfQIsXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773646702; c=relaxed/relaxed;
	bh=QrY3pdYdCFprS8IQasu0A7yKlHRNnjJGdu1he2CTMlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeatJocZNWh/lIKWz+5+pgwp4EGel/uDylavE9cp8MVM3W9QSPgDlyyOLSOUm5c9Es3bt+Sbs7WUNItQ4cGfYt5OQwNXCWFk1ov0fg3J3LoYkZ5ZtUNfax90bx9XWiOlFWEAi+UmSyvJDEKseHEuJQ+iI+HW1r4sOGrc6Mw0uncoqkeoBNZDZjSpbLRQwWnVXVUY5QRSfl9sFc0H/6yI1R9tMYieDXq23PBYR6cs5lxXL9g8wYfPRczKRei8xMXtV//+T945CaXBXiruv/uDIFH2IpHIttHQ46LjlhA/j0BgjN+zGTYJctKmUF9O5h1jlnliNyTtC3KpL08vGwIxKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VGMq9UXF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VGMq9UXF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ6QP2FZGz2xQD
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 18:38:20 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ad2b375e58so2256195ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 00:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773646698; x=1774251498; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QrY3pdYdCFprS8IQasu0A7yKlHRNnjJGdu1he2CTMlM=;
        b=VGMq9UXFpYS6Y7TKAh1Bt8zQ2YDiznSN0va9KRAW9TdSjzLUMjUe2xBwdRa9wIr0FZ
         PnbS7XF08JvOMmHFmVDPPgAjVlPHv1+obWqbft7PR1zG1rNxiLdwy23IzbRO6UbP+uNE
         Haw3KBLw/GXrUumO/BhlZTtpgxhEcAYYZ4VcaiA43Nk162EfWwu7zRkeRBPzialwOLr2
         2GUGZdL/rif83UqkOGe6t8pyNZ/iH0rHFVzgpewo7iD0sZnyq80FyBg2ZGe4AnbfrFjN
         RJhmqQAhShrelNSF0XI32iuekukLT5eXsmgmedaiSpJo52Dc1RRQng60p/SOqW8UHWxa
         PLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773646698; x=1774251498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrY3pdYdCFprS8IQasu0A7yKlHRNnjJGdu1he2CTMlM=;
        b=HlNapNPLsSLsgi0HWSb6GEeEYENlSdqjRYlJ1hFATStVe1z1hN/R7+v/9VG89ll4Vc
         +YCb5o1VaQbx3twye9rb7UG4hGwsZkQrtXW4hN69yTO7AsSHu2Ia2U6VHOfDyeEv1eID
         MUytDdPdLwWpSsQQr4YZb+lA67GyfUsKTtZGbwMNJNyW5V6Dpu0DsRPzTOWV6L9a0Mis
         HEkrsSrH+A8zP2ZSO4R3kDqba4dLdAqkKCNDQefdxukk2Jn3vcexEx5/qAqWs3g8dal2
         p7rRoar2kTi+4TH00aPBQjrXGlz7p51U5xEX2AlRv/wQK/tJOb1sK7ljgAwHi/iuJSum
         JuEA==
X-Gm-Message-State: AOJu0Yzbz1zOjykfDaLgBhhPu5S1MS9s7/CeRZi8QkNMftRr4dsfZ5mq
	hjCc7Gl67KQz+rPW/uI6zwx3yXb3Dgqwvyojw9uUeft9fX5nKWuvZC6bGDBkpdYs
X-Gm-Gg: ATEYQzz8zhKhoO7C1l4nwYosqD2o9yOs8vfMBV+TY9SkZTD0hOaTLMWyMzP0A7NJl0B
	sc5w0lWqDS61G22AatgPpfk7Cj2AaVSZhE/DX+0/qzND5uN8W2NFxGUWxHuQILX36P1HVEsNLVF
	3UTIwB3DLifwn0im8XrKb2S/0Vdrb77TTwzxZ4eppsiWsbiwqCaRfIOoBahNb9uogC3BDtmO0V6
	iFSNCvYw6+Bhgs5XYtDTbibGy6GodYaO1Dzde86AtfFMw0zp/t3XmvinHSBCgIkHQlKXHmsFEXB
	O+SfXHwgyZxpQkdYysffdcey7j/YpfIcVI1HzCX6ae/ZFwG1/0+jqg5x1HHvvlYHr9eYN7n4i4+
	wNMdbdj6xD7FeVUjC2+aP3yM/5x86ZaXqYFCUpuoLomvN/RDVvnkZUgNNRdvOmcf5rZuQh+zHiZ
	u/FesMysL3EIOqsYyirgRRZRuBNqxei0E5zfiG1REsYUk8MwqPzZcy9SeEvXO/BAcRwQ/EGyWe1
	1dt9cr/bJ43t9Fup+U9sBnYwwVh994xXRxp
X-Received: by 2002:a17:903:3c45:b0:2ae:464f:fe3e with SMTP id d9443c01a7336-2aecab1fba5mr91205085ad.5.1773646698266;
        Mon, 16 Mar 2026 00:38:18 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee9f2sm100112485ad.56.2026.03.16.00.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 00:38:17 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@foxmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] fsck.erofs: validate h_shared_count against xattr_isize
Date: Mon, 16 Mar 2026 07:38:12 +0000
Message-ID: <20260316073812.30470-1-singhutkal015@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,foxmail.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2726-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 84D44295BDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A crafted EROFS image can set h_shared_count to a large value in
the xattr ibody header. erofs_verify_xattr() reads this value
directly without checking if the implied shared entry area fits
within xattr_isize. This causes 'remaining' to underflow below
zero after the shared entry loop, corrupting the subsequent
while(remaining > 0) bounds check.

Validate that xattr_shared_count shared entries fit within the
available xattr body size before entering the loop.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 fsck/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index cf07829..c911aa1 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -374,6 +374,12 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	}
 	ih = (struct erofs_xattr_ibody_header *)ptr;
 	xattr_shared_count = ih->h_shared_count;
+	if (xattr_shared_count * xattr_entry_size > remaining - xattr_hdr_size) {
+		erofs_err("h_shared_count %u exceeds xattr_isize @ nid %llu",
+			  xattr_shared_count, inode->nid | 0ULL);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 
 	ofs = erofs_blkoff(sbi, addr) + xattr_hdr_size;
 	addr += xattr_hdr_size;
-- 
2.43.0


