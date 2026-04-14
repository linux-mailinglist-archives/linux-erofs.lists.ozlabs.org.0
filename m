Return-Path: <linux-erofs+bounces-3291-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG2vL4lL3mkzqAkAu9opvQ
	(envelope-from <linux-erofs+bounces-3291-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:13:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1E63FAEDA
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2026 16:13:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fw5pt502Wz2yYs;
	Wed, 15 Apr 2026 00:13:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776176006;
	cv=none; b=HrWAjEZhDxzoUO6yOHcCgoF6JZkiBie9qkgwAicmoigOnVR4G1S1kSiGBEffC7JHFtXB/VGxcy4Sb4+OcNSDI/edz6rY1+Hc3c4VcnVuGfF3pdYN/zy/6mBEOahg3XxUkRAuNZ85qCoc8FFms+w64HaIPc4tC9yU9VT1ipjtGEQbp0nep5hhU7GYgB+SBx0dDdBTwnbLOP0Ppj7qaIkj6lkzLgWocDqkv3D4fVXdrtEiasrHqJ8MSK0xWMRaDEo9kKT9Ggm7yDT0mboIm1iMdCUwasNj4gQOWvQQ7FjgMznYzVZYKQFalm/idMNGwF32n4vdNYbK2BNrAWKDVXgs0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776176006; c=relaxed/relaxed;
	bh=nkuC1/6M0KgX4uBHO1mcQC2I0J4xM63pvdeRBFcVyEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW8+lGW4EE+wdxYIbt2O7JG/8sos1rkr+Yjlb1stlLoxXkf/qoYKBIyv//zxnzvhcIJBQNYbudAup8fgXa5OB4/w2AFEpDXX/6wA5qIOK2NkQUDDtEe/kYJ0I1YIPcpoI/FMTeqXxqEyMYL3LfYJXKQCeZB8DIXduW/FCWk2ESU8Ro295334YxVP8eldY0m6aF8Cvn2PKwmgwksuI/uHflsJozew3m7kVrzriMQ19Z7VSJFiuGm0i/UetTzMDz/JrgXtlZbCn7J/sktCQsgb8Qr+ypfN6nKaeTBUi40EJTqc7Ku1BtbWGuwqjveBAHPGbLeRTV/bOdtE3O9aeQnXjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tChuga2A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tChuga2A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fw5ps6vj4z2ySS
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 00:13:25 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c76c60c7502so2222836a12.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 14 Apr 2026 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176004; x=1776780804; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkuC1/6M0KgX4uBHO1mcQC2I0J4xM63pvdeRBFcVyEs=;
        b=tChuga2A5JbCTZW8NQrJOfPdfRiUwXDteGbkSwi53Y6svGJxyrrdJEZQWOT2T7A06P
         gZA5UV4VdcxstClHjywaGga6vUL7gG2vwbkTy3XyWkkKkOWXkdxN8wKSJLOl6l45eTwN
         sdN1dEQNsjFaG5XYClv1A+Aet0prP0vcMvbTXVtJy6Bzg1ME5jX3Z8CvTH2bFiRIJwtP
         3owWXAnj6APRdtTS7hN8yBjLL4G15qUAqPmNUeuFYRi+Gg4eU+ALiAGQp+d5ji4sDg9l
         T5l81Hr0iBlxr3RJD47RIwyU0AWPvLIQZdC3BXJ7TTrGQHFPVu4GCISW1jOUoiE1Xa2Y
         uGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176004; x=1776780804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nkuC1/6M0KgX4uBHO1mcQC2I0J4xM63pvdeRBFcVyEs=;
        b=SfBhTg6RXB+Pu3QaUv2zsj4ME2ih/F3oQhhuZrjx3px5Zl4r3tMd+g4poFAyvVAJBw
         CxXc5iotWGallmzTq1gIoPQgXyXFsrHeAJUn/EZN7rg07OApXhbL31XtaRFrRyjKAJ42
         jmjxi0d7kL/zJA93ymHbbNOH3otRFZpg/SlmW3pPE4De0QrFFiR3tyyYSRyDK81RtKwP
         tQQygQexaLk2FUEMPJs+7G8sk9Fep8qk/xr+1EuupLWuHZzJX2j43AK2H6aTinlYgEQ/
         ZfyLL+y++GvQwDZBMiwuU4OzB35enHr+XEXt9ruU8Mc8ZiwfPi1pL760b10nKMRJznje
         nvaA==
X-Gm-Message-State: AOJu0YzJPktPMINweg49FiYW/PMbaI7TbdPmrfRpp81/lgVoAgukXivn
	gIVEsnOhgbRzDj+XWxuOsjCII1MspIEQKmkB0a6PtkcUg+kVefENFYGr
X-Gm-Gg: AeBDieuZclFx3oHzYL8HeRfy63OOfeaC4bbztWYeEJoRDWzYbdK/t6z/JHK31Q8Yeje
	md2Qq0Uk0uNg0o9yu7OIYpvSn+seWok5pzztJBhTSrtvWoezqVsnFW9B1lZv5myoJXCCemKErOL
	zJv9t1SnjRpJUNlESgRVF7VR40bepkwPwg6jUDoJinRK5qCd6QB7CAnS38VhiLcpF9O+no8+KUE
	+cecq2oT1Bj1VmvgtWFkMy7+Ks9Es9FunDM9hlIROZOeqlbpggeWij0H6pM70tYTMkiHgHflU7h
	YoZlEZ5YSzPuSal0wmk1Z0KUj08eExgbpS8uZpwfW3rSWjhzkxL/w46tsW3RRLhlswuQQNuYEt/
	NKzrYAQ+efr+BWkMRvE8t4vUK5ooDsyyTiKOCnUHxiLnn/LtBA8Hu8yLLfoheKnKFGT3phUXkOA
	OEre3qMt0c5rM5b+4PQT01bsHCJx6zm5tIGM2leZ5sivg8nnI=
X-Received: by 2002:a17:903:37cf:b0:2b2:3eec:c75b with SMTP id d9443c01a7336-2b2d5c5567bmr140429525ad.2.1776176003631;
        Tue, 14 Apr 2026 07:13:23 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b3a73747b8sm81197315ad.47.2026.04.14.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:13:23 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH 1/2] erofs-utils: tar: fix out-of-bounds access when trimming pax path
Date: Tue, 14 Apr 2026 22:13:12 +0800
Message-ID: <20260414141313.46575-2-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414141313.46575-1-zhanxusheng@xiaomi.com>
References: <20260414141313.46575-1-zhanxusheng@xiaomi.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3291-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1D1E63FAEDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a PAX extended header contains a path consisting entirely of '/'
characters (e.g., "path=/"), the trailing-slash trimming loop in
tarerofs_parse_pax_header() decrements j to 0, then accesses
eh->path[-1] which is an out-of-bounds heap read.

The tar header path trimming had a similar issue fixed by commit
dcd06f421003 ("erofs-utils: mkfs: tar: fix SIGSEGV on `/` entry"),
but the PAX header path trimming was not addressed.

Add a j > 0 guard to the while condition.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 lib/tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tar.c b/lib/tar.c
index eca29f5..3d92f48 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -509,7 +509,7 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 				int j = p - 1 - value;
 				free(eh->path);
 				eh->path = strdup(value);
-				while (eh->path[j - 1] == '/')
+				while (j > 0 && eh->path[j - 1] == '/')
 					eh->path[--j] = '\0';
 			} else if (!strncmp(kv, "linkpath=",
 					sizeof("linkpath=") - 1)) {
-- 
2.43.0


