Return-Path: <linux-erofs+bounces-2736-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDrjK/zEt2m1VAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2736-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:53:16 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFC02967CE
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 09:53:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ84n2RkYz2xS5;
	Mon, 16 Mar 2026 19:53:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773651193;
	cv=none; b=NHvAdCE9KPW9kb3efBnyvFCf5u4xn/3qJeVAkeLW2SB/Zb+wuReqbUpkFeq4D6UhlbuZzgZbZawfsliNA3O0O59q2rYtORz7/5CZgmkux8o9TaFbaCoKbtgZGan6E5Rz25yDRquQ6rnaPmvzHWwJVjMhZu8Z+sCQ1839smaZ2q1D6oU+pneRvrqlQiBCCStKJMgyo5yaSuG28vVjQ+jYHvRfsnZA1MjUYzN1Bfc2Dji//KpnDNTrVoypJ97A9JeEjs7dqCXUe2t7CIIe+S1FhIWHkzb6KqLqYph5SA6Wh6y129T58Qqd4XoXVOPxkfYWqDSGGyH84WhSjysdXlpwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773651193; c=relaxed/relaxed;
	bh=v7Og5AoKIk58WSnPBKjan1MuxgO2WFRZgIsqQEm47n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Om0bgTpwYTIjoxHBtEaHBSaLApylHUlJZERu+WnSYU7tIOR7iPNWeQ1fc2ZAvcBaf/fTHGV62fi2PbzTZHSuP1hqj8u5L7lR1a57CfStuB2Wcm63F38INOMgIIDF1AHMg6wkogU6LrBA/4iBW/F/VEkHrtWDPTmAN2UuuoCp8KIEhZhPehWtiUY6BS3HXz5la33Z5eN5CqJkd188zjL6g28J0Ovevmxmrk0jwFPaddF1DoHoNziYkcOVsKhQUzQF0cGB3BcWAeJ7a9q5sBUesCJSTO0MdbtZDvZdqIXrPLUkN0KTtdRVFCAyft4PFpnsUmr5sJrCHb4dUa4q4gD0qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kbRXey5r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kbRXey5r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ84m36T2z2xQr
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 19:53:11 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so784175a91.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651189; x=1774255989; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7Og5AoKIk58WSnPBKjan1MuxgO2WFRZgIsqQEm47n0=;
        b=kbRXey5rh8VnEjzCL3V1LkGMDZ2FiA1iBQ5ov/D2YV15fBer1bEJoidW5JZWuQnLCr
         oFDlFJ1JiuuHyd0uzRy0f/wIvrJR5f76mqWjgsS0pJUR+SsBMvLy8JjdLWIuaqtCoNOY
         t7HZdpRE2EY7Gz6Yg9AmFYkQpIHCLU1dTFJPvqDzJ4Mie0EBSSCuv73OWXCJkZNImrnE
         1kCqa0g4JVH+kQ3pIo3CLVANdIANzOAdGYJAoRTvdFlm/DhRYaz31v60qFDouxhtoGQh
         PsTDQnyHrFSk7E7ytp31ovnLKEfKxCHsmVRYnlJULZppxc12PukqRF8fk5nZvBTXU9uA
         /BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651189; x=1774255989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7Og5AoKIk58WSnPBKjan1MuxgO2WFRZgIsqQEm47n0=;
        b=HonQuoXH79r/kp/k2FLwb4cj7jrYbPJzDpCrU+ffSX8oFq+lBdWRlC1RWxjNmBujJW
         x/IVRx191QRc5BD2JranSNk51CuvxMZys99oubd6XLz5ob0BYiwdLiOptK4KGJHJUquw
         vbhuOWFT+0vDGQOf4vVZ8YTt1CsAzjw7Ucm4vGHk04lXu9qekgOGdduTPjpG9uCuv1LO
         OLwAn+Mvh3YN9b1rwG/MWD6mFLUWb0mDVLWZovfoaAgiYFxR1egvwVJM4M9F+qRzZA7J
         s0jQLTkpdb5qYB1dNtHbkcZsHdgycuKBYebdiQ7w9+KFTK2B4m4JW2+/l4Wo9BVVmldz
         SbzA==
X-Gm-Message-State: AOJu0Ywns2NVtULHyge7LDVui748+RAF4AinhhW0bhQ3PwmC8SJie9Yr
	56CPO3WeZkX38PYDuHowvylAeZ6uHmuew5Qvm+JQV8eQE7/7S9CK3UkBjHbk2TOIjVo=
X-Gm-Gg: ATEYQzwBzaHjOZsb/i28jT+7G05HvvuUPeJRVOHywwzI/RutIlApHZxeYGuYSIYMTcG
	CzjABVbRGgS0MXiUU6uqGHtV+Gg5UezRSZXblOM0ykDNW4tNI7b1CvxJpV7e8JXVYQ+GvzdnA7b
	p2ZlstciT+i0TlBKXraMXc8atnAHLzs0PrPIt4+C0w3XCLpzgorHoWcNN3cBiB34a8q4IyQ2EL5
	V943K7ZJ9giMHsf4gmeHOSW7cv4QyWk+7WsfIqek6ctPUDRubj0bvbMLmK/0lJcjI+/EJRnUXLm
	d6Z1R5dD1LYLQc6BpMH1yxhpYFIkRjeaq6/hLND69qBjtPoB3sgg2P5rhrxFWMI2qurxUyPGsYG
	GhxV74eSjf8ZgFI/3RB+aeXVdFQ7OeGrTeWZGUMsD4JY2gYNNWWQa6cdYtpxc9IgCaKkIRyjUyf
	Ox6tCMwz8RAMZKs7h0mb1wrFKMaJRa5IiNaHcroN4Z5q8jW0bMQGo=
X-Received: by 2002:a17:90b:3f87:b0:35b:9e53:e2df with SMTP id 98e67ed59e1d1-35b9e53e744mr2623903a91.2.1773651188809;
        Mon, 16 Mar 2026 01:53:08 -0700 (PDT)
Received: from DESKTOP-FQUTRMK.localdomain ([49.204.106.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e7522dsm15360950a91.6.2026.03.16.01.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 01:53:08 -0700 (PDT)
From: lasyaprathipati@gmail.com
To: linux-erofs@lists.ozlabs.org,
	gaoxiang25@kernel.org
Cc: lasyaprathipati@gmail.com
Subject: [PATCH v2] erofs-utils: lib: fix potential NULL pointer dereference in docker_config.c
Date: Mon, 16 Mar 2026 08:53:00 +0000
Message-ID: <20260316085300.19229-1-lasyaprathipati@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2736-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: CBFC02967CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sri Lasya <lasyaprathipati@gmail.com>

---
 lib/remotes/docker_config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
index b346ee8..6401c1b 100644
--- a/lib/remotes/docker_config.c
+++ b/lib/remotes/docker_config.c
@@ -202,8 +202,10 @@ int erofs_docker_config_lookup(const char *registry,
 		}
 
 		entry = json_object_iter_peek_value(&it);
-                if (!entry)
+                if (!entry) {
+			json_object_iter_next(&it);
 			continue;
+		}
 		if (json_object_object_get_ex(entry, "auth", &auth_field)) {
 			b64 = json_object_get_string(auth_field);
 			if (b64 && *b64) {
-- 
2.43.0


