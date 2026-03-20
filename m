Return-Path: <linux-erofs+bounces-2885-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AG9Af1SvWlr8gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2885-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 15:00:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A71FB2DB812
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 15:00:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fckjN6pwjz2yYY;
	Sat, 21 Mar 2026 01:00:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774015224;
	cv=none; b=Ya9yXsFuoSyxY139jlb9a87Sx+AMc5MrPU+xWuHVz+uWLnJZiFiGe8SkxqIwQpi0c9DWsOBbmp1STS0AJ8S5huQvBVdNe/5L9fy09+dsjbn2QVVgcBIbT2oGoPedBU+vjpcuzi7weyyOWF89TrXp2bXlWwvJ9y2cG1KK4oUuTTkv0P7T4ZsPPSgUBoa3Z2N7S0YjOGW1G0ifit3eXWh0CmJP1fggvXgXNYiTfIYijOo68MXmjiz+SYuw2SBoCmIZaVXleCl8bh2q9GIJMVBu9+LXOkZuQdop2XgK2htmCyF3hDL3g30L4hy+2VuE8B+o+rYzMa1aXhMcUnJpSaQn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774015224; c=relaxed/relaxed;
	bh=arPXkcesHZ1dOeq5afvMUC6T8Tm4FuRRLHxf2XqJscI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PJru3OETAg/eRSl3db0fw3hI1/2rJiP3Ru0LjNANqoOl4vEtkDnnuW6N0tNPDyhIoaN5RyIY43hykjBF/GivVWteRZyrPMTWzcZi/NgJ1E7YA/x7xiidqRgjh+CAxaHKIQd7nXQVs5PufS0NOrM6ReakWf30fTIv2Ng42GRpSofNdBV3f4+DmnVPWoY7cKT9CErATRxKo9NFIoHdHXLOyjG+9GXurAQmr3fSVDlZL4zETASL6yv624vUaVYyyDRnDfVO+Wo6v2fmaTYSyIs2eRc0QAbqSDEiyXbZWZPsGhFMQ9/I/30u+NkTJ0BsAtTtoD9TLAme6coUp4wMIdyp0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CuYVrvvN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=reach.netway@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CuYVrvvN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=reach.netway@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fckjM6pJmz2yY1
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 01:00:22 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so920188a91.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774015219; x=1774620019; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=arPXkcesHZ1dOeq5afvMUC6T8Tm4FuRRLHxf2XqJscI=;
        b=CuYVrvvNdLD93nmCU2ARofHFkHWFUfRSYXTOCZ2QL0fkl3Xc+ikmyuH6VlsYh39WYb
         HDRr++AyWNuAAjS7wZLEeAQGBPgNmKikLZX0G6vIQu47nmJDN15E8Z0E45Ap5NbwtF6h
         0/zWHBMgXTvlsXZj2YWFUDg2jAomb/WNqhC1H5eAZvv8wtkkde1G0fvlGgWM5YEjn04H
         HQpvV1LzmhHatfmHBq4TkF3KdwnS6Q0bUPsyl2ovaMhMIWZzZE9Krn03FcswvJARjHU+
         V7hqqSpcIHl39GEuOniAO7EToerTMv+vykHBx19YM67xw7ih5O7J4KPshpVWd5i0Xb0L
         K9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015219; x=1774620019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arPXkcesHZ1dOeq5afvMUC6T8Tm4FuRRLHxf2XqJscI=;
        b=fIz54zXdNGyRtFesD6yxiJZ8qwKDfDzgtQR09W1d5bzUJW20FB35AQ1fmUChG8ngvl
         Cv4aTOmTOzN9eQ7N1zHUsEzzzfN5h9Rrb0DowAvzWvEMsdGaPXpFHDRWMZmwmUhKxTGF
         mfNkgoe/BW3Z+nAKvoNfcqSjJEDOKYhKBDdUk5vT0h5cg7fDOfTLCVAIsOQPniwMZSTH
         NYJvVf89r2NJhxM/TQ9JMIaJYQA+NRDEA+yRc82hYhmIYaR1SazMoVSvKynUeM+qnTvl
         FmngWdJ1PHlJ01URti86EgNXsTOLoHwkav/gjpJJlZB0hhPSeMNjXN7WbllG7hSJUNO2
         Gsvw==
X-Gm-Message-State: AOJu0YzyCjHweX96PyJHQgaiVTHd8uPS5TmB1+ZgK5VNdY7Ap1nfTMcA
	mx1+6wXxKWyizIAHUfQfaQ/wgaKIX0CK9fNZi7B9NLBDHV3aF7cZZ0EL06c9htEb36A=
X-Gm-Gg: ATEYQzx+4aO+jQiXmBIP90BUEhgLpcMt10JniCxk1eUB2Zis5yjPq+M1wfNdYC3ieeY
	dVWA5sFrNykW8tr0D6m+43lyCkvPPvBPGn62Ceceo7xJpz8kEqIK0KaSajdpkGxlNn6wtgIr+Vm
	6vTVgAUjxB+ESkpjWvVFGAKKjvYhRilLhvb/6Hcc4IhHLs2TnO3Odim/imemxOh4Vpm9ZV3ol9I
	uZXr9tbvI6UtG2NgO7ux4MEBlmI8M4LK87FQA7FgMDNJTQs52UvG17hlfJDqq08LPtCC1JDUqgO
	xonrKP8Yh4WE/4tx+yIvwEAsjvAsDs3B1iUW2l/89MysdaR7JJWU3i4ZDBbcHcYuc+lxTF8iSyY
	hIhhRUzGkxw2A4anryTmQPouF6UcCzrdzVphJ1Aup/rQ/uwJAX8IrFcoryS7nRPAUFfLesm2QuS
	FR4LKq/OZ0MtbGdcw0j28v5AKLXQf5AVbKXPfK
X-Received: by 2002:a17:90a:e7cb:b0:359:83d3:27d3 with SMTP id 98e67ed59e1d1-35bd2b937f5mr2409913a91.2.1774015219236;
        Fri, 20 Mar 2026 07:00:19 -0700 (PDT)
Received: from pop-os.. ([2402:b400:4650:2120:10b1:d05f:a776:a6f0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3eb46b2sm2302394a91.2.2026.03.20.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:00:18 -0700 (PDT)
From: oz456 <reach.netway@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	zhaoyifan28@huawei.com,
	oz456 <reach.netway@gmail.com>
Subject: [PATCH] lib/metabox: fix 48-bit layout metablock addressing
Date: Fri, 20 Mar 2026 19:29:33 +0530
Message-Id: <20260320135934.67331-1-reach.netway@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-2885-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[reachnetway@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A71FB2DB812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set meta_blkaddr to 0 for 48-bit layouts instead of EROFS_META_NEW_ADDR to properly support large filesystems.
Tested on normal and 48-bit layouts; meta_blkaddr is correct.

Signed-off-by: oz456 <reach.netway@gmail.com>
---
 lib/metabox.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/metabox.c b/lib/metabox.c
index 12706aa..5e55cae 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -62,8 +62,10 @@ int erofs_metadata_init(struct erofs_sb_info *sbi)
 		if (ret)
 			goto err_free;
 		sbi->m2gr = m2gr;
-		/* FIXME: sbi->meta_blkaddr should be 0 for 48-bit layouts */
-		sbi->meta_blkaddr = EROFS_META_NEW_ADDR;
+		if (erofs_sb_has_48bit(sbi))
+			sbi->meta_blkaddr = 0;
+		else
+			sbi->meta_blkaddr = EROFS_META_NEW_ADDR;
 	}
 
 	if (!sbi->mxgr && erofs_sb_has_metabox(sbi)) {
-- 
2.34.1


