Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A634A31AA
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jan 2022 20:45:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JmPvL103Lz3bV9
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jan 2022 06:45:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=jsIgT0BW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::433;
 helo=mail-wr1-x433.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=jsIgT0BW; dkim-atps=neutral
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JmPvF3ZPjz2yLP
 for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jan 2022 06:45:43 +1100 (AEDT)
Received: by mail-wr1-x433.google.com with SMTP id h21so17437882wrb.8
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jan 2022 11:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LgjD5/E4LTzNTWIM9JLIgaRv8Jo89HmXCIfKtahnPhI=;
 b=jsIgT0BWPs2qa34N9EtstWTb9hvV9QOmYjYa9kl5SajYcmC1JOIn6g2iuueqD/rz13
 QpjLOPe+uzTVdCXHkqtyIRiP8qGKZ4/BB+MUNQHYXqeAoXrdiksXy2cYNxn6GYUOMGCB
 3tVi4g71FLF229prPQTA1bsTNgAMjK5u671JZN87tl8bs/xYg8LEBoIpy5cajhdQkn2f
 T7xtPj/z8JPL6WA1u260yLrtyw8prmu7Dy/l8teVD7VUqZ8iYW0fv4UQP0BhsLj5rhcl
 mN5PzWSCkZnfWt2f44v5yIAiYgdB8EL3x908/77mj334hRqjaMyfDBzxuFRJLPEWa/re
 FGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LgjD5/E4LTzNTWIM9JLIgaRv8Jo89HmXCIfKtahnPhI=;
 b=NnbUX2Q73yz4p360SCPYxmynAOzzo9mgQXe5ehqxm0Xg6z8LCEPUmd/RM0RWBiZYKq
 Cc4k6aLcW4+GN0jplUdJo5l0fDHQXyJ1IyAPMbHIcT0PC0IJYzrO4KwbN7TaLJl86vVW
 DU43nLIXn9JvakoG7l7v7ZxEySRMYJAUJ01q5H4iI9W7C+GMB2veg0qvIkoYrLZzrD5p
 UHIMb79oC6e09z1qAny1AtX5j5mPJbvDVFmkwVRwfLGwARUbbn7VWdwhjHpPln8q2YEu
 dZjqMO0cOaV1kCoD7TQDma8MWiW4rldSkMl+ancn/0/Xy59jCQsf+78+Mfwf/xx2dNXS
 6PvA==
X-Gm-Message-State: AOAM533361RgwMMXYGnwTpYin+UGSW4Rk6R1UPR0UMoarBbh7UDDjjkE
 9bKYos7paR72YTlz5Fh8/dqZOF1VqZJDCQ==
X-Google-Smtp-Source: ABdhPJwZ7cHQiggrgyqsmRL3J+TFdhtphUSthcrlmRNjnzSJYs7Fa1VkvztJk5Zugv1J+lOqC+iIXw==
X-Received: by 2002:a5d:48c4:: with SMTP id p4mr5837372wrs.570.1643485535723; 
 Sat, 29 Jan 2022 11:45:35 -0800 (PST)
Received: from Iceberg-PC.localdomain ([185.110.110.225])
 by smtp.gmail.com with ESMTPSA id k32sm5972153wms.14.2022.01.29.11.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jan 2022 11:45:35 -0800 (PST)
From: Igor Ostapenko <igoreisberg@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add missing errors and normalize errors to
 lower-case
Date: Sat, 29 Jan 2022 21:45:32 +0200
Message-Id: <20220129194532.26-1-igoreisberg@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YfT1Hdr4w6pQKgeA@B-P7TQMD6M-0146.local>
References: <YfT1Hdr4w6pQKgeA@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Igor Eisberg <igoreisberg@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Igor Eisberg <igoreisberg@gmail.com>

Had second thoughts about this change I made, because it's making
an assumption about the default value of extract_pos (being 0).

Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>
---
 fsck/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 3be5d66..e669b44 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -136,9 +136,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 					return -ENOMEM;
 				strncpy(fsckcfg.extract_path, optarg, len);
 				fsckcfg.extract_path[len] = '\0';
-				/* update position only if path is not root */
-				if (len > 1 || fsckcfg.extract_path[0] != '/')
-					fsckcfg.extract_pos = len;
+				/* if path is root, start writing from position 0 */
+				if (len == 1 && fsckcfg.extract_path[0] == '/')
+					len = 0;
+				fsckcfg.extract_pos = len;
 			}
 			break;
 		case 3:
-- 
2.30.2

