Return-Path: <linux-erofs+bounces-3149-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB8zFaa3zGnMVwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3149-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 08:13:58 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 842FE37518C
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 08:13:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flvnY5xtQz2ySY;
	Wed, 01 Apr 2026 17:13:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775024033;
	cv=none; b=FhU8ofdKQ+R5IgQxFLDAFqU287/NYXQHSxSjSwe4yYvMTnEm8xtqO+6T0E66185iPC/iHrHXgCj4gLZ+PmQ4YEmy5rAFzj4F+M7XAXtvFr2dljtWsD3wwzNiTDmjRhrvoYDfr1b0vnZh3GNhwjQZaZ5uagiVExwQaK5PToGs9j+Kd4ocOi6gQLCA6f3evic2ev9dU7Q0uOJofPCEpYauQlGIvA5/FRhkBRGFZ5YkoQu/KTWU60x8SZl7w2yWwHaUcMjUFrxEmuM68BcJIcJlnP9PdJENn9uI52eOcElzMlMVukMNyq63z7gcdFT+tsEF8tUJAjvrY73ac2hDcvJroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775024033; c=relaxed/relaxed;
	bh=h0GP805rFVdOtV+kM1PAPGvvt755NOqBYJxx1e+mwc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkCACSyX8KDGkYvu0GYad/dB4S1fJQuh6YiGCoMbEroi7xgXsazaygRWA+VXJOUUKGatnuLAjrTOI5ZolfcU5fOOwfnoDK2SFHGsBAjUfxJnP90QEi8x5Ol1qPIOpKlmXOYUgH7rj6gRkJlP3yvAjsqWJ1Km6oKklsiIsccUwpVR74nQmx/gL99dW4iyDS8+VDhTyxBsCrQZTUDxUblBjUuGMHrouoIkPbFQa1ISjP/bu0DLxJli/t7XSE0m1mARr6/gK4FKP56dgawUsIoMxUp4JHNGHNscOZpjhBAzQIWN/w8H07edLs4Jb1z5/qlfYko+HTHe66phJxG8zSe64Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qu2fc/du; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qu2fc/du;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flvnX0y9jz2xb3
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 17:13:51 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso4327573a91.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 23:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775024028; x=1775628828; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0GP805rFVdOtV+kM1PAPGvvt755NOqBYJxx1e+mwc4=;
        b=qu2fc/duSdIvOK+xaIbc2LCf8i/8KEDxsdxFJduzLbqNsTX27PQtx4PINm1dlkxKyg
         EBuzstOe8jDF6WIBXHYE224a6i3OXiYhlFsuWPxSg4VMfm977YeAm1kGYTCawWf7G1Bf
         p9rdGF/UMBACOlXr3QKkAfYpDuYfVMuM0cBxBY23t1DgfIhhtbtdKWXSUwLbvBZaOoYa
         l+CUBpJ9PWHbeLt5yhMbdfXhbX9UOoYUkARW3+DgmBqde9kehh99+YUjl9235jcnA3IP
         JuepiSUldJ40CBQOjggGptUWfPooVPGUAum2aMUHUAwIQ2LSlf+WtzPNSx48TQKBqh1n
         cqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775024028; x=1775628828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0GP805rFVdOtV+kM1PAPGvvt755NOqBYJxx1e+mwc4=;
        b=FC/oS8jxifhSwrlZD16sy+M2zFHHD9Ajxwp7uQcctb9HoyP9bbS+Pi9gZyxbq+Bobb
         alUkIRi0HTTL5KxJbt5kYmHGuc/Fsauh64lH6fy7NzNfy02oPHrZBsZ7d83xnDUh+qW6
         If2moCRE6Ih/dNrIeslIo3pKkIn7lSKdkgRbTzhPuM4JDYJyW042xFgOc53kxzZkTcs0
         CGy8kdj+sPCLRtGhLaKkEhqWy6qh+Hb/cPRLe4Vm18FRK/YgcNel99WZdDwScKwxdEJc
         PE4UD7kBq14XivU/RWdFce5T/Y5EttTF8jvP0YSw/UILjac7wnqEG6eU0pNnXNgSLt22
         pf0Q==
X-Gm-Message-State: AOJu0YxnTQ7BpyhUvuuiFUYYi8Wa8QGdUpn6K0NoVL/tYq2zdNKGnzj4
	51Ca7VD6M5zAqzWiwqvAmJZVGrtY6DXw3rv0dR6n3V61HFxkwHxuQASS
X-Gm-Gg: ATEYQzwZKJTgpHO8fkPHwnuizUYu7m0h9zd20vEVP/HQ7EFd1UjlDCLT/bpPKQNPOOI
	NaWaXUGtr/Ol6ZG6SfCk2bM8JRFppiJ/UdAVEO2UbR/XC0hY+tQypKANZUUqeLWIZQtkGow1XS7
	hRhFglePzjrexWSvCldrV3vkPYQyyLm7akPmm8nCpQZz7a0uMRJT61M5hbBU+JyfE06M63v5Kuf
	GeQbuNV9JqMsAAOsGIEkmUKguR/IP7N2Z4SVeKECjlC/ELyYfbPQ4eQlCZ7Tt8c6OLEsE3UJVD9
	FQcfZ3djDHWwsgST6/uuHhgNgrNOsGVP71RVmM6Ilv8YXZAdzcEp/Jy848vANIUvGYQcjdPH1fD
	K4/bC70kmYNFHWHQ4/BojO0BVRNQkrm+bnN+1QJRAmOCrBv3Ron/oyjZvuL29QUUTmlQKYeW2zQ
	fWd2NMsnBuVJ3DxAFpgrh+Mb+8swZIJubQ6PPGYzIJWOhDfmE=
X-Received: by 2002:a17:90b:57c6:b0:35d:a542:2dcb with SMTP id 98e67ed59e1d1-35dc6fae2ecmr2167847a91.16.1775024028144;
        Tue, 31 Mar 2026 23:13:48 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe668b24sm3692305a91.8.2026.03.31.23.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:13:47 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] erofs: include the trailing NUL in FS_IOC_GETFSLABEL
Date: Wed,  1 Apr 2026 14:13:42 +0800
Message-ID: <20260401061342.40166-1-zhanxusheng@xiaomi.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3149-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 842FE37518C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofs_ioctl_get_volume_label() passes strlen(sbi->volume_name) as
the length to copy_to_user(), which copies the label string without
the trailing NUL byte.  Since FS_IOC_GETFSLABEL callers expect a
NUL-terminated string in the FSLABEL_MAX-sized buffer and may not
pre-zero the buffer, this can cause userspace to read past the label
into uninitialised stack memory.

Fix this by using strlen() + 1 to include the NUL terminator,
consistent with how ext4 and xfs implement FS_IOC_GETFSLABEL.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/erofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 4b3d21402e10..a188c570087a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -351,7 +351,7 @@ static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)
 		ret = clear_user(arg, 1);
 	else
 		ret = copy_to_user(arg, sbi->volume_name,
-				   strlen(sbi->volume_name));
+				   strlen(sbi->volume_name) + 1);
 	return ret ? -EFAULT : 0;
 }
 
-- 
2.43.0


