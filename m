Return-Path: <linux-erofs+bounces-2748-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HObNJHit2mzWwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2748-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:59:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3F2985E4
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:59:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZBtQ1G41z2yFl;
	Mon, 16 Mar 2026 21:59:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773658766;
	cv=none; b=V7FdRtzhRUrMIHtYOBaZkHtaH+rUWW54R2PDkQhX5qorcUw6gAPetdsCoux1w3/p4h3ZGSF2DJGAFy31cPvzgrLvJLkIWitCgTQXtnhtttWOKbqAzfHlwwHnDa+sgSc1VcgQXL6z5R5ealCekFPPHpUR7FAkg3sJHccxP/ovrPyMGMt2sjenoRayPb2tutLlk5MVaMZMTrgVBINqfETnmdR+XS6JrrMEWPx1hTJ/UrwR+XRXYl2D7v9td2sOTzB1K7w+zj81MVuEhoGjkl1Sc6r3UyoK8DkqDjR5Y0D0K330LlSE1KKFnIKRmbKY7WdRpD9EFwkUE1FzJAgxmvpRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773658766; c=relaxed/relaxed;
	bh=lH8vlBD7OXb6PzT/zvffx1a70qG+1+A/SkL4u81qX0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMH6Vp+UCW629kJYsG2ndEa/WzsEZPY9qkDK/GRrHs7Mu10x2nF3Tzgurqr6nqim+Lj03AqCC4HJh1N/B6+uLBcFFP/0javsBm9aMllpTv2NptNrOWwc3oRZ9/8zZTLQn9Ryz9dkiAtbdcU4bU2OrRpNnhrM5cgIw5qUEBZTolLDacQlmqj2BT6PjnX+mXHcjdGYljZSz4PMGnpfUOfwDtlMS2FfYbAw7RjIL10TnHNG9GzYmx4e50O98XLBq1GTaa1pLZ339FfU9AKfHnKzegkOwMq81rUe891kso4WnzGGHfX7zW+KQVqgPR2EICQfbFR6pNK6Uj45yfCNfWP83Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PDcnBJR0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PDcnBJR0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZBtP3vmkz2xS3
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:59:25 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c73fbdd9b53so402467a12.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 03:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658763; x=1774263563; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH8vlBD7OXb6PzT/zvffx1a70qG+1+A/SkL4u81qX0I=;
        b=PDcnBJR0EedEDlmkIruOjKomGUPy+6dr9x7L5vLPWiETkymVtEmNbE9hpVV4WhxTZn
         RxOmqneM8ynU4tfG3dBGIN+wyafF9w2wZC5NMRVMNON3nRIIOrKF61J+4J+u0tiigUjK
         3oFfcopIHdpghPaqVxj4yDfkheLFHCXBovow784ZCIixNJvQ/0rf0FJyykQc3KdT2W8w
         LEYg5EX1qrSCjST8lDNJC/tezPI0sOhFkiJ5ioYN3EJLPmWkui6K4Nvn4khTcO1Lpqiv
         jcjoUElwk3wRUeG1jOCARcDQ8KmGH9g3aFX94ODXIbAdmhJp+SuZnXLXKW8IsZmG4n2b
         3Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658763; x=1774263563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lH8vlBD7OXb6PzT/zvffx1a70qG+1+A/SkL4u81qX0I=;
        b=OWxVr83NI3KqOLQyADiQVxPXUvxwghhH+AmejmTsvSXztpZZ5hvNXCUuD3q1llv9qE
         QFsS128FrBPlSCXkJUFoyNCpIr8oP0wiAspYgrQgpst1Feb2WO1odVjHBeVtM5TLDTi6
         TmSnHJ/Wl6tRNydMjnTCF2XtSL8Lpqtzvm/8eETtxkMutdrXsWWxWR0eTcm7FhYrimLE
         SdCtnFGGYlcwHQyBB/cPR5vtKud6Rcuo9PtDWTbHBAwNzirVwVX9p35HXnOpcMyHG5Jm
         IqkxjzjTF267d7gTQNXqO16u3UNdMg+fgnHJhFG9KhRjltmzGpneZAHnbTfIhxQ2TBoc
         ZDng==
X-Gm-Message-State: AOJu0Yz8XLIXsc2V0loD45P25nyQpSlu3LmL8Wtd2B2kEk5RYQF2MwWf
	E1nRHhsJsCbonX27uXgEiCFHQ7WWbBcKCYYjsI0jlDp6hriyuYpdlZXdLhjKDPa5vIU=
X-Gm-Gg: ATEYQzyyohM7JSUHMo41hWk7JbB8ZNDij8xUihfF7jrxpyfBnVho4vMWld5APtdexnH
	JfqZfDc5IQt1iJski30a+usZV4AcvpLn7odMH113FcWXgb8JJllgz1jgp3pUpnOWfubAE4aPsYf
	vxFnDlOj4JX3ZJ5G4GaKE3ez+bzkiP+hGEJ2M+/EziuHUOi6WKKK175Ugjd4PRALuThDE2EURUF
	dz5nZ4pj5calncAEqBcVlHJPzSBVNvP7LPD16QgaxtSTxOWmMmDi5SLt6NUcb1JuXtaPeCQBUaV
	64sAr0NNK90LBWR/M6MN7euUzC1Y01tH5XSUsibEp55qXMeyugOPC/7BxOZ3eiWGb+APFZ4s+7F
	DPJNxddGbqwBG3Qic4BjBIrlMCygaLJg2iCRyyiciwVfnSLTOcXQG0LGXR+c0pdKZqngrYBSoB+
	piW3gopgDuaErWw9Rzut14dp0CT03M2/zRIFjv8Kts51izrB7xFNo=
X-Received: by 2002:a05:6a21:6003:b0:398:7ffe:472f with SMTP id adf61e73a8af0-398eca24951mr11615633637.2.1773658763404;
        Mon, 16 Mar 2026 03:59:23 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb7f2basm8265486a12.29.2026.03.16.03.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:59:23 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v3 2/2] erofs-utils: fsck: add warning for unsupported file types during extraction
Date: Mon, 16 Mar 2026 16:29:11 +0530
Message-ID: <20260316105911.5571-3-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2748-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: ECE3F2985E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When extracting an image using fsck.erofs, if the tool encounters
an unsupported file type (falling into the default case of the
switch statement), it currently skips extraction silently and jumps
straight to verifying the data chunk layout.

Add a warning message to the default case so the user is explicitly
informed that a specific file type was not extracted, rather than
failing silently.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 fsck/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 16cc627..16a354f 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -963,7 +963,8 @@ verify:
 		ret = erofs_extract_special(inode);
 		break;
 	default:
-		/* TODO */
+		erofs_warn("unsupported file type %o @ nid %llu, skipped extraction",
+			inode->i_mode, inode->nid | 0ULL);
 		goto verify;
 	}
 	if (ret && ret != -ECANCELED)
-- 
2.51.0


