Return-Path: <linux-erofs+bounces-2747-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOK+GI/it2lDWwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2747-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:59:27 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2482985DD
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:59:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZBtN1fWZz2y7r;
	Mon, 16 Mar 2026 21:59:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773658764;
	cv=none; b=Yk9p+sGdtCGyjnZEUTWgGvaMe+xlrggjavZ5VCJa0A/LpNzc8Jh8V4MZK2qTVB7b3OVBuRcUY04HxSx7eXkhjB+VE/6ice4Wx0I8aVotL08+1n+OS5ffa26r8aiSPRlz7Pu0toqIggmFLR4/uVYak4z60Dg5Vbbac6Qc2ZjG03LoLDYUM21b20TJmT+opAtlLBLqhURx2z/YTCCA3IDQdiixBGOku9WL/CfzlM9svoWQ4AKUGM8rh5oyAZnR81fy1SqzjRJl9fPQJEhFHOhZC/6TzTOBRByMkcQOa59hDhL8aRunLezb2wjF4OLZBZMz13FcB0QjQVeBv+UqTBuxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773658764; c=relaxed/relaxed;
	bh=DDNXGVVvRmqv86cTDXbrU8xNQtTI/VW1IJWctFWLoc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVSWSdp53M79vVINw0FzjzRnfSDRjoLNk8j35GjsSSe0xgTlhcVQZsPnzv1wlHtZ8XXla8zD3rZO3hbh3pakGaZ8BNka28zRtHdHMuSl4thD2LMKjBmVQBxnpTmc8heceruXcgHpVljJfJvHKQxCxCVjTMqpC8/CkZLM60kB25xS9r9uWwiXxkztLZrHVhOTHaOuuaOGB3K35JlwJnviqoOmucXMli9OtWdKS9OVuweVWcG06A1tvCP6IaOr7N/dJj55ydfbIkAFEG4ey/S880JYqqsqQaXz8JgPtZCltxEC+fq/u4EOU4L32Q3fXv139D9YhUSAChYxlvfTTlVEZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=laAoi5NR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=laAoi5NR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZBtM3sbBz2xS3
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:59:23 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2925979a12.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 03:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658761; x=1774263561; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDNXGVVvRmqv86cTDXbrU8xNQtTI/VW1IJWctFWLoc0=;
        b=laAoi5NRAzsfkBKXO/CWvTszEajWUW8A+rXTuLMxEdL5uWbipjnF8YNP6DhEgSWxHb
         59DJxK0VU5xAZBfkTZvhxzwl7fjZFnrV6IliMkfbgt2rOisR9V9wVzoyrIOInvarBveD
         P7fTapwSpbad2BI92RFPn5XdUpMDyd5oYMtIuHvpvET11ZssUzqljeCLVOZX0Vh8HXmZ
         Qf9Adakv1NGSIqBiwWWnhmkuzcDN6Ml7Cdsbs8K2Ev/DdfNtLAEIWW0kF73mMZJ5zWaS
         CzAaM3rF+6c++7OUPe3GCvrdkoH2bN4R248Fj05HwVAtFx9wYLfZrDZNLn25/IsqOsIB
         IIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658761; x=1774263561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDNXGVVvRmqv86cTDXbrU8xNQtTI/VW1IJWctFWLoc0=;
        b=F6zs/iOUWOMy6S0EFrB3pRET1RvJTr+eNertQAnaxDp6OJHDFCAimOX0lG8WR5vo8+
         VVSnwfSR0k6Hk7qY3sTfnaw5tuuo7flQPn6WKEmf7lQOCWSL2DbRF8nACrmb2nzvHbOP
         MuVgYPI3zS5i+XEP9fQRBa6VTx43fFjKNsg6nUTsT/DJManKhu/gRxLvlhcSLgSWgdOx
         DtgvsrZFAm5Li2m8UZ7FDWQnCYuovFf+lONmoffS/8bVCd+lpwXp4kLmniO0z+XVYNOf
         V33tgeumzhKdfAUoxbz4W1jP6OckY2wmqHt7v+v9pPJcWogd0C1O2bV6iSSkSs8YejiM
         /7DQ==
X-Gm-Message-State: AOJu0YzydmisJVKswICQJyuVdlzdSz3SvT3Y+tiRnBfI41S+X1U/Omul
	9iaeX22TVVv6KjvnBOE8mcUuXRXNE5zkBwhjMno+mN10nPHM+Ay+Y/OaFHrzRixgyQQ=
X-Gm-Gg: ATEYQzz2KXhSRghttMAMnwegCiCt9HelroMI2NCnZeoAOGY2y6R68pEU3zS72YSTlYR
	MNVEb38h7iXL7ejahphHTg9kCb03DrbIhUlyxFV4g/eUcP5Zilx/whZj34gKdMdmd2WEZ/PmObW
	wJcf9OEWt47sOAOh0lQu8Ybot0qmnYxiHka/tej33inc1YispxPqsKYFoR1MkhB9s6vfAd0pLKn
	05tCqhOr8XoarV6+qCZ6ySCTqrCSW1uSK+oS5ohCa1ES/0WvUSkohfXJ/G84sRoY1lVqEAyRK0o
	2ndZCDAg4Tkgm/t0VsbrHqPMI2IqEA66yyLPWPEjBdYA8xsPUWMG4TxhiXNTsgRObmyTWIxSAlN
	qQla9UXkHJpYfjx9vURPuJDEKFMCFlg/xMDuU9TldRH7gX19pC1FnFfSY9xEUi4IvzmzaYyMFY9
	G4tXAMeWMDu2qamPzofyZlRZrwTRKU5wuNhN6j8nH8g30B7ajUaHk=
X-Received: by 2002:a05:6a20:914c:b0:398:8a92:78aa with SMTP id adf61e73a8af0-398eca38eecmr12720284637.22.1773658761121;
        Mon, 16 Mar 2026 03:59:21 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb7f2basm8265486a12.29.2026.03.16.03.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:59:20 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v3 1/2] erofs-utils: dump: remove redundant conditional branch in filesize distribution
Date: Mon, 16 Mar 2026 16:29:10 +0530
Message-ID: <20260316105911.5571-2-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316105911.5571-1-nithurshen.dev@gmail.com>
References: <20260306085717.12776-1-nithurshen.dev@gmail.com>
 <20260316105911.5571-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2747-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: BC2482985DD
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


