Return-Path: <linux-erofs+bounces-2530-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF2LIwqXqmnJUAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2530-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 09:57:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54C121D866
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Mar 2026 09:57:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS0fb3Tq1z3c9j;
	Fri, 06 Mar 2026 19:57:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772787463;
	cv=none; b=FlcRq0y3oRBHf/Y5x/cxf/w9G6MaaFlid5GQQEASo8heBKTD+q83dDZJUQZFE616HwTnPKZCDlppZEzB1gb5sVZ45qfW1GaSELWKVPO+IPVQn6cbfmbkz2OH0ElmkyB7/SxQhwo41vzFFvlL4tVDYG8rYZ2JXqSYOZgIBdQZAGRJkjARb/oN06Kwf6QYCgs24ZaymVUFTM3aCdJyBcbqg+qsGC6QS+tD/D1BIF3d3cFPHblfjIAPBTbKf8dOICC3PxYywKEg61K4lvJ5h4oDuXzfEAy34MCno5L60XLi/2dvzziyV+LHJea2hBZYxLuUVPtZOZambAkVl5GTTxn6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772787463; c=relaxed/relaxed;
	bh=nOy2INI4KU/H9jgqMOQSD/SeiIe5PhzGz1ueJzs8S30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4RwFV1cLRk2tfQTsESZsRGjcnopYCS6dTPD/fPJtc2xM7mHw5Rzk4YfU4AcbIUVKKehJMIF9esjylrxIv/g2UbwYPOH02c8e90c2EAPaR/TwIrMIuSk7eRr1ukpT6GHzVsLtPIRLpBEfVstQlhyrbMVTDAITUl5h0tjl95BBRqdIux+mYbETJdKKTpk9Kx7czbZico3GhBtV5hAdWMqDA2T72NVEGGFTmUR2xowQRpW1Ypmq4u6HY6HdqBrG3m8g1y/aDQIxNbtoeCEz8uE0IIsxj408xysvXfgEQnnBirbEWL7U1ood4yR0/mn7W9+3Xw2VnmXofz2TLintouzIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P+1pHht+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P+1pHht+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS0fZ52y6z30T9
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 19:57:42 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-829756f3ee9so2556381b3a.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 00:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772787461; x=1773392261; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOy2INI4KU/H9jgqMOQSD/SeiIe5PhzGz1ueJzs8S30=;
        b=P+1pHht+NRZOv4u+ZYfzODdYgh+/IuVHaZLG2nX9r7rNHNK4J1iqgrmxehGlXCTBBS
         nElpYLh1P9SvK1BO/wbH4PkpWL8cDsPXWJ+a0sKwLElPepgoAiaZACYTDVS7C5NMcPy/
         qVLZjKIg5mi0TyDZAH9CM0kufl+JnXhJaadDqq4LtGny3eiO6Om9kdiqqeZ8ULNVX7uh
         uq2JOVGg2woV5FnLjqCajnLc4rKksIoXSwyS2jc0bVeH8lxy81B2XSQgve6kpU+4kdKF
         xidwiNDKoTizKdLc5Zbdj9gldgEkaSxpNEJLVwADx0xR8alo9ZXNO3jshTACeVwqvz8L
         SjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772787461; x=1773392261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOy2INI4KU/H9jgqMOQSD/SeiIe5PhzGz1ueJzs8S30=;
        b=N7unlgQqGKwyuH7dmMHfFOx4nf6rLdv79FQhsLxrkzvmmbMKoZLbDM6eB7aYpPA7BT
         IyWseP01NA4NozsetWtEUFrEdN9sj58LYbe3ORlBpQPXC7nKIJ2V+oYdK5LBuRP3GoTZ
         xMPVv76uNiCLMuq5HnClX5qLyjU8qZJnw3yjZnjmMBtUCvmIY/YFRUAL98GOgD1Qj90I
         j+MDlmAQhPlrTbIv0HhfEjJ1hK3FRAKvUP8YnFmPpaEoVWa3sL3RDL7rE/0SjrMEO7SQ
         aheCs7uXYAUXl/e/mkMyUt+RqD4TWefNBodQZBld2XSmAY/6uBsM3B1e45LIFIvRUitq
         xEOw==
X-Gm-Message-State: AOJu0Yzu/NmP92OT2Hu4Irz9UgoPrpSD2OpuJS3pu+gMomLhVMo3asfj
	UGFzNuuurJtqoGvl/TmW7uTfatJ8xsgDHdJdGuy3NAdh3WXIU3rxcwQ/OMjo3Zp4
X-Gm-Gg: ATEYQzxC6ZJRHdfBWm2tM1WlobAeVDbLxYN002jVZbUzqrYDFdR+3BRKbkcw0FiiX4H
	zzr2CNxgBHKvUl/8YSXWjSULCTpp/1ABvqrKaKsTFt/o9Iup9VlYa9Pi4zCa4m/P/umhWOU8N91
	z/YzfDM9bS39AG7t4QdgVhUENi2kie+YAHcJnx5kzlbPciKdJUxDUJ2CpjG65vAMt3ZyP+bE4GY
	CEp9EukGNNw7q+DRn/iuloo3W0UgJXF+N7nPEkjW9bG7dVuvKBZ5G2FPVJTLQ0BNwEJIUD5WYyN
	IyDe0jLNmPKzVYbwh1R2bhc9vxeIjNNtEaXdCo5vzlykaQ3QCK9X6HZLvyEGjHgxrOGz7R/qIUQ
	nQJ1YpaNwVeFkMLu/Mw89K8MAUEEobcodsjN5kcYagIKGyxIVudX+kzZAEBjvmgkwAUbBiMfTNh
	cBs+LQjd2msg26ZZ6Xr2nEXnqAdBk27XQAlyah
X-Received: by 2002:a05:6a00:800e:b0:821:8492:7f73 with SMTP id d2e1a72fcca58-829a2f7d4f7mr1398706b3a.63.1772787460835;
        Fri, 06 Mar 2026 00:57:40 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48b406csm1175294b3a.53.2026.03.06.00.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 00:57:40 -0800 (PST)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH 2/2] erofs-utils: fsck: add warning for unsupported file types during extraction
Date: Fri,  6 Mar 2026 14:27:17 +0530
Message-ID: <20260306085717.12776-3-nithurshen.dev@gmail.com>
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
X-Rspamd-Queue-Id: E54C121D866
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
	TAGGED_FROM(0.00)[bounces-2530-lists,linux-erofs=lfdr.de];
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

When extracting an image using `fsck.erofs`, if the tool encounters an unsupported file type (falling into the `default` case of the switch statement), it currently skips extraction silently and jumps straight to verifying the data chunk layout.

Add a warning message to the `default` case so the user is explicitly informed that a specific file type was not extracted, rather than failing silently.

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


