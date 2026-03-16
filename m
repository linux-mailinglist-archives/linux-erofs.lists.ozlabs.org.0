Return-Path: <linux-erofs+bounces-2738-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDKJNk3Jt2kRVQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2738-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 10:11:41 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E22296C37
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 10:11:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ8V24xrfz2ygh;
	Mon, 16 Mar 2026 20:11:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773652298;
	cv=none; b=gv6VY+/L+9WTAWLm8zN8DQ6haSO1fU2KyHRXICBhfoUrqPymKIauB06h4W0iUEo5iJb0fqcXrsEK8y7hfIXETLSgh8V9zOGtC197xlnNzG5wSIOvoIe+hC8OySYyqcA/BE1bENDY9C/5rG6lKcCViAecB1GlZ132wU+em3FxCodjMp5o/ZQroM/vInovdH7+lmMdMcJrdMeo5buQAOeCjaKB77HVLxpIREG8+SLKHnB5xvrCTfmY4yTKXCn25Xsnmk1rmlnkh8J2p6Q7cU1zfbDWYoHzMdmYaJoukHCqlfkzWbSrigrXj4q1GyDHl9JrWCIWtIo/6roa3BVptGaRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773652298; c=relaxed/relaxed;
	bh=sK8tqDC7U3A6sr53mcZziTz2tbG3ApswPW/HjjXhYuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYUMFHWSEfiwd5ivQ6GUeTctLOi7KcrV5g3a18qwBiMwFB+deVyK2GFrWx1xfBJp+VIQHM/LEFCxNUDc0s7AivL1VtMR7yfVWVfiJ+QeOzaq8Co/rSIk+79jI5Vi0350o2HNWEx51FuYc31DcdTgT/76KwCNn0vFcMWtNEJiwjyQ3dgeTTqYtJsTFQHkntFrLOblTJWGKCNQWUNUQVCjxJ0/w0Q3F9snM4vM7AKOsXWMZEPy0WZAFtEJh0V9tXTEGBH2TjhS9a8y3pc/8V/DSVGVRbINQ4WB3nUnps1psShJZW7Hy3FP9snE/roE6DaEjI4hz24TxfrVi2g35BeXvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L7eGZ3+6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=L7eGZ3+6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ8V14xPMz2xpn
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 20:11:37 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2aae4d2d215so4486425ad.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773652295; x=1774257095; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sK8tqDC7U3A6sr53mcZziTz2tbG3ApswPW/HjjXhYuw=;
        b=L7eGZ3+62Knkf+lcOPL6+/+lO2KPvfNbHFdHiVJv6tFYMINCMv96CyDJZtacfECt5Y
         97Jp/L875DIfJX2aULmzCsLHOaPTPxPm6Fmh5sVvd5VBSdaNosRDq5nY+b6jSILz0oFM
         cm64BVcDQJhR76aW5hQqYJG9Xmf1QYHfX3WiJXyq6AY4BxGBdUHOSmigqfLYDt+U1gEY
         jn+vphyHxW44OE/K/+HB+m9YzlTQlaDtWo+fhUmhQ+m/1TzaLa+ll16RdACiETF8Ur7m
         FhjIByassLDHCAVDeKhOudgVpbcxo2dQ2/2fyYnH5DzduRxNdHzFaTzcJFhW7rtyzgIv
         eLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773652295; x=1774257095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK8tqDC7U3A6sr53mcZziTz2tbG3ApswPW/HjjXhYuw=;
        b=rRL0am17ZF1YHeQkrjE9tmWxLDO+VMaJbvVpacuU5fFR78rKMgebwFYsk1sVcSI9fV
         VquFafKNaCL5Dr2/8XwMPSst7cblz2QObW2JkfyXiQMVlzzVj3ZqQUot9l9Wz/ZCpx2u
         sPcVIuHIDLbSkLZMuvDfL8EyEBXUkk9eIe3fA/G1sAHzr3ELHzpfGo8Xr5w1ZIILS+2o
         AG3xDihIQSp9+G39oSywouRyY6UaysUuw/GcFjHaNy04xZtm+l7TD2c3YhrvnPAnPTrA
         TP/2/89srYWgk9s7c6No32z68VRPIubkJSqrdm39irfomL1mxcJEne+rOTpbgJBDaShM
         /z/g==
X-Gm-Message-State: AOJu0YwKGmCaCRxPe7SXHiV+gLwHjjjm2wmjJDK1DBk1IJZDJ1/oQEsj
	QmxZZyie/Y8TP3BhdiFXsoniN/z7RAnqJxneFBGu4rIRSDLkZHksoRGA
X-Gm-Gg: ATEYQzyIsuBAgnCSXO8I1ONg5wW/kp032UQyWLaOR088UZuV6iyI+KaZOMIkwk1kLD8
	djUlfhfTqah1ae5eyYYrkSl3fnEA5yJ1CrnqqGYxR36q/QL2kwktnKLVBCSudbSfRxxdX/PZJTK
	vbQamKaGsGJV9hq+MsTevqcfxNayc6/xbDK2l5/mYZnwxiAbUV9Ez4fjP0d7JEuo32z7Doi63Yk
	YCtU8DWrnzLVGvCkqHkmBZ+G9thYLaHkl5zckQ/j2SPH4n4OsxnnemKhVZfFbpqBek/dvkdLndr
	4vriyt3iZheEgeQ97IwZoklEZurd9C1dFsu5pjVF2lPNb00dUPBqW6L5ZC2bVCCC0nQZ0qi2xJI
	Z2hA+Sn7qKL3Rlc3alyF126eKFXdvdZAQcn8kRwpZPY7RSyScoPV4fgH8OtnHCf17uxbxYzLhWy
	zscuqqhtbQs7cZhzKyTCxEovzeh1FzhkpXW3CfuG3FSzhr9OCrwtY+WYvX58Crd5AzWD/CRshrd
	1YRCHiOXge9tIhGn35sdCyi4uQSUrzXzSHWjw==
X-Received: by 2002:a17:902:ccd1:b0:2ae:cefd:18ce with SMTP id d9443c01a7336-2aecefd1e81mr71843715ad.2.1773652295243;
        Mon, 16 Mar 2026 02:11:35 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62bc32sm104097595ad.36.2026.03.16.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:11:34 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib/tar: fix missing NULL checks after malloc() in tarerofs_read_header()
Date: Mon, 16 Mar 2026 09:11:27 +0000
Message-ID: <20260316091127.48847-1-singhutkal015@gmail.com>
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
	*      [2607:f8b0:4864:20:0:0:0:62e listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:singhutkal015@gmail.com,s:lists@lfdr.de];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2738-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,eh.link:url]
X-Rspamd-Queue-Id: 02E22296C37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In case 'L' and case 'K' of tarerofs_read_header(), malloc() is
called for eh.path and eh.link respectively, but the return value
is not checked before immediately passing the pointer to
erofs_iostream_bread(). On memory allocation failure, this results
in a NULL pointer dereference and crash.

Add NULL checks after each malloc() call and return -ENOMEM on
failure.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/tar.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index 13e777a..5a6e07d 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -906,6 +906,10 @@ out_eot:
 	case 'L':
 		free(eh.path);
 		eh.path = malloc(st.st_size + 1);
+		if (!eh.path) {
+			ret = -ENOMEM;
+			goto out;
+		}
 		if (st.st_size != erofs_iostream_bread(&tar->ios, eh.path,
 						       st.st_size))
 			goto invalid_tar;
@@ -914,6 +918,10 @@ out_eot:
 	case 'K':
 		free(eh.link);
 		eh.link = malloc(st.st_size + 1);
+		if (!eh.link) {
+			ret = -ENOMEM;
+			goto out;
+		}
 		if (st.st_size > PATH_MAX || st.st_size !=
 		    erofs_iostream_bread(&tar->ios, eh.link, st.st_size))
 			goto invalid_tar;
-- 
2.43.0


