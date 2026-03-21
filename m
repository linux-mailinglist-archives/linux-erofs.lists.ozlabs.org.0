Return-Path: <linux-erofs+bounces-2905-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HQ9uJOllvmk6OgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2905-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 10:33:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25302E46C5
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 10:33:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdDks6Zt6z2yWy;
	Sat, 21 Mar 2026 20:33:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774085605;
	cv=none; b=E8m8eUIEE6FG+yX2IG9+xTyIKWogiXiYGXm2sFmZkq49pfV4/KNiYqXSsMJibHvEMe+U0P1++BXNm8bKF+uPH9td6SArQVwAwj+zDwi1KY50grDE8dJzzI2yUGEK73c4d1dTJir4IN02mVOKUDJP6cz0nOjENStzxnC5/EXuGORzvYHm4UFMdhkX7+PI6hhBZVjo93TIdl4TPTeXU6adKY922R2e1gNZEWcil0wCBzJZt+ShxesOlAEbNOjdVlYv2FfOjq9xGTF55kV0LgBYEXC8zgIBxvfKUYIaIElFem1lbhizR8MU7qZv21SXbzseLCJD+AZjicvny+PK9q/GBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774085605; c=relaxed/relaxed;
	bh=/guxSwCRNlyNtMd4HG+BYXoOwMa2RgcoRlT72n4F53Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcCyH3S/ocB6ky+rK1Jq3HWvuoiBkVbPXB8Dsf0fXgBWDA6hSSuxcLzQiOE3lRXyKOwpmbdgYgrj7Jtsg+jUxWf7xy6nIzw9FwC4iI1ySZk4LGUlyOovXfu7KpE7RqMUDYCcN1Qj9k0WdRlwjlYk9fF8oLxG6i+FdJXoPPfVe9X7vwkRmcPQqUb83ZbX4Fbjmir1kVZPhoQ9SA7pj24Baqiqj6TLI7jQR7cvZ2dVvXrbX/b3BkeeuqQbJkQJVJlkCr2fYx97btwJ0SPTbmjATAUvqDaY9vSWRt6+Fan1JijKrW1K5LFbEvGc3/Qd684xCKoywtpndNNKZFRTg1TYAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UNeXF4iH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UNeXF4iH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdDkr4K28z2xKh
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 20:33:24 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ad9f316d68so13494935ad.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774085597; x=1774690397; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/guxSwCRNlyNtMd4HG+BYXoOwMa2RgcoRlT72n4F53Q=;
        b=UNeXF4iHn9Oz+DNz+fiN8CfenT3+1tiMPyLyhi1voUA1f3SUo0Ax5m6Nn94qoyN66s
         93JixKJ0Lz6mqcO9qV/PlXHWk3TJYZCx2WY6Dy8VSonFTRWAvGjkJUtK0xHaW8HUiPK1
         O1fjY4xSfhiHmVLDUYTJ0/qKZIi7lArvR0AJ9xbg+BIQhgA5ZJI6m6bIJJUZX57p8UvG
         orY8JXNTVfyhOfaUFFMI+POEM6rDWhOocT7i3zY0aC6FkOM2SC85pDqLTC8zGijD0I/q
         h1efJxF8KYLDm7F6DdDFaXjPjWJ4UovFwkqlXB1G3un+bmL8KeAmQcN3SrsAH414hfX/
         RqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774085597; x=1774690397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/guxSwCRNlyNtMd4HG+BYXoOwMa2RgcoRlT72n4F53Q=;
        b=hzQ3v6mO55EB/sTUtVbDSXrSeEzEzw04QnFwq3m2825P8BtdoRHnRARWXntT6Yy9WR
         6R9hEmCwM4pQqnGyugXlKyPt/DlJJqF1JZtFgdmr1gmgu/HtbUp4UwCn9xRHoeTW+0/z
         bWNxvCWam9PC2NqwGG8py3HRK8byZjLH9UoIxXskbJJwe9dnee9ybTZU8YskxGvlh3ek
         reAA/ybCDdC2nGZtZcxD/2onRTxWTN9TeH9Mqts3xOIJHLkdJfqZVgsCLjFnJDZRXpGm
         YH3KxWP4RqQw9owicoivdCwzE94Nv7LGokeQKiMZTsdmTw2kIOK4j3Pl6/uyit/midRF
         kkIg==
X-Gm-Message-State: AOJu0YxE4TF5Sm4A2JkfhLtrOz3pfNe2rbIgEb6/pzd1xxNSRfpNcvqh
	ucQ9f3XmoolhTDWpKKnhYxC/1e8M/iyBBWmkc77BCVBwfjaKiq+oV5rCyLOXrQ==
X-Gm-Gg: ATEYQzwdn0NOVphcc3/EgQciQU8Iitlp5ApVovdMLh5t2yUEyBi0GPB7ZHA40ubuITj
	3lNksu9+b6/2sGecIu8UOdkceEaD9W/WnQIVR6LaEKFKqHWnQl0S5esoZD2No0iuiNAwVDvuZdD
	0vo2eCYEQweN1pbfKMOTKxPHaWT72zmolHqAodu8hTtHVxteeQvnptAoehFQBeN4wa4SHS64iLR
	gNvM/912n1aabVSRYd8XdWnvMkdZ/VEzvktcKm/ZBrDCUH3tBHUBqu0F4RWvsUmKBIYRnnrXMEk
	AiniWhufmtXNYdRLFsE3Y+pXssaDY2BPpjCuED3zBPZ9uFAp/czsreulKXId3WzbB5Rg7wJsRIE
	9BGaGrGvxhEski8rJbu1mQ6RdZslBPExJOOtRrr6CLChpKouNE/bGJq9hOCLWmx/CkBxntZylSm
	9y3Nujhxzi8e2647Ohj7DAQH6gzWAomsEGQu9YjQPYv1mA3xKdlg==
X-Received: by 2002:a17:903:1250:b0:2b0:4de2:49c4 with SMTP id d9443c01a7336-2b0827c8dbdmr55179395ad.46.1774085596819;
        Sat, 21 Mar 2026 02:33:16 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4081:8886:a7dc:65bd:726e:c12b:67e7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08365a62bsm63855065ad.46.2026.03.21.02.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 02:33:16 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH v3] erofs-utils: lib: fix gzran builder memory leak
Date: Sat, 21 Mar 2026 15:03:04 +0530
Message-ID: <20260321093304.1701-1-newajay.11r@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2905-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A25302E46C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When inflateInit2() fails, erofs_gzran_builder_init() returns
ERR_PTR(-EFAULT) but forgets to free the previously allocated
erofs_gzran_builder struct (gb), resulting in a memory leak.

Fix by calling free(gb) before returning the error.

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 lib/gzran.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/gzran.c b/lib/gzran.c
index dffb20a..8a01825 100644
--- a/lib/gzran.c
+++ b/lib/gzran.c
@@ -50,8 +50,10 @@ struct erofs_gzran_builder *erofs_gzran_builder_init(struct erofs_vfile *vf,
 	strm->avail_in = 0;
 	strm->next_in = Z_NULL;
 	ret = inflateInit2(strm, 47);	/* automatic zlib or gzip decoding */
-	if (ret != Z_OK)
+	if (ret != Z_OK) {
+		free(gb);
 		return ERR_PTR(-EFAULT);
+	}
 	gb->vf = vf;
 	gb->span_size = span_size;
 	gb->totout = gb->totin = 0;
-- 
2.51.0.windows.1


