Return-Path: <linux-erofs+bounces-2897-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D3vHBM6vmlQJwMAu9opvQ
	(envelope-from <linux-erofs+bounces-2897-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 07:26:27 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0792E3A77
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 07:26:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd8b114Dsz2yZN;
	Sat, 21 Mar 2026 17:26:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774074381;
	cv=none; b=mVH14Z72Xn373AjuEP4UhflCuSd8XX6QWgZkybxpW7dqTJU4LBL/2BNXCpc2t2B1lSP07N2aXugF37vv8F6xl2YKTq/JoVwb9JRyF98xb056BFg3CMYOBoEW5Xa1nSqI3O8EMt5yUMRvE6oX2BUbw7iwQNjrb9poXtzbZt7+jEge3GsfnoGDjmguj5oedM3lQEMrHRReCkVqWUQYkmzQeqwhk0dTkcoFwuRVUlLI41rWsYkgmT1DCuxrqHgGmM6CMiLV2kg+Mmomz/xPbEMJcZXhag/+6k7zYQ5hgcSt9NFf2i1D6RVr1zXljXFvHfo79m0wL26YC2XZOmJ1HCxLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774074381; c=relaxed/relaxed;
	bh=xtwLobBGttdbWjfmt55Nr0iqUkGqScPjIY9jbquyl78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8He6/NoLda2/iNjykEf+Civ0liI833tqsvxrUAVuO114x/eQx1JeEuKkCCED3yihihHvFPs6uXxTe4oW00rz6TF8QV4yrb6sFR6n4rxVyDERZvkhAZv+VGVmNW47qipigsZB9S5kgUcihB+ZiQqZM/WzF4X9qj4E5eTPR9nC4W11Bw6JqwFe5drhYN/SxpiagQOrM/3mLKI6vNJPI1XTPrQ0KH66m+uZAggvd8Y94T/L0c5wE20gSnUqNLw2L4ud5/yQnAVrZXKfLpoB+AsRCjtaFNZlWReG9MVqC3YAkvg1uIK0LouaJFJVNwffoUkUEZU4dnnAj8VGEeLUEV8uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XbAtyzSQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=XbAtyzSQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd8Zz1R6Kz2yYq
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 17:26:18 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b06c43e6a7so6676325ad.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774074375; x=1774679175; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtwLobBGttdbWjfmt55Nr0iqUkGqScPjIY9jbquyl78=;
        b=XbAtyzSQR+FNk77AqjJ2Sry1d/wOPv1dzflBWg/+eslif7cqNXgM63z5Yg7iNLYZQZ
         liqDKxTfPbufHtLnDev0XrjnSa6E/QEgvlEaIeFwiEJy9Pqmu2pXysCCyU9JDtglQ9P8
         B68Qg82ghiuVX3SyAAInI+1v3yiD3OPWGyxryjnG790cwIEm5Ki6v0ZT1rYUcFHVyKN/
         iCVn9rQU+zCyiPYryuD9wfWezuqk1hFs7nPvcnnEgbwGasxynrbVUOJ//vP1RwPqQvOF
         whnrr+2lrW3CDhiVgqfLNubm5CC8lOuq0OvrcruCio2LYGnTCgMvMdzxb7ShWSpVCyr2
         UREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774074375; x=1774679175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtwLobBGttdbWjfmt55Nr0iqUkGqScPjIY9jbquyl78=;
        b=rKSd7UbpIIJUQQmCTN8x687SIOTNK+TJXs+6QqRqr7wZaLXqNdupLpq0thzcznMyZ4
         vbWO/1UMCWwGlUzzNQdeVkSSZzzAido7nEQyxOJc59mVwi9KnIMjVpc33nIIZriUZqRC
         qQq6LZYqYua71fXVk6RIbaEr3YxU/SLnK72ac3KyU/HepgyZOLUKnwxV3DpFJKbR/vHD
         laM1AfIPOV+N4P9iPQNcdwa6BR+WsYF38dPS2lW1R+glAKEhVKYANIBvjZNwPlP8OtLR
         h5OBLOmNCihhseO0LiaEcjc7XwXBftR9fwpmBnY0iNhwCJslWtxEi02k0ACGFZUIHHk/
         kqXw==
X-Gm-Message-State: AOJu0YzaR9uvF09VnQDzZCSFh6EmWb28X2zKeqnI/viLZe5OQOO7Fu8u
	WKHT79SXrJyzv8+U+Gy3XVob31DKGgMf2URpvgHp989rYuxbSXx2vJZ0SX5Omg==
X-Gm-Gg: ATEYQzzuIdQo5ERYHqiIy8Qiq5w+xFhQzl237t31uCRXH0F3GzNGjpJvi0AwT06tDh2
	h2seEyFKXAIYEMejzYEn/z9M60QpvzSMStZbIwZdUwC4ISmkdLlclPEgy+0x0UrifVjB7ZPSAzn
	THleaSQdMZ80SFIR6y5AeN2aDJ/uArgEKVlWvEv2YA2U/F6ntaHK4Fxxzw0uni3fY/+L+E4j9D3
	fzA78I7F4qhLtQj5lBHvn9w4sr97n+d0nUNLZZvwbErmVfOmwP/2A9BPF9KU50dSo40fPjNNzZ6
	kzFP26ez6U9EgD6GrPyD7OdBjklVEg+6VB87nOdl+jhczLaaO9iJrexJtgxdyXXGisxvpUBE/ly
	97ZvWg6C5GNpAg5JJNHOSgQY0Y0r6HpTj1LkowlHO/Kfh7xVol9jIB6v8bbPKa0Cf10CVRjMmKQ
	aH5VZKVWzLGLLECHJ+aTshGN6bHqkDsYyfm3SO
X-Received: by 2002:a17:903:2f87:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2b0827d2c55mr48984505ad.35.1774074375144;
        Fri, 20 Mar 2026 23:26:15 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4043:4ccb:27:b9f0:ed0e:8874:a784])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354b109sm56661575ad.31.2026.03.20.23.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 23:26:14 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH v2 1/2] erofs-utils: fuse: add missing return on getattr error
Date: Sat, 21 Mar 2026 11:56:03 +0530
Message-ID: <20260321062604.1905-1-newajay.11r@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2897-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 1C0792E3A77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofsfuse_getattr() calls fuse_reply_err() when erofs_read_inode_from_disk()
fails, but does not return afterwards. This causes the function to fall through
to erofsfuse_fill_stat() with uninitialized inode data and then call
fuse_reply_attr(), sending a second reply to the same FUSE request.

Sending two replies to a single FUSE request is undefined behavior in libfuse
and typically triggers an assertion failure or crash. The uninitialized inode
data may also expose garbage values to userspace.

Fix by adding the missing return after fuse_reply_err().

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 fuse/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fuse/main.c b/fuse/main.c
index 82aca8c..b634782 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -265,8 +265,10 @@ static void erofsfuse_getattr(fuse_req_t req, fuse_ino_t ino,
 	struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
 
 	ret = erofs_read_inode_from_disk(&vi);
-	if (ret < 0)
+	if (ret < 0) {
 		fuse_reply_err(req, -ret);
+		return;
+	}
 
 	erofsfuse_fill_stat(&vi, &stbuf);
 	stbuf.st_ino = ino;
-- 
2.51.0.windows.1


