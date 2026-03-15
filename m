Return-Path: <linux-erofs+bounces-2701-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMZKEMTAtmkWHwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2701-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:23:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2C0290FFB
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:22:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYgRg62FJz2yYy;
	Mon, 16 Mar 2026 01:22:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773584575;
	cv=none; b=U85aXsOOItjSaWr6N3OAlGdZQt8f6VqrJyjBVF066J9DHnuQRsriuZG9WCt+dOGKkwI3gYZZcF+DDCD6kmnQwKFxm7Km6+deuSPQesIfejtdSuOb1+ObyN/z1sc67Ir19zDngbTj0IiN/iJ1TCh6h4qYVoK/C/J3gVxBCjPrdOUKXPOiamGl6I11elQu7uPdMq9R/FCTnwyEveTSt6WixO7Khhvofu7EbCgimVWl8H9BA3tUOlVQFXAiDP5wWdA4BM6ZL1jbkTZp3ZYhRUlaL6SgHNvJxwefWwRAbt46pmMFf0uF06HrVVP1HLAxTsi4IAiZdVLfCJT8haGHX3uH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773584575; c=relaxed/relaxed;
	bh=pwDxGn+TR2Rti8jywkKKBwuviyHYJFzZemsOQcG8ll4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dldUiAO9NEO4+dQmMFteBF1wOYVIIAW5Y+8V6v6Vw6LF/oZ6pFNx37SW9VPZCG5TEYXP6ip3wOprEskpmzx6y+exyrNuz8UMp0LegeYyB9WkpnQ94b6Ex1MoQTdQRLvrCCgLd0F+mu3nu+18r43HDvvdZ4jq+6Cn8T+EkzN1Fx2KSRnRySz+xpo78n2OtXkPTekYnmIUKTGTo8sPZ+7YMF4Ogh6hoNX0YwkIQCUMmND2UhiT1Ogfi54U75+gxZbRK7BGJ3LqD0ksu5DpUqiewGTomD7d5TifY70b87p2zZOm25aQJygGpDxl6V4ecKSYcUnoVFjuCN9O77HJssPSeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MyF0Qg8h; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MyF0Qg8h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYgRg1BtGz2xlM
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:22:55 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c73874b3ae2so122620a12.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773584573; x=1774189373; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwDxGn+TR2Rti8jywkKKBwuviyHYJFzZemsOQcG8ll4=;
        b=MyF0Qg8hZyJNj3M45KnDTKlhnCMrhybGmlv8M0FCUg1dv6X0XKpu4WEn6JlTFP6HaD
         xJDCLMUYKjiyFAHRqHBNETF+ljhZOaeSQAKMvy6esBFE3MnIPfgoV9EfBazNeuS/9Bx8
         pqxugkUWxJEufSVBi8iQAiyVN+i0Xd9rnAR/u0Z/6XO5yUtp4LKgs2CRtpCijwsZeNfQ
         MWB5NTIJ2hVrgbxRGpWfdZ5ax/cd3x6I1DPJIuf4KjEeBC/oIjmMVg1x4Zp7WeTgrCAI
         5cjDm01V/B2bcXuLHi0Sj9AxBE5Mv4UDTzjSAvx1jXf45t5+Fw55WsZC57R6jSbLoj40
         4lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584573; x=1774189373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pwDxGn+TR2Rti8jywkKKBwuviyHYJFzZemsOQcG8ll4=;
        b=Nkulh59y8OPtGLZDPWHqdOgJNKUDTvd+NicJyvnSbEH0g+iKB0+KChkfAOXt+oApaf
         VoDetoJNBLqc+vDB/vDlN4ATuQLb3clh3NwkfREJL7X6j74DX2PeANAoeNQ2UDy2em2M
         TbXjPXdzv0G1g+dsGCihtuNdj4w4zhoX6X4OIuO9Ov36jprXsXR2YyVjADfVppFOuIAD
         ppBjbrQsmlipjzVmrMlkoRMT/a6bei6BZOV+9D3g7p1nJFwkCc7GlWH7X8rAPGjk0W0l
         yA0ayGyApp/w6XnhP6/QtP2h9rXmgsrVd2HIdNYnOWZ/Eg6XzXoSE1bTPoax1vVpcGyC
         8ceQ==
X-Gm-Message-State: AOJu0Yyy32MSkmLaaJtecwOE5+Z4ozVdP+v13kpFjASbp6LLW6Rv0y7C
	DohjKf6jp+Yf9qAnyl4cdC2rvTbhpXmBQxlHEB0wF7c7cmdT1Bdw5jMsj6dv1vQU
X-Gm-Gg: ATEYQzzkH+YF0y6vs87yh77t4OOWsGdqajlGSEP3A3xnJR6DHWrNAGi1FY6KZMRPCyE
	IHgbtp8xo8hz31VPgJagIU7A98oulnt9lI0h8puITp8qTeoze0o/6Lm/KHZT7TFRYIT4FOirf4H
	8YK1oFllYjQP+6wQDG3eP142tVSiZ1l/IlPjAxXpH+9C47I3pp9jDuvMUeT9OflajUiKiYoxfS9
	OGXF+neiBocCXcX9ISRufY0SEWQbjKSIAMfEI1Un59Wd9ehuP7rQPfxZdg+KP1IP4yzXngW7bs0
	IroZp6mWiWR8nSogGLh7yILKB+lJ5ENIJOit8vmXZSEQUb1XLb1fImt5MWQTEbV4JqdOOA/jd6L
	3qeutNDzmXzNcAD8/KBU/sGdBySOzaZ2AnmR0sv9aBHWvP7X4znXqXNpD0NY2RrLptLlNi078AS
	lEA2TlRm81TF57G67ep7t9DKzN13EhnW6X5tJjwZ+a6GHQHdiW2pXmlT9Ch9zLJbIwGpv10GzeI
	uZCd48Sbux/NiLWT7ZlaNxxOvn++tW6sdDo
X-Received: by 2002:a05:6a00:1992:b0:7ab:32fb:98b0 with SMTP id d2e1a72fcca58-82a198a5cd9mr5882707b3a.4.1773584572771;
        Sun, 15 Mar 2026 07:22:52 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072414f8sm10879640b3a.4.2026.03.15.07.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:22:52 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH v2] erofs-utils: lib: validate algorithm for encoded extents
Date: Sun, 15 Mar 2026 14:22:49 +0000
Message-ID: <20260315142249.4333-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315072806.17504-1-singhutkal015@gmail.com>
References: <20260315072806.17504-1-singhutkal015@gmail.com>
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends in
	*      digit
	*      [singhutkal015(at)gmail.com]
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [singhutkal015(at)gmail.com]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [112.196.126.3 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:52d listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:singhutkal015@gmail.com,s:lists@lfdr.de];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2701-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4A2C0290FFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Encoded extents use fmt field as algorithm index without checking
available_compr_algs bitmask. The non-encoded path already has this
check but the encoded extent path in z_erofs_map_blocks_ext() was
missing equivalent validation.

Add available_compr_algs consistency check for encoded extents,
following kernel commit 131897c65e2b.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/zmap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 0e7af4e..a8d1ca6 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -630,8 +630,17 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 			if (map->m_plen & Z_EROFS_EXTENT_PLEN_PARTIAL)
 				map->m_flags |= EROFS_MAP_PARTIAL_REF;
 			map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
-			if (fmt)
-				map->m_algorithmformat = fmt - 1;
+			if (fmt) {
+				unsigned int afmt = fmt - 1;
+
+				if (afmt >= Z_EROFS_COMPRESSION_MAX ||
+				    !(sbi->available_compr_algs & (1 << afmt))) {
+					erofs_err("unknown algorithm %u for encoded extent, nid %llu",
+						  afmt, vi->nid | 0ULL);
+					return -EOPNOTSUPP;
+				}
+				map->m_algorithmformat = afmt;
+			}
 			else if (interlaced && !((map->m_pa | map->m_plen) & bmask))
 				map->m_algorithmformat =
 					Z_EROFS_COMPRESSION_INTERLACED;
-- 
2.43.0


