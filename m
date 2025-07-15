Return-Path: <linux-erofs+bounces-624-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12270B062BF
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Jul 2025 17:21:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhNFQ0nN2z2xYl;
	Wed, 16 Jul 2025 01:21:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752592890;
	cv=none; b=gKSlj0QTO4QtAm934tInlYGYBmoB9HY0cDtR+Yqz00cHTZZj08/1ZwwCBAGXnPpwRK6kr+8rnlxaMQZIr48RahM3pN4NPjKhR6mvQ2b0uWEiOiMVqdaeCWofA+wXrzJULQWhsYrG++3ohBvmQlYwjxtpQ/eysg6V7I+9dfSNHPELSCr9uagvDTkMdmSXjpjZpxWCg/LWPnzdfvujODHMxc6NBAIpNyASpEp5HPMdNIUq/7YwmuekOXCvTjFP9guML2ENOyMx3Nj00Wyx2Kl4k4RLz08WLCcQER0s8/bNrpDqN9w1wCDqYLEpxjoEOejX6SjFW61iXV9eWekZsigcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752592890; c=relaxed/relaxed;
	bh=NsH2mnuI6uJ+rORwbaKmcLL9k7JiglNMAxnTgRzRXeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDtQPyhT895AVh9YG2uqfwpZSiGiutaGnqA/DnV9D5xLedfyBj3Gn8fL7r1NrUMj6UO4V0YijBOh1dxZVy8KU8CKXoTTfeiHmG4dBdRf3kGNxS3pj4QejblAX2Hb4GlMVoyt1Rk23p4Esb8HZX/ERbisHnityM7tRoG+lL2ep1JFT55awDc22ndxqa9+aAFktmOBx+agBwKH6Prw6VDi59NR3QdV4yfnNqLr0RKAYj2YmqDwzVK7VDmGsbGuPnmZ55EHvZYx7Hf7+ECDkkVe1LdCgPhJQ3E6bYHEQQi9llLSPu7QRQDWzUktEb6SAHA3DEUgktjUqbkliZtGRAv18w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iY2sbW+7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iY2sbW+7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhNFN4m95z2xWc
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 01:21:27 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-747e41d5469so5867652b3a.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752592885; x=1753197685; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsH2mnuI6uJ+rORwbaKmcLL9k7JiglNMAxnTgRzRXeY=;
        b=iY2sbW+7F2jjGum4dqrIhVTR8+Pg3IS2xp2yVKjBORJISMKhjkMoJk4CZosHoliH2A
         lFzN4Ml0mIb113hrcXQ62aItHyKvpBQP4PmgqGxTmZNRLtL7/1nLI4C8enV8Q2jGkNim
         SCmFlyTZb4tsck57+Tg12K3M4KDvA4bF+U9nksMp8gqkYUzTwsk6xBOLFXhw0TXnL9Bn
         AIhSsnEm7zO99scB800q118cR3V0+OqjkM9Bj9vxJXbgeqPA+tX6VuB88m0a9KAxlJXX
         u3hf5DD3gNmhSoLv0hKOZnWoT9uSX6+Sks84fP9Yi3kjpePjzTChXggeyUJ8CxNINzCd
         oJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592885; x=1753197685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsH2mnuI6uJ+rORwbaKmcLL9k7JiglNMAxnTgRzRXeY=;
        b=DvtmMQN760xqNUzi0El8db6E7WjJN5UVg9MX4KeRcAnkX8sUvyp7z1pDLsGAeJItEs
         DqzBRgbmcJO1mGbKDX5k6RVoQ9lI8oXy2M0+L6vfFswMazNCAaUmlCBGp1LsdpgR84/2
         Oc9c2LZJHt+1TVJg773L9kBL45j5vC/KvrGD+Iun3upcE54FxXwhTIZyGvZWPOeUqUIO
         AEONuouDWXYXYsRzD6m7RyFZpsHCc4bZ7WYWtU/NYS+Zap+zY42AGQ8Ov5vCE9FFHMgM
         F9y+TzBl/C1Jyt3TeusA3HR0ktmfi+Wnv3Wmvw7PPxJ2Vb56ippe/2mHEIy86shXEFHk
         P6kg==
X-Gm-Message-State: AOJu0Yx6UwPovsZ0j5LR7/zaX3EYfobA5ZENp2Qjua/+tkilNOOf1utW
	eXuZlmrfr417WhgUqn/4LvHlVZAOPhWko2KXHR8+FLmr5ZM4Dlv8HZmvbHEsC8AB9Gy5iQ==
X-Gm-Gg: ASbGnct5Lsh3aAYeztW2Do1l/CfKK3KvjXZQYKBRMXFKKMDMnFMTWAArjWz0QTvvj0E
	V6y1dJLhyM326KKwcJLBuZdBTWsIsRAcC0W0ZurW5w6x019dLG1MUCnngDCTydKTk86XIINjgKt
	g66Pm/6hWuvwFtNTj9LIeqwz2qvLgmAzOvaSCDh8qCz83rYjdr0OE8VNsfqAQHNAnWnGnNQx03Z
	Pl9A2+LXqOh4IkspzBv7iqbL2bknF2uFKvkxuOFy4H3J2chZQFKE4LWo6FYPC5JO4bo+s8Pm/Qk
	eRD5Gh2hFHTlWBMCEbVtdirS3ShNo2DB8y/SXl4V5qdlyeMuxRWCEbVjMjTwNirI3E3GspVpy26
	Ah7TViAwxWsyEa2sZvoGM8BH93w==
X-Google-Smtp-Source: AGHT+IEwvNY9NUPqhWYfaOtO2ovvnkML7OZ4qvWPxhNf3MppjiYfPpLiNAbqXKPocupfWHDfsgLJsA==
X-Received: by 2002:a05:6300:408:b0:231:e482:932c with SMTP id adf61e73a8af0-231e4829416mr16325579637.41.1752592885038;
        Tue, 15 Jul 2025 08:21:25 -0700 (PDT)
Received: from ZYF-PC.localdomain ([50.7.253.114])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3be87708aasm5223717a12.50.2025.07.15.08.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:21:24 -0700 (PDT)
From: Yifan Zhao <stopire@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <stopire@gmail.com>
Subject: [PATCH v3 2/2] erofs-utils: lib: fix memory leak in z_erofs_compress_exit
Date: Tue, 15 Jul 2025 23:21:11 +0800
Message-ID: <20250715152111.15305-1-stopire@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c6316256-548b-48c7-aacd-ee863968688d@linux.alibaba.com>
References: <c6316256-548b-48c7-aacd-ee863968688d@linux.alibaba.com>
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
X-Spam-Status: Yes, score=3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [stopire(at)gmail.com]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [50.7.253.114 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:431 listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Currently, `z_erofs_compress_exit` does not free `zmgr` if compression
is disabled, causing a memory leak. Fix it.

Fixes: a110eea6d80a ("erofs-utils: mkfs: avoid erroring out if `zmgr` is uninitialized")
Signed-off-by: Yifan Zhao <stopire@gmail.com>
---
change since v2:
- do not remove early exit in `z_erofs_compress_exit`.

 lib/compress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/compress.c b/lib/compress.c
index a57bb6a..2059e19 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2140,6 +2140,9 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
 			return ret;
 	}
 
+	if (sbi->zmgr)
+		free(sbi->zmgr);
+
 	if (z_erofs_mt_enabled) {
 #ifdef EROFS_MT_ENABLED
 		ret = erofs_destroy_workqueue(&z_erofs_mt_ctrl.wq);
-- 
2.43.0


