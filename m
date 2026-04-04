Return-Path: <linux-erofs+bounces-3200-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF6nBovL0GkkAQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3200-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 04 Apr 2026 10:27:55 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB8339A694
	for <lists+linux-erofs@lfdr.de>; Sat, 04 Apr 2026 10:27:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnpcj0gnhz2yYJ;
	Sat, 04 Apr 2026 19:27:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775291269;
	cv=none; b=PM32xUQPsVak7KvUaefZhdio0IKtlPomU8ggLDHXfGoJYCRhea81uBJEAlXDdGQ46dAjgKUqWq8BVw3KeELxBU8GeoZ11YS+UW8lcJhiGB2oqKibaR+FJVZaQWibmvG3tASrqxD0ccx9N2FIBDHo7pWPksnxvp2MPWwRUp8XIsi238NA/9LC0tM9XrrKy/Qsc8IrAEOGKpqMMHXEUeaT9wYIiXIzEWktkTBtkCzomrMKB/DWgsT4M6eoNjjBIRuZDQxmOLC2uWUBuXHzA/9jHhVUKMmwxZllH9NkZvvjQ5CCEIb9mVM0TcpKqFUQj5MaOhgnRPrx6M0bjvHQINuZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775291269; c=relaxed/relaxed;
	bh=HEFhvfDAYxNdFeR22ErJKW41MiTbqd7uNIRu4WnkxVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nx4gfBvyQ6D6bDoyFaswugVgWfWgDUkXdk9MhS7jy+l7NAixiDpdOCd4S6ODoncLK3Jg5V82Rn96OMQ4zW9egt8uboPP9mnueqpmIogxPXCeudHJLbPfnVZCh+1FEJKhfWrSeUqS53I18CxVWG9nQ9EyZVRPjCz3W2jCHHtQtUvFgByXunW6E/Kdi0P2zFtNuECyv6YBe/s8wflgcQQVMB0Yzf52aieIayOrqPwZpwMhhZAXHypeB97Vtaiwp5bGMUi7LEv270TmY4KmaPrt3QpZJ2xdjwkZ4YKmekaKt1lQDpNs49gYDBMuilzNnDCI3f/mK3F2+YAKnP57sttpDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qqIdG2qO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qqIdG2qO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnpcg3GZdz2yVB
	for <linux-erofs@lists.ozlabs.org>; Sat, 04 Apr 2026 19:27:46 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2a871daa98fso20308475ad.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 04 Apr 2026 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775291264; x=1775896064; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEFhvfDAYxNdFeR22ErJKW41MiTbqd7uNIRu4WnkxVA=;
        b=qqIdG2qOm65H4lHSL2vlXBQN4Lj5Ewaj8iegL9l2f65Vkd3dNHZrG4rzMoNCz2IiPT
         oMN6MalIiWxMDR/Dvl+047Z2Nx7t6XsPr9/X3oJZeMPG/Eqax/RG1r1OVRLQ1Glt+UiS
         OIaTX/Vob+fz5hbxGbwjpF8rLIgCZfdUnnKQ2t3odySNXz63EiPOReEeSo4xgZgoH6HN
         VRGUe0Uwq2E/HQypxjgK4ozgIpJxeogBU1s+7XinruP9vN2sSNbC1BlUhCmt2x4rdqJ3
         f42/pSWR555ivXQS3G4eJHYLLJxdNqr7o+vT5ko5ecNEf0gUsxRCLVIKjnZVjdB0lNHr
         SoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775291264; x=1775896064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEFhvfDAYxNdFeR22ErJKW41MiTbqd7uNIRu4WnkxVA=;
        b=QopMVNXXEnWQgSoNrqzR0WBurMCkrURVBoHQ95VALjwmfGrPJ6pqv/3qzaqgh2nlda
         IFvil1K/SzA4+1FEqiWiYFg7fbIpdJxLE5AYmQFYGMQ2jTBlpg75ISPD+bCMz1abm1uz
         TeoLPiwuh86H4mVl345DMIzyKaALnKEyC00Hn+8JVHTl2GTdHS6i4v6K0NAiqaqLebzL
         WJpeN2WMDafmF3atuQgjrvtAv5wAeNqArrXsLHz5+GuWUlQTCHlz6Btoqmu501I/u7pq
         yIA7rneyKbC2Qu/Rw4/1aIe3gJqPYpe5xM7Af7MUiGk+P5AD7ytlw/YhxdItrJ3hHODj
         Kf6w==
X-Gm-Message-State: AOJu0Yxyvuvvt4XYS25kPH3vntOE1emUHq2zDqUk3yzoyVYEuul9w4wQ
	eopEvJDqW5hAttZ6uyl4G75W621urgoE/ojGsnNE6AE2qvAuPqnIrsVDGvVDocVU
X-Gm-Gg: AeBDievSVwaaGi7QCASRSixlwErG6IQWY3v0DeXRIpDHtYJ62Li3L4oZfrV6NUTv3/7
	pXeNNQaMwYnTVP/2y1BNhvu7I/XPozVFMlJANprj8dIa0t6nEHkfdgy8VyfO3xatfhuLR4OqqDZ
	8B8ShZ88vCGEmp0o6mUuR8PwqyOOYkGOM8O2f+5qxINO6daXd/5l4VxNE0kKiSUdimKL/RKUpXd
	fvjY2xesGdrkOBPfuUZN/2GmjIuTKLHw+iyS+fxgAsf6nq2X/1JfitrW4uH7Gy3IqTAwpfTkj3O
	Jo94vEQxSh7MbTtSau4/289wLW2i29slI0m+VSo8BFdOF0+QZh+wUAp283WbL/dqqQsV9M5tDBf
	3d8q8pXI5CkXhTqkHZlEFsfLRXlWEmb5sDd4+PJjGvD3R+AxFdpUT1dGbpfd662Bj9Ku6VZDK1E
	x0Eg8VJlsAS1P3Fn1u9RHju2DcuHvL9aLon13RDeOuhbOlQW4MjZafe080
X-Received: by 2002:a17:903:1984:b0:2b2:4c58:5ba7 with SMTP id d9443c01a7336-2b2818014c8mr63804635ad.30.1775291264264;
        Sat, 04 Apr 2026 01:27:44 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d5e5sm98262035ad.15.2026.04.04.01.27.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Apr 2026 01:27:43 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	xiang@kernel.org,
	nithurshen.dev@gmail.com
Subject: [PATCH] erofs-utils: s3: fix memory leak in s3erofs_create_object_iterator
Date: Sat,  4 Apr 2026 13:57:37 +0530
Message-ID: <20260404082737.87032-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3200-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4AB8339A694
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In s3erofs_create_object_iterator(), if the parsed prefix length
exceeds S3EROFS_PATH_MAX, the function aborts and returns an
-EINVAL error pointer. However, the 'iter' structure was already
allocated via calloc() and left unfreed, causing a memory leak.

This commit adds the missing free(iter) call in the error path to
prevent leaking memory when excessively long S3 bucket paths are
provided.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/remotes/s3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 768232a..94b4ffb 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -911,8 +911,10 @@ s3erofs_create_object_iterator(struct erofs_s3 *s3, const char *path,
 		iter->bucket = NULL;
 		iter->prefix = strdup(path + 1);
 	} else {
-		if (++prefix - path > S3EROFS_PATH_MAX)
+		if (++prefix - path > S3EROFS_PATH_MAX){
+			free(iter);
 			return ERR_PTR(-EINVAL);
+		}
 		iter->bucket = strndup(path, prefix - path);
 		iter->prefix = strdup(prefix);
 	}
-- 
2.52.0


