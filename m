Return-Path: <linux-erofs+bounces-3059-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KApHIsvVx2kddQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3059-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 14:21:15 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1C534E826
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 14:21:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjdSN73Q6z2yfK;
	Sun, 29 Mar 2026 00:21:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774704068;
	cv=none; b=QoH77vZUdaZ0Zmsjo2tWgXyaMiMF/w8SLIyKh/Xq4eURY82es6rNbaSY9j6zNqFImNFJX68f2uCYbCCp9MZdCxjxZ5bQlTeMqvv4qDlh5IfXpU/RIe5q/SDWCeYED3byEJTWncZ15wsXk/I0HdFbI4IDyEXGNpFlrt7H9ici/FmgtCdlj28uLtYkAv6tcUwcmigaEEcQCQWlh81enAYDlNqr+bPu49fmbV0lzvsxdCwDND2+h5QNrJ/IDbNk1e2GOue730kV9nUhwdIp2jD4xEuLuwPQGhXEqKc9PdKA9We4MFUJtHrg+RtQV2Yt49mA+zvUxqSdk70z2c4WSf+ENw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774704068; c=relaxed/relaxed;
	bh=7/sdzl0p+aG7r+0/tW1hGSRvR9VoU8WJXODHbWyuV1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/WmHeNu6n+navvOPXroID2GG5euNHmQjN5fM9m66EcVtdaR5lNkJS7HPsf/vAgIX6U/Hi3MjzlZhmOliJMknsMUxX0/UCRgbQ5Q2PiQdNXN7K5by5W2x02TFtivHcUQ00kZdu4Cdq2eueJBCpFNb1oUbPepC4A0Q8UiGQDt0TGlA+ZHCFnHKOnm18YfxiXAf+8b1UTqmVwLis7Y2Sxdk2GQrXcatVIOpxViJMBPOOdqdhrB3nJ6ccewR3irTwjwmnlY4Bvs7o7C3DlrGgT3FRd1W0wQGW4rw1jQ/Io1MPVk7YbvavWLDxgv2ZUtgvxjLyK/qfVR6ltlXVYk+71WgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kIRcO95T; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kIRcO95T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjdSH2xTbz2xlK
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 00:21:02 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-829a27414a3so1927484b3a.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774704059; x=1775308859; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/sdzl0p+aG7r+0/tW1hGSRvR9VoU8WJXODHbWyuV1c=;
        b=kIRcO95T+Aw9kApDgFPbsxgn41hKvmFh3Epnt8WuP7wCcfk2Tx0PZ4B1n5OeNMrbTG
         80cqMNiKAbzPBf42fC5kTz8m5DVK0Xn5RWZ8suhFKlst2i+OXmEeU3kzdkw5Uhjes67J
         TE/JdXsX3bBNnjiIuvvCnaWSIBg/oIZEYuVPUQg7ESZ198okAiS/tIaQ0aIMm7P1ZfT0
         xyv9WpFcZw8k2c7Ifv7ZkWGn1UPfRsS8L37kt2XshaloHVBttQ88s/XVNP3SEvZn52pw
         QVchd8NS1xCPS9gEQ9UW3QHxMRWj2gMgl/LnjGIBJp/q/lzJ9NvdV9+Kk8pEeqjLv5X+
         Zi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774704059; x=1775308859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/sdzl0p+aG7r+0/tW1hGSRvR9VoU8WJXODHbWyuV1c=;
        b=KK4I2w6nhHPCg57CqnX6e4F9GIBQfapd2tc/lu2TX1qeOBcx2aoOfKOvCrhWMYISqA
         oeN3JsjkSXYMpZj01hWtcuIbYPnEkogWIQ/UU4rUvKnTR4EnFYB0LwGsvfJ12aqDUhJa
         GVigPr6RGZfD8q9hKuk+RIx3u6rb/FHw0jPeqyttUDZoLnnXPgZvN+D9RTklRzzSwAXo
         LhHlVtb9W0hMjc5S1Kfb64h6RruV9eRHAv1MuF9J0/tJ+MQLjUlGd6Ea/b1UM4nWq+PT
         S8vERN/wdV7yLZ/GD4i+eRrX/Btq9bGxt/JqEIaH4Vrrk0kUMNfWufANXapd+OhBOVMJ
         g7WA==
X-Gm-Message-State: AOJu0YxFbS/ciKulIeEqfKolNxHVrQE+VYYh55Kz6oluEFDYkgMRTF4+
	lVdw5//+kvW0Qg3zuqX0c3gmnUC6zvWLhWaI0yMqffjmAzeVaTovtOT4Hlxv1Q==
X-Gm-Gg: ATEYQzxUgfSJC1yO2eWQ0LwJoNbaUEiHA8fUUXpR5oUwq+w0fNOXV4vUQXdZ2BgFMT4
	1SO88jkQY3KgEnPy75thOE3QJkiMIgMOPeYIj4Xfu44add94v6ikOWHnc+8EpKTNxjlnIW25Hb9
	ZBR39bgc/NE3Q5xLHmX5L39cNr8Q8s4jYVxtzxJlYmnYkn0+Uku3RjroSlFLnj7NW64SXAaHW5r
	aw6TpUXwGvyhO8+j/oT+kYCmAaooERny5/vfSEYH+h44ce3EsnqncePBNkDt3kO+oWYcvRXUtso
	4SwVhXfjqkG12n4z7ipgEfh5MgYw7cDgT0who+LbLztySZIgyoOs3O4gkNm8KqV2J6Ypk3tZnw6
	qsvEB7FYGIPkreyxfk45MJsGnKxAvQiEjRSRT9pBX+08lYLPOS8mJfx0C3Cz+oLhMSMqJ6z6O98
	PMbKLfnuXDHCxd4LR9PJQzmI3Hk182VnNAEwo2j8o=
X-Received: by 2002:a05:6a00:2887:b0:82c:6648:643b with SMTP id d2e1a72fcca58-82c96038b0amr5488686b3a.40.1774704058771;
        Sat, 28 Mar 2026 06:20:58 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4081:9b93:a46d:2c72:59fa:b6ce:56b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d4d90sm2504074b3a.36.2026.03.28.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 06:20:58 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix EINTR mishandling in erofs_io_read()
Date: Sat, 28 Mar 2026 18:50:46 +0530
Message-ID: <20260328132047.1869-1-newajay.11r@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-3059-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 4A1C534E826
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When read() is interrupted by a signal and returns -1 with
errno == EINTR, erofs_io_read() falls through without zeroing
ret. This causes `bytes -= ret` and `i += ret` to execute with
ret == -1, corrupting the byte counter (bytes wraps around since
it is size_t) and the offset. This can lead to incorrect reads
or infinite loops.

Fix this by setting ret to 0 on EINTR before falling through,
matching the existing pattern in __erofs_io_write() and
erofs_io_pread().

Also fix inconsistent whitespace (spaces instead of tabs) on the
closing brace and return statement.

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 lib/io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 0c5eb2c..dd5e304 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -551,11 +551,12 @@ ssize_t erofs_io_read(struct erofs_vfile *vf, void *buf, size_t bytes)
 					  strerror(errno));
 				return -errno;
 			}
+			ret = 0;
 		}
 		bytes -= ret;
 		i += ret;
-        }
-        return i;
+	}
+	return i;
 }
 
 ssize_t erofs_io_write(struct erofs_vfile *vf, void *buf, size_t len)
-- 
2.51.0.windows.1


