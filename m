Return-Path: <linux-erofs+bounces-2690-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJzSMCHctWnx5wAAu9opvQ
	(envelope-from <linux-erofs+bounces-2690-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2026 23:07:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C328F30E
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2026 23:07:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYFp42g0bz3bnL;
	Sun, 15 Mar 2026 09:07:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773526044;
	cv=none; b=jr20Q9JB9L69OLRg2yfuAcwXgXB6UxOCdPuvpy1e9locA2+6EfXjlF8s2KSYyLNlV8ZcEXaCY3CDu1OVumkzrDqC6yxZy3b++RDTzrGdkLuDDRXQNOAILYVVD5u3lsI8N5DOrPOnzj7t093ED276nDm5Af1lUM52Ja++jS9Im/YWQBPNhporxgxlIogv7xUKSMhZKbwvcNYg/6MdoeWib0eyjn22+R4x5mw9w2yafpsDKBIHsdBMjtOE90gWRKhVrZUsJ/0/yHMwJoGVre8ZH4T0s556aj5rTWewkkqnln0Uta3s8Bz3YSBmppKOVmVRg+2IGUY7XICLfVXEL/mbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773526044; c=relaxed/relaxed;
	bh=RxNtaJgo6FZYsnTw53ZZv1uwmmrARXGQs/cpAI+R2K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOSnDzbtCzm9g5ywpH3Sg6dhPcrUG098dVe/aH1Mi+vkGEUgnVKuJ53XZkcpdaLqg5gHy11GH7mzqKJeKkNJ1PybZSSy+wvSp8hkWqzZYi37asWO9jAjzAC5lmtPouBiye8BLTliPjSPi+kUkz30Fdx9WlLviCNjJzOlnwSexz66yfXTYhagEv5LhaV7jnsQMXc5ih3d1TscXEOmFq6yFExUh7+V/gItKbGWUHBwP/LLwWgsMj0YNu//ZfU0hS6IrSpU8DxSjxIQeeP2chkRoE7UbF2ZA0ClY4iepyzuzoCyFhCWFl25ewWvI723nPN0H4fsO9fwd1ymwDZRHnBm4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fFJW2pjs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fFJW2pjs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYFp25Jq8z3bnD
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 09:07:21 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-35b9581befdso3709a91.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 14 Mar 2026 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773526039; x=1774130839; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxNtaJgo6FZYsnTw53ZZv1uwmmrARXGQs/cpAI+R2K4=;
        b=fFJW2pjsmrZi617LAZ2zMbmSH9H/mm0tqqSpYNWHqvMJYi9TYt4T2PB3yaWXQzI83b
         qc19Gi2PI79Au6Q7Iq22rkajQO9j3efRcXze8aGVAWl+3XBtQOSKpyC4qOVtWvxps6tZ
         WyAXSzPadHyq6lQon8zmOrLqEqCxfZvRrrHtz3cAQBgc2ELWD1jCHKuQBrl1GrhYiDgY
         sXAkMQOENbOasZyljAuP7iagRG8bF27f8QaiI7EMFIq8goSRbEpZKp3bdY40F/qGhVFs
         R8By+G0P4qwQTjYZlWIDYFExNzjd5JWeX4L90fa6vONadnq/MguGopQSiMLbFrwaHpDD
         CWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773526039; x=1774130839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxNtaJgo6FZYsnTw53ZZv1uwmmrARXGQs/cpAI+R2K4=;
        b=m9+HOQmJLnYwXp78ehfaEuKPKK5Mk3q0eDsvXeb/a6Kcy+a5nDPiFsaoqVWYPSTaHE
         0daXsalfX/DZzlNhqFdMEHFPdKtiNPr1dFwpUAazGGmT9SwFniR/vPK4VLJMRwUxX+bN
         TkSWhq+J45095UYI5jrwscvnhRcHrcpvZpgmp54mEvIr8rlsWFZ08BGm6WiVHVj9Vl0i
         Qunv6ZD8n2KgBHtaO/J3QwbZmiD3klGurngmpXtxmAI8G3j5ODWQqzcIoWHAGgoXb1Mp
         M88hIEUT/v21dDcYjkQARysfowAxya5y1Hmk5n9siG4VI8LamyEpRatoNDgO2noJQ0/Z
         radw==
X-Gm-Message-State: AOJu0YwODTnt93DWrVyK1QGLIj3o6bFvKhqo9PSQOc4fDKfiiyB9p6vM
	HvyqeyrWj+sBQltPjCXqU4jWI8Sz05mVbZAbYOHW/AUTfZ02xS2nqLvB+wp+MwxF
X-Gm-Gg: ATEYQzz8zEL+eg0atlOfi27DUUA3XUNELqDkNGd5QkMBxMZ83f2skcaHqUXUKMkza9E
	fkWAYIsuLO9g587xc0TL6MPGRK46Nky04WT+Zo90mNUDF+lU9iiGN//g+jf6EYDV+XtwMStABiR
	lnbkG2G/t0Eag+hG+AcHEM/tC5Q7osDM5/TZNMluIjJuMa/n4kAi+JIhg40TNXiDcAc/UmHx+q4
	iDeMVEf3xGWTBXhFkhPNABjP0mVMGBGcYhelfgqhMRLY/smTQacTAJOXgvtXmN3YqtsKBwCH2L2
	jA3h9LMFyLtpFNfEZ+6ZcupRvBkHJQZR7czjpFm3CjKfqg1gX6GjxjXG1nnr/Xca48aB3vieF5Q
	6cQxhxUak+o6UIrLoyqYxhq1n0ysA3kzCFx8b3z9kZIV7mU1Jq0rL25MGGBKdTukps75iIfvnYW
	MyZ2zJsfapz5vwprmS2RfPg/N8gx0Zx0wnu2QL51QPgPXqv1x0Ti73BUAuQfcwm0GKYHbprorsI
	FUpfJXWNDMPrPxWO/eONe/SpYOxC9n91EqGow==
X-Received: by 2002:a17:90b:5348:b0:352:d19c:684f with SMTP id 98e67ed59e1d1-35a220baf48mr4458633a91.8.1773526039196;
        Sat, 14 Mar 2026 15:07:19 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e9861csm12430810a91.8.2026.03.14.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 15:07:18 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix missing -EIO in z_erofs_decompress_zstd
Date: Sat, 14 Mar 2026 22:07:13 +0000
Message-ID: <20260314220713.26144-1-singhutkal015@gmail.com>
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
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:1033 listed in]
	[list.dnswl.org]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2690-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.754];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 778C328F30E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ZSTD_decompress() produces fewer bytes than expected, the
error path logged an error and did 'goto out' without setting
ret to -EIO.  The caller in data.c checks (ret < 0), so a
positive ret was silently treated as success, potentially
consuming corrupted data without any error being propagated.

Set ret = -EIO before the jump, and add an explicit ret = 0
on the success path for symmetry with other decompressors.

Fixes: ed2f7cf ("erofs-utils: add preliminary zstd support [x]")
Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/decompress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/decompress.c b/lib/decompress.c
index 3e7a173..01f5e24 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -68,11 +68,13 @@ static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
 	if (ret != (int)total) {
 		erofs_err("ZSTD decompress length mismatch %d, expected %d",
 			  ret, total);
+		ret = -EIO;
 		goto out;
 	}
 	if (rq->decodedskip || total != rq->decodedlength)
 		memcpy(rq->out, dest + rq->decodedskip,
 		       rq->decodedlength - rq->decodedskip);
+	ret = 0;
 out:
 	if (buff)
 		free(buff);
-- 
2.43.0


