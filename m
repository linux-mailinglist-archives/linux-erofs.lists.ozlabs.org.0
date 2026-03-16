Return-Path: <linux-erofs+bounces-2742-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cjRUBw7ht2lDWwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2742-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:53:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A58298429
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:53:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZBky3Nhhz2yFl;
	Mon, 16 Mar 2026 21:52:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773658378;
	cv=none; b=eE6uQmm1CE7yuRxdOm2lihJVEfToFF8LyMfOjgaHux3PlSA2otLpgVB1LZmjsakhpGfi+FvYkVH9UaM7YyDw6OhQiyVsgIKWb7TFWf3tOQZd7WdNj/1nsAA2TukC2XYNcYQtaT5lGeGm6X7JaHfjEDA8LEdDnvSJ2lux398SjVF0Emj3G38wuETCtbHQTCCTzpvcy6QLA7ZFE/KqtIVBd9F0OcTcXAo6AEUmLCTeji0vEXuaPXg6F82xq+hhrn5LvbV1a+FDqw6HP/ROQP7JL5bkjkjgeh8EbpWv1uqnON+7eKInOCiIrDqYUfG/WOD9OT8Lz1EPLfExkd2TIIwuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773658378; c=relaxed/relaxed;
	bh=DDNXGVVvRmqv86cTDXbrU8xNQtTI/VW1IJWctFWLoc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aax6m6SbDy+ztOTJGqE3pyvms4MD11bIFGN+YSyQYBCq2Z2m8gE10W919kcaQZv9kwvuyS05uKOL/bEU4iWvkFkL9FPWb2EtcCKuNa7GIhrucf+CGtO7kDfD7CbRn1XfnaH85oxffrywiXqcox5pm1v9dGqCiaPuv6a4kZdlA8SzZApu5EsxScviURCNF34QUXVITAf/X8j3MndClkso9Hr1xRq1C2icQr9QAeR1kpU8LXwZG/wJtjkJi479obPpLzbQXezDE3df3Fl/vu8tI72RkcjpVQAHrMx+RpYYritPgqb5foeZHcd3NHnR3gJ5lEyCv4FwFO3ohItiMD+LpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NNtaCsmr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NNtaCsmr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZBkx64fGz2xlm
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:52:57 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2255768a91.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658375; x=1774263175; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDNXGVVvRmqv86cTDXbrU8xNQtTI/VW1IJWctFWLoc0=;
        b=NNtaCsmrirBC2NipqKtlAgzUao1afn0YmUUwY1rERjrz4xRGPFdzZbRM9n7QHUY34H
         R2Pd9AjvzINwZvzGsHOEO09LKrfH9uNJvJfLtfIUbW3T73iINBlyQKAti6XGEqQY9x43
         L0c5FlFOWHqt4IISyUYOCF6UmnZ5e5U3rr6l3oWU7/W7e1w2pGLQkfi34mu6cnrX5LOQ
         1EyFkbgGOM1HXorFoEdvfjqwEAm2ftrnmy3PAnHJkdTm/hdIEcjlXQ3EHmrHx385AUkR
         s++2lRfBC1T9q+57TeOh+vgR/TOEPu0Kp0vBuYkPBa4+cguTT4yji0XFqXT1e4HZnJRt
         3tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658375; x=1774263175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDNXGVVvRmqv86cTDXbrU8xNQtTI/VW1IJWctFWLoc0=;
        b=cTAHlpmBKrXiW+x3d2zJHendothwRhBmBuO8s4GbP6r5H95mOdeKkgKv+Bfb8MryHx
         rSCVCQ5C+HQcCAbhJJ/o9Z4MQyUOVMMsf/U/JCezIj8h09CC5blXww+vl/B7ZUXaIi38
         QKKuesfHaRDcFlXVwsvzzdpDcbWbj39h8A1OwjGTnmYsezmLQmve2NQO1Do+YbR1rPqb
         LMRt1sPcNgrGJiVGxopg0x0VoMGX0D3btnQnmXmdG9eZtqxJIiFn52loYC871qbAmDIs
         3mdgdppNjAqo1J7s+ehMBSjasMV8KwsFCS4O3qDRKHqUajjBdlnzDBJFMy+b/co7Bm+G
         MGNw==
X-Gm-Message-State: AOJu0YzXo3qI2iKkZpoi9EGeefZ2QLyfMRPOheayDJgj53ATwIr4FwFG
	GIT54SWWEaYa8t5LJggxn3746ivItqV80iDHT5pg3kPnlMiXkwImbKj6JH8ttxOzrjM=
X-Gm-Gg: ATEYQzwAblTKUO99sLuCnJDmq9AlupnpNfdYcC0539c94P//suyk5wnV4vwahSw2IDw
	WoKo1OJb5u7W8t2e1dOBYnEiY/wEM4srSa9Sjd6JazB34sFpWloFTpdec9OJTpSSrWuW2UFC9vq
	dDY2YTY9sIAa8h5tp29UWOemio6k/pkXCNQjXtJe4bLUZXoQRPNuDex4cm4zdGllZgqZLxaTPuO
	rKDSMSHHQOsywyKbUjXRoK0JEH5d0bnf6hwURkCeFDRv2qYCDTejbHgPVsU/vZAhQjAptKEHUhX
	hQruYYCR1Jxz8lLDiXDTF6avIonSDQ5AFmdq3S72l1a5hvduhJ7HPaslESIsuUiInarcGA4Kw8d
	hgj3B/nKhEnMN1jdSO53CAFz8wSyjhZXzGenbCg7fpKKROwxKA0P9+Ey9w/xTDAWZ16S1U/2MeC
	t+1gOGw26hsiwMmQ2F8YAeqG/wJ0URMHNUT4AaFLz1WPBbh5FLrYw=
X-Received: by 2002:a17:90b:4c4d:b0:35b:a7be:ae6e with SMTP id 98e67ed59e1d1-35ba7beb197mr898081a91.33.1773658375526;
        Mon, 16 Mar 2026 03:52:55 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b94e8baf9sm1693569a91.13.2026.03.16.03.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:52:55 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v2 1/2] erofs-utils: dump: remove redundant conditional branch in filesize distribution
Date: Mon, 16 Mar 2026 16:22:39 +0530
Message-ID: <20260316105242.6894-2-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316105242.6894-1-nithurshen.dev@gmail.com>
References: <20260306085717.12776-1-nithurshen.dev@gmail.com>
 <20260316105242.6894-1-nithurshen.dev@gmail.com>
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
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2742-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 00A58298429
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The logic for printing the filesize distribution chart in dump.erofs
contained an else if (i <= 6) branch that executed the exact same
sprintf statement as the fallback else branch.

Remove the redundant else if condition to clean up the code and
simplify the logic.

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


