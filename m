Return-Path: <linux-erofs+bounces-3207-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NoI1LltP0mlOWAcAu9opvQ
	(envelope-from <linux-erofs+bounces-3207-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Apr 2026 14:02:35 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EC739E359
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Apr 2026 14:02:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpWKx5S5Mz2ybQ;
	Sun, 05 Apr 2026 22:02:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775390549;
	cv=none; b=hq7wKDPDD+Nr3PRuofzHdGgWD8h+1Ox0JuivO/oDF7YZVPz51NXm9pKVzj1XWlShCMa+4s/5bTLvfIQqpQQ5IOCD4pWkmEVZmK6b3f7aIaWx3BNYFMpVHK+en1mXfr8IWKVcmsYJ8gYPVMdyHX5Y4QKhnYJMZSdX4cPWxCbG7oQOvR5xtDR5ioNIyIwLt526f6X1erOz4EkhcF9Ah8Qs5SMmFM/8LRRKw0YT/Y1KhL4orkxWfrUSbpKQz6M319PpSToCFalrzLaZNuWgPNPDGRzmQB821pFfBk+Y2TtzwJ3iX1+f2wzldhjBQ+GSr12El+Mk3DXHrcxplItBQR3deQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775390549; c=relaxed/relaxed;
	bh=7WA49VcQWC9mjQ7bi25unHUi9qKN8LUQE4uWigLXSA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SY0GmnYjVceLj/vYJTsTow3Qds7B6k4+YNUhduXVUH9BwSoPc7LVOX3JP/bcSz8cp4h0U1qPU4RyMTpaIbV6z61ZM3Q1EqrR86UTUjklpZSO2SSL/M2kFzTaw+zSrhJJhxZMqbTx6zjFotsKiSkPtCK7f3ypXDkXo5nZaum3PRG+1u2VKvAz7NUoqd6DrzZCDVy5I+/8kVU3crWax0xQO2r0Wtn1YgxEwOKiT7VN0//FfJEIPWc53wOLy9gAnwdzuub3LyO2p4qeErO1+SGSFSQarbM4zPX1wntBBXhHUmZxHHCrshvWOYSiEsesO4U7TAFr8GQ+kOGqIe6clJ8cSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P50FwLlJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P50FwLlJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpWKw0DLWz2ySV
	for <linux-erofs@lists.ozlabs.org>; Sun, 05 Apr 2026 22:02:27 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2ad4d639db3so13234145ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Apr 2026 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775390540; x=1775995340; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WA49VcQWC9mjQ7bi25unHUi9qKN8LUQE4uWigLXSA0=;
        b=P50FwLlJC9ByzHhWHC5sGSSArUpe1hGudSg8SGs5sojyJe2Fbe/HuPyjGJATUIaBKJ
         Yld9xvjEUZYSrwefJDFvs3lFomO0P/5o9XqfsuhpkFm8mvnByhCPR09dr/+ch4fKca5Y
         RTK3+ykvWPYNKhZKw7rS65JD2kqMX0ad4DWIBKmSuv+E38hop2FcOk9+WBg9bs87k1Mp
         XRTJw4oln1ZaFzYU7V+HZ1sJzjhMR75KyYQyBflk6f8SNMUmQDFMwtji/HwrZvbwqlZ4
         XyzAPjlOQavaEBrDhsr7gAtoNEQRTnZqOfn0PN1zH+RZK8zkMJn/WyGw1TrU6HfORysQ
         h0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775390540; x=1775995340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WA49VcQWC9mjQ7bi25unHUi9qKN8LUQE4uWigLXSA0=;
        b=Rj89vyAfOqOZdrPY8r2m/hu0iVKp83xsPGr496v5lcjsupo201xUonEXHglGR9zRTv
         YoEyxy8j+9WRXBxn74FXLoDWAx4q7fcZgRJiTnM/FQ5/DUpD9zPxeFMVktF1gmZqZ/5w
         3R/Zqe0kzKG02I3WLJgt+8xyJzm6+Xs3k9Qq1Tl6ElBjAnYmmUzdbTCRANvshyG5BZBE
         rkI6+p/z+0BucQsBATzM20m/IxNYM7P6jrQknQ7VEqKq7O/Lf49ubx5MUxT3Uib7tNcB
         uqY+BjdzcYQnFRIOwAclqfboz0TfsLjztfWwDVKsVPcNnJej8gyDmXkjhpCsHUQSkl7W
         5mVQ==
X-Gm-Message-State: AOJu0YzXbbaGlLWHAUlwriANTNKPHMCw5vHOhH0xZ+x8jFG26aOdv+UN
	Jc7/OUkl2zIg3d3lMSxOH5sTGDG30dWJuYdrgexfTlfA4DoGdomMFR/3lGEZWw==
X-Gm-Gg: AeBDievTGenZHjtMla8RQnsvvKsCw9FITh+3c8GJA59qSQJTp5pK7eivpPJ2yLMqwvB
	31aG9z8puw9tdzv/5VNLCJYTnxprYKWFKED9yOObUxEFQ7G2f3KixFHPtJ6/g9OXYOHj235bYMu
	l8QHlZ7I0WvIRstH+0QNjVqwFo9qv66u7x4PolrfRaW8w3CcJOcOsaalvS94vgGaJr4IMES0elb
	/DEoOsZhmxTjmn1RFv3RQbioqQB0BrGbml26du6i8Chln9/DFgwLuIywdbvMaOWR2KtYQgvVz/x
	AVWPB298CjUFIQiBBSyuS9Gb76AA0OIIr/6r159EN7Y1Kd3qVnLSeFjfVNOhJbsFcevGQbz68DD
	nYLPOpclxc7WezJBlXWL8plA5EbC5WnHK9FBdzfv+ZKzTLRs7KzU8w3udxXIjd+tOk6Fo8suyc0
	CN2Xckmrw3LSiBf/CmH0LgP3SNHyQxxACb2IMXBc8=
X-Received: by 2002:a17:902:da83:b0:2b2:5314:e96a with SMTP id d9443c01a7336-2b2818de2c2mr93941485ad.34.1775390539895;
        Sun, 05 Apr 2026 05:02:19 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4081:891f:f789:ede7:e6d4:7443:f10d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274779b48sm147453495ad.25.2026.04.05.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 05:02:19 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH] erofs-utils: mount: fix unhandled realloc failure in flag parsing
Date: Sun,  5 Apr 2026 17:32:12 +0530
Message-ID: <20260405120213.136-1-newajay.11r@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3207-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C6EC739E359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofsmount_parse_flagopts() correctly returns -ENOMEM when realloc()
fails while extending the mount options string. However, the caller
erofsmount_parse_options() directly assigns the return value to
mountcfg.flags without checking for negative error codes.

On realloc() failure, mountcfg.flags is set to -ENOMEM (-12), which
in two's complement silently activates nearly every mount flag bit
(MS_NOSUID, MS_NODEV, MS_NOEXEC, etc.). Instead of aborting with a
clear error, the program continues with a corrupted flags bitmask,
leading to unexpected mount behavior.

Fix by capturing the return value in a local variable first and
propagating the error to the caller before modifying mountcfg.flags.

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 mount/main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 5fdda81..449b35b 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -303,12 +303,17 @@ static int erofsmount_parse_options(int argc, char **argv)
 			}
 			cfg.c_dbg_lvl = i;
 			break;
-		case 'o':
+		case 'o': {
+			long flags;
+
 			mountcfg.full_options = optarg;
-			mountcfg.flags =
-				erofsmount_parse_flagopts(optarg, mountcfg.flags,
+			flags = erofsmount_parse_flagopts(optarg, mountcfg.flags,
 							  &mountcfg.options);
+			if (flags < 0)
+				return flags;
+			mountcfg.flags = flags;
 			break;
+		}
 		case 't':
 			dot = strchr(optarg, '.');
 			if (dot) {
-- 
2.51.0.windows.1


