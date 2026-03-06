Return-Path: <linux-erofs+bounces-2529-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEArGQaXqmnJUAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2529-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 09:57:42 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48CD21D85F
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 09:57:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS0fW0D8dz3c5f;
	Fri, 06 Mar 2026 19:57:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772787459;
	cv=none; b=f/sedcJDDiRMid9Le/4l2OODjgTvN2YcUUVo7hKx6MnpMSrYXALFPj2mPTIaJJ28Gqg1K6UshRouxMrF+SbauAy6In3rSnrgD8LC53gp/DRIgbQO1svjJTtOTQjnthbNneab/BR1F33eX6kaHtyzG2gGCMFgXYG2ceY6yQEt12TIaZfN47EZtcorSanZb/AT+Tg6tB0gA+7hwIsg4/JdbmoHnQlbEpAwOmTk4i0lv6Qu9LqW1rdWPmdR0nKlpwoFIXl7ahuKp6xRulnDy2jMMBDf+U9BVIXpak8xAorGcP+RzQ/yI/Tf3+6R7mO6s8qiKIbZgvYqCBEdFlbvxVMGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772787459; c=relaxed/relaxed;
	bh=d26g9qUGClymG7vagLdb7C3RciNtFptAZbMuGRkBYcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=am8ghBqG/84jde9EJJe4/I5SgU7vo/HCb6ZJLmo4xr6zsr2nvdOxg+87lNEHVZwq3Xe0o8P0pMSuBPKruN77T/p7Pc820heehzbP9HBqnXu7cHywI61qf087ZLjRlL8vgayJYh9AySBBYXO+b19w1EIHdb67surKfdHvDSUzshngbQXoyDUVdW9YmyLZsUhPkmevlp+tIxHknyChOnCxffWE6vb8PHi+w/9NKJRPjDTbeRjP8mOFcu9PVZ3bKHfiLQbJkuCeIy00aJbEVtgBstBmunAOn5N7bzm5eNPCU+H8nTXM6ZQLkaY485xHdzg6P5SAKbBJw+QQo/L86NhtJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DEVLG5Bz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DEVLG5Bz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS0fV2KLWz30T9
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 19:57:38 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-826c49b7628so5683720b3a.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 00:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772787456; x=1773392256; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d26g9qUGClymG7vagLdb7C3RciNtFptAZbMuGRkBYcs=;
        b=DEVLG5BzrkdufUFhaRHb7jBOCBVrZ1KYnWfoi87ZsVHx1mnpSDzy5a0PZE3TE2hmp6
         qWfVfyk5DBOGNJJIndpkTiAO3s6tByCFGIdFlT2E890xA6NF4EgeOR6Yei147DZuuWL4
         U5H6a5sVBPCg//G91DC2omobOM7lZ6DlplteHz/mKoza9u3d2dhpN1X6Ilbni2meC0Aj
         B1oRpXIgrPMAxiTP9Q0DBSYnJ2gyPEeEiUhB3RL7uybfWr5qY5NhxC7gybzSLg3Fmhrx
         vUM4syKJL7Mgr9RjMRjKauG8VTHZQV10owfkyv3r3JzSDxHYEvw0gQ32zuKcCKZYJV4f
         HNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772787456; x=1773392256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d26g9qUGClymG7vagLdb7C3RciNtFptAZbMuGRkBYcs=;
        b=HbZMkZdcsnP0jStAzSAL/TT+JENqq7jjottTeK1wfAX2gTx+XnnfWzrm/QnvDE+Cbw
         UKrJ5VZJcIygMibsmHnxUXhSeAFx/wbOX4E3iLR306RvTyjg4hhx0YJ0gmlK5Tt/ADQ/
         Lx0kQq4zXtjAR79O4oKRwqgF6ovkoLOyvSwUKSlS/1r0XPR37fM77FGiBPi0I3n6zqNj
         POjDyBamjE9/Iq4jeJK+b2/huu3BbBtSm5yb4C460QhHEGB61g6/msvp11l1clnmNlkn
         eCWg7k4CkeRV07oaYgBl5g7sAzlahX/UMenDv+YSfAkofOm36NfmoHES/lRR7kqNyb/F
         RLNQ==
X-Gm-Message-State: AOJu0YwD5/HILsiV9KRzWDvaOKmfLMv3WHTlM91zYhmomO/aO5FCeSht
	BW727Hhp4JkDC1V+6eu90CQbOoTATEfwQW+kZcclwBRIjKS1ZRIQ5uajAp0nmC9y
X-Gm-Gg: ATEYQzyHsuPBIlL4AefptxotLL9Te4A/mp91q6CWcGHBg7hSz8NvHgN1pE1/ulxw2WT
	WMFTjN9gGIjIVfwdmxOe4k8xzWTOajok2J0dzkpc19sAgZHP4hVs1/92ocaG0q7TzMt6VLcd327
	OpJZv/lsA6UbIwHio5WHDTNXfOWVYhqx1T/IZTjpRWSu9wRytuTnQVUvouF6v29qIQHWsIxySSE
	wSfcQ3T8wWq5qrOi2a7nQzuMgnl+SjAvjfsnJ4uxl7aDB7Aaant7ax6uAKgaQKn/8MDhlIp5uaC
	Ny3kUWw/VwsUU+nQxngzUvjembqJo+W5aFkqQgDSF0Dk1TIwnlZjK5GR90RA01SkIsxVsszCNHT
	XCpMiG65Qmna6z3X6sddwN1k3huYyuocnx0EZBVKtY9c2xTBvdb6BvWOvg5PCJ8d+yrioTMBnFg
	cboShSvkIIUjC1DIQmeZ/KKSfw+EglkXhuzk/C6xawc0DceUY=
X-Received: by 2002:a05:6a00:4511:b0:81c:96b7:7faa with SMTP id d2e1a72fcca58-829a2f4fa0amr1402071b3a.41.1772787456354;
        Fri, 06 Mar 2026 00:57:36 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48b406csm1175294b3a.53.2026.03.06.00.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 00:57:36 -0800 (PST)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH 1/2] erofs-utils: dump: remove redundant conditional branch in filesize distribution
Date: Fri,  6 Mar 2026 14:27:16 +0530
Message-ID: <20260306085717.12776-2-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306085717.12776-1-nithurshen.dev@gmail.com>
References: <20260306085717.12776-1-nithurshen.dev@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: C48CD21D85F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2529-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

The logic for printing the filesize distribution chart in `dump.erofs` contained an `else if (i <= 6)` branch that executed the exact same sprintf statement as the fallback `else` branch.

Remove the redundant `else if` condition to clean up the code and simplify the logic.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 dump/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 567cff6..78c50d5 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -522,10 +522,7 @@ static void erofsdump_filesize_distribution(const char *title,
 		memset(col4, 0, sizeof(col4));
 		if (i == len - 1)
 			sprintf(col1, "%6d ..", lowerbound);
-		else if (i <= 6)
-			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
 		else
-
 			sprintf(col1, "%6d .. %-6d", lowerbound, upperbound);
 		col2 = file_counts[i];
 		if (stats.file_category_stat[EROFS_FT_REG_FILE])
-- 
2.51.0


