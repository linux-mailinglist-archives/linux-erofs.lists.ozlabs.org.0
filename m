Return-Path: <linux-erofs+bounces-2782-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB9tOtreuGnDkgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2782-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:55:54 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB72A3D87
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:55:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZfmQ4fyZz2yhY;
	Tue, 17 Mar 2026 15:55:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773723350;
	cv=none; b=jvSZwQMD3scamEsU+ukACTm5WFfThEvRLOycwC+vDDSzddxdFE6O0ae5zx9LTp/EFF8No8WDcAZ2Olkzvs6l7w9dCJWkJyKu2fi3eUdpnhFcId17gmlla1wdsrZtNOYOtPUmqsw59Aq7znQSWbWliemdRQ62nNaikVWNf9SX02v3DhJFXcJFPLYE+IkpYJDMQlpwME1GHhn1CzmJ+wtiJzJLxq4Dg6hMUCCApChc9n3RitcZawtfT4UN01ZgjqOPUjibKVZuFzl41cXW86T1C1MK5MueBdwY07dpHfRnJhNWn4abc5eBGhiYhImwqbHRlg1OeQE/CFwy+xyGHME+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773723350; c=relaxed/relaxed;
	bh=aQM2eBicAhXo6KwJOIN/BFJJY6gLG4XSDShB32qmhRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euIEcB+LYy2U8nR1SxjxBTHd8pgAxbeWZeug8obayRSgll6PM2BJ+dP9lwwvHakRHki008Wr1cDwiS5ms3smW8AJahNQz46lmdrCEcS5WwO4EBGCMfly6xKy53l/riWbvsuyOb0Vj86ZrKLoxXquSlcCQuD8sVxx4GZ9fGuPyc0gnPWyC85ySuVzUxa1Coz68a/DPied7LMvu4tmetjtjDM7Qn8npfaTHNV301ZrZxIcXLjvKQh3Gex2HOVQ0MwZ3VJCcMCTbnfFP9XLsuqpgRDzMd+3zADyr6DFhBSMjCirRvG5Ie8dn1P/FIUG5pap2YPMYUKVQZbq58U35wW8YQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IE/pXUxq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IE/pXUxq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZfmP6rVkz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 15:55:49 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35b982990aeso111174a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773723348; x=1774328148; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQM2eBicAhXo6KwJOIN/BFJJY6gLG4XSDShB32qmhRE=;
        b=IE/pXUxq8y3JVEysGVYlE9g6w2Zk1oHQz3ER7InNUmAmidL4XK4NfGUc/xxiWwT1wz
         UPQ89umc9Lu7/JW57tLaoUQKOBf3NeCaQEyJIGkiICoRqr7+QHlub9dugmFMrCMve7Dl
         UxPddqxytw+yBRgaygKdhHbLpYGCpPSNL5SzYQNsp2VgFAvTnhkhiPx9jJA22+/lgHrv
         D48a1Y+WrDiMd24Iio0CGKp0M2WcuCb7TB8sRWerPjzWgMJ60zOTaBbFmwRhQrU8UgQ/
         3ZpZkdczrBs2wed6N4Re1duSIhCD/B4QSHR/LYzqjY56A8cBoBu9SnCCU101meZLdmRS
         KX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773723348; x=1774328148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQM2eBicAhXo6KwJOIN/BFJJY6gLG4XSDShB32qmhRE=;
        b=iQdCxFqO7gIQTnm3RKsMVZUDASHzs9/etO+KEru3qcKvh6LLOMmeT8jMti7rIEkv6A
         X90dW/E3LLnt5JxEYZY8sUARFUJE+hofG0rx2vHIa8As4aDAPWI6xPcv/d/6lkpvSdmm
         x5IZWUDZFhvqBM0tbEH519ikVTsFYHJCx5SCqywjVERzspqGyg21ZqPe/NwD5pKdLLOb
         PYCgfzMSU2pbpRa3OuwNCP6QYUO+B2TxLFoStMCg5U19FvwYwMKAWfdhBnBUoU7l6nhP
         SMxzWgT84fMuTLSn2kc7NgxIb3/ONasJZsXG9KTlEEO/dTPkPzze53TVmexuyH8Uzyj7
         96kA==
X-Gm-Message-State: AOJu0YxlEzTxu9usGLJ1Ryi+n2NyTm7IBloD3RR+DUyh3a+ViI7Oq8Dz
	N3ojDRq8LHIW8jfLVrP0D2oh6isgqLcPJ2YvH35VQS0yGMpsChq0cRHWKL+TPlMH
X-Gm-Gg: ATEYQzztZ81AAYzHHAl4PQ/ljdPtXz73dpMXW9k98B4vMF4EZZnmPYyuKiHREsD0Pqz
	UOxjcmX8KLk2H+itr68zZtYWI1DHNQfHO0EclUJkne99MWLhZabRJ8wBneMvkW1NqyaAvmwgJ99
	o49QAIiRAKcvfKkrSRkfYbwk22j8G5Efd5ooBBx/KhUoa6CG1lZHZ4h9y8OBsYuhirljCIcV9Co
	CEbX694rrGh4casrO8usUHAUrW39tFMzjvFk9LTp4/bE/SfGlR35BZ5rkedDln9TcF2jyEuC4ut
	0carBZulFFGloikS8aCKelBsh8CACWNYfpJ8Q4qlgziAFi7T+Rl6J5pSCHskh7naPuj8VOSYC+V
	mbRUgJ8SP1m0dRpF5ip7K7ouX8wk12nyq9VpCctwznQ6hxKCEthc2pkSX9VBhgLnIrf8WYgOKN2
	x2iuejn2pbfeP0d9a/szVYoOywVEV4cw+e2Yh/C5LXfvMenKNG6VaubnUj9FHFBbcnwOUI+peh7
	WMTOsZL0rLqwqDIoyCR9dbH9r7hD1XKUuaosA==
X-Received: by 2002:a17:90a:e49:b0:35b:94db:fdaf with SMTP id 98e67ed59e1d1-35b94dc0539mr3722676a91.4.1773723347884;
        Mon, 16 Mar 2026 21:55:47 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada43329sm1424602a91.6.2026.03.16.21.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 21:55:47 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yifan.yfzhao@foxmail.com,
	singhutkal015@gmail.com
Subject: [PATCH v2 2/2] erofs-utils: lib: return error on ZSTD decompression length mismatch
Date: Tue, 17 Mar 2026 04:55:37 +0000
Message-ID: <20260317045537.9591-3-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317045537.9591-1-singhutkal015@gmail.com>
References: <20260317045537.9591-1-singhutkal015@gmail.com>
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
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
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
	*      [2607:f8b0:4864:20:0:0:0:102d listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_CC(0.00)[linux.alibaba.com,foxmail.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2782-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.827];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 52AB72A3D87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ZSTD_decompress() succeeds but produces a different number of
bytes than expected, the code logs an error and jumps to cleanup.
However, it does not set ret to an error code. Since ret still
holds the positive ZSTD output size, the caller treats it as
success via the 'if (ret < 0)' check in z_erofs_read_one_data(),
causing silently corrupted data to be returned.

Set ret to -EIO before jumping to cleanup, consistent with the
ZSTD_isError() error handling path above.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/decompress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/decompress.c b/lib/decompress.c
index fb81039..a27881c 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -75,6 +75,7 @@ static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
 	if (ret != (int)total) {
 		erofs_err("ZSTD decompress length mismatch %d, expected %d",
 			  ret, total);
+		ret = -EIO;
 		goto out;
 	}
 	if (rq->decodedskip || total != rq->decodedlength)
-- 
2.43.0


