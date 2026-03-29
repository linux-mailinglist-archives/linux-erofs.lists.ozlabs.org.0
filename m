Return-Path: <linux-erofs+bounces-3078-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLrDH1AryWknvgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3078-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 15:38:24 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3289035244C
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 15:38:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkFT85tryz2yYs;
	Mon, 30 Mar 2026 00:23:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774790636;
	cv=none; b=LTqAr9KOB3/KiQ2m9+o0/LtrG2qouS8uJ3dE5OWszOWwAUZyRhhpoatR6MrKc8cYAH8L0ePuDRWxrbc1gMnUwUhEFiLx6vaqWyHXgJAHtIJg/iTp16/q7DBC7SCzVp53poYFWiYWS/jDE9hkNCX+QEXzh4RKofqkBHSQaW030ZeT3VMOw7gRuCuud0z4Bz5kDrgYCzaET05Oi/mPH+lCUN35x3Y/9kMF/UJS8bxJ+glCR2QHBTXba+gkz9nz8ka6dV+QJXOq8Ss71AmFWVfqdg/pJ7ty2BcRrsyInuQA2/HHSY5KmJeHLxYQPQeEFukAAHXxufYqgntQnjjLTFuHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774790636; c=relaxed/relaxed;
	bh=hpSUefsfaYfz/q2XmjcPuzUiWb7Ia1UhI16o56J1kgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zw9BJ9j92vJtcsvHFbf9r/IFBoUAF3BL4gkwWknofFtnaRV2Rr34joxbxiZ4GsPOu2vNu6r8b8yA79EFTK3d/8JbQBU8xtbkyz8fk3fKR97rxRDhJJKWGmFEnV5q1rUkqJySIKwFEn+V6JxePFQHLHQ+bZXh72g2XdACZr3MWndwxBMBu7xFtNNHu5YnNf5RVvXoSGb5NMRfSMst0c8xO7T3L4rQDPQHX7xkm71XoAz/1kBoolB1h62onLmQybE5hD93dFffmC5rh+utWOovn1eIdG12+DfgHcNbPxGMTKpVypVT6baeMXBABxx1Tiu+U6+8W+KGXLRadTgyJGMiZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y0zu7jLe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y0zu7jLe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkFT76Qsdz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 00:23:55 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2ab1c8fdc40so4530485ad.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774790633; x=1775395433; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpSUefsfaYfz/q2XmjcPuzUiWb7Ia1UhI16o56J1kgI=;
        b=Y0zu7jLeq3OsTnHaJ28wsbocmdC0lvJnaEwIBHHexHEq1BiuiFarJWhZBoWmTYTz4l
         s6UtuGEcPs9p/VWXB2sD9CNT9dwP8qOrENU+UT3dqkWlJBPlZ+KbHUdwNCejGa3uP/h1
         t5iAmzClD0WLdAUZ58iKzj9wUN+bJOCJfzo1U09IImf7xlKd3sofLTYM8kf47nT3BCNo
         leQ4e+mEykCQKVVO4q8wwplLQyCuf1XUtSeipb3/xYgAlJ/LIwy9ncj3hdC/il7BLT/w
         C4JyTkEnVRbX4Nt6he5TZeEf0whXsNAKurQ3+7sPrAuxcNXga5wbvXUj2iRa1ZHOJl4w
         Nz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774790633; x=1775395433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpSUefsfaYfz/q2XmjcPuzUiWb7Ia1UhI16o56J1kgI=;
        b=HFswvW0OY0wctvdZ+skSaz7gQyK6JpY2sPdabl/AFvCvS+1fSXd8jfonq4yaUZUSwf
         QuPhIM0ERn9WdcpThS6YH0V3nvldI6KcAbiNqv/be7BXBz0LPELBkj9W7Kymrwsv84XW
         hDUIYgyCMqHa1wUawaWULOkqjdFXYXPg7n7QwHQcWP+97j9E59FACAwhv8xqwhY9sEkx
         TqeeEad+V63bihBWSy9aepoJtcFyaVOjLoAXCHU2pdGT4pS/1qOUgGDopDwOubmiAK7m
         Ye/qVVLTemAN5BRzD3JCTqaO/m5PZ8mbNsex9ajD3rVnARxNj2SZyjTa96ivGhuPgCby
         wD0g==
X-Gm-Message-State: AOJu0Ywpk3VRgMUoVMnyaX9EtobVx2jYRwxT3U85NvT6d7QtR8HUn2mH
	+Z2Rk7IVMcBPVJcNc9v86HhP6Usf2fythcOIHLEnqKDAPNLWDCYEG6MNLH01JgvN
X-Gm-Gg: ATEYQzxGxxg/kckZq8VPf2Nt5M5Fitq64DbY6gLb/gfTgRK/GiB4dkAoxrhbQYdV4H6
	hwxV6GgnLsOYkPOXSAOkkhZ/cyTrpOAMuwOra3qCrqI0u9Pf2xQAS8iTnrpQxVCb4XtzvZbKxTJ
	Wsepl7Nx/eft0v6vLiQySpXSXNBPseTY4sstfYghb7UPrxD8OdkX01QaJcAcMGFcFsP+7mUK+Zh
	TWzK4wtAX7QBe0M+/750V13MQqquqRc99q3eSn86DKGO5A/r66iLL6DbZ6teCeFq9ypLUtnYHGS
	UVRg/IldOBLcyOlz3POginNEXpN8Zv0xTDE/TL2aaSGtCsr47pUnnjeLzZTnucOHxIxcPXjF2it
	fhIXeRTrURCqQXSIsA+rsptz/pdbT4wyhkoViuGRwf0di70wj6Plr45zSpnCHbmrUeJP6VoWmar
	B3ktai6jSgZEz/k7pGRets8T2OSBvED2rK/Vo9hAYo8Cy9UT2ZENEciKCIR/s0lj2ZGm4HZgw7G
	0qZDW/fMsnwncl95011wx2HmsaPkdl0YNZ+9QqLxOAsLXux
X-Received: by 2002:a17:90b:1642:b0:359:8f7e:d337 with SMTP id 98e67ed59e1d1-35c30149c54mr5296429a91.7.1774790632619;
        Sun, 29 Mar 2026 06:23:52 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d8c425sm11681876a91.12.2026.03.29.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 06:23:52 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	singhutkal015@gmail.com
Subject: [PATCH] erofs-utils: lib: fix data race on __erofs_is_progressmsg
Date: Sun, 29 Mar 2026 13:23:06 +0000
Message-ID: <20260329132306.15353-1-singhutkal015@gmail.com>
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
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:635 listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3078-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 3289035244C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_msg() and erofs_update_progressinfo() both access the static
variable __erofs_is_progressmsg without any synchronization. Since
mkfs already runs multiple worker threads via erofs_alloc_workqueue()
(e.g. in z_erofs_mt_compress()), and those threads call erofs_err()
and erofs_info() which invoke erofs_msg(), this is a real data race
on the current codebase.

Fix this by protecting all accesses to __erofs_is_progressmsg with a
static pthread_mutex_t. The mutex is statically initialized so no
init/destroy changes are needed. Also restructure the
erofs_update_progressinfo() I/O path to eliminate the early return
inside the lock, ensuring pthread_mutex_unlock() is always reached.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/config.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/config.c b/lib/config.c
index ab7eb01..7f58159 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -100,6 +100,7 @@ int erofs_selabel_open(const char *file_contexts)
 #endif
 
 static bool __erofs_is_progressmsg;
+static pthread_mutex_t erofs_msg_lock = PTHREAD_MUTEX_INITIALIZER;
 
 char *erofs_trim_for_progressinfo(const char *str, int placeholder)
 {
@@ -141,6 +142,7 @@ void erofs_msg(int dbglv, const char *fmt, ...)
 	va_list ap;
 	FILE *f = dbglv >= EROFS_ERR ? stderr : stdout;
 
+	pthread_mutex_lock(&erofs_msg_lock);
 	if (__erofs_is_progressmsg) {
 		fputc('\n', stdout);
 		__erofs_is_progressmsg = false;
@@ -148,6 +150,7 @@ void erofs_msg(int dbglv, const char *fmt, ...)
 	va_start(ap, fmt);
 	vfprintf(f, fmt, ap);
 	va_end(ap);
+	pthread_mutex_unlock(&erofs_msg_lock);
 }
 
 void erofs_update_progressinfo(const char *fmt, ...)
@@ -162,14 +165,16 @@ void erofs_update_progressinfo(const char *fmt, ...)
 	vsprintf(msg, fmt, ap);
 	va_end(ap);
 
+	pthread_mutex_lock(&erofs_msg_lock);
 	if (erofs_stdout_tty) {
 		printf("\r\033[K%s", msg);
 		__erofs_is_progressmsg = true;
 		fflush(stdout);
-		return;
+	} else {
+		fputs(msg, stdout);
+		fputc('\n', stdout);
 	}
-	fputs(msg, stdout);
-	fputc('\n', stdout);
+	pthread_mutex_unlock(&erofs_msg_lock);
 }
 
 unsigned int erofs_get_available_processors(void)
-- 
2.43.0


